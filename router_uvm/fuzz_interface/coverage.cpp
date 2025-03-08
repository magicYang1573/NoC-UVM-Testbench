#include <stdio.h>
#include <stdlib.h>
#include <sys/param.h>
#include <covdb_user.h>
#include <iostream>
#include <vector>
#include <queue>
#include <map>
#include <fstream>
#include <string> 

#include "coverage.h"

using namespace std;

/*
    function: load_design

    input: vdb coverage database path

    return: design handle
*/
covdbHandle load_design(string vdb_str) {
    covdbHandle design_hdl = covdb_load(covdbDesign, NULL, vdb_str.c_str());
    if (!design_hdl) {
        printf("Failed to load design %s\n", vdb_str.c_str());
        exit(-1);
    }
    else {
        // printf("Load design %s Success\n", vdb_str.c_str());
    }
    return design_hdl;
}

void printAvailableTests(covdbHandle designHandle)
{
   covdbHandle testNameHandle, availableTests = covdb_iterate(designHandle, covdbAvailableTests);
	 printf("UCAPI Info: Design, %s has the following tests available:\n", covdb_get_str(designHandle, covdbName));
	 while(testNameHandle = covdb_scan(availableTests))
	 {
	    printf("\t%s\n", covdb_get_str(testNameHandle, covdbName));
	 }
	 covdb_release_handle(availableTests); // handle is persistent
}

/*
    function: load_test

    input: design handle, test name string

    return: test handle
*/
covdbHandle load_test(covdbHandle design_hdl, string test_str) {
    // printAvailableTests(design_hdl);

    covdbHandle test_hdl = covdb_load(covdbTest, design_hdl, test_str.c_str());
    if (!test_hdl) {
        printf("Failed to load test %s\n", test_str.c_str());
        exit(-1);
    }
    else {
    //    printf("Loaded test %s Success\n", test_str.c_str());
    }
    return test_hdl;
}


/*
    function: get_metric_hdl

    input: test handle, metric name string

    Metric Name: Branch, Condition, Line, Tgl, Assert, testbench

    return: metric handle
*/
covdbHandle get_metric_hdl(covdbHandle test_hdl, string metric_str) {
    covdbHandle mets_hdl, met_hdl;
    covdbHandle dst_met_hdl = NULL;
    mets_hdl = covdb_iterate(test_hdl, covdbMetrics);
    while((met_hdl = covdb_scan(mets_hdl))) {
        if(!strcmp(covdb_get_str(met_hdl, covdbName), metric_str.c_str())) {
            dst_met_hdl = met_hdl;
	        dst_met_hdl = covdb_make_persistent_handle(dst_met_hdl);
            break;
        }
    }
    covdb_release_handle(mets_hdl);

    if(!dst_met_hdl) {
        printf("Metric %s not exist\n", metric_str.c_str());
        exit(-1);
    }
    return dst_met_hdl;
}


/* 
    function: get_metric_inst_hdl

    input: design handle, metric handle, instance name string

    return: metric qualified instance handle
*/
covdbHandle get_metric_inst_hdl(covdbHandle design_hdl, covdbHandle met_hdl, string inst_str) {
    //serch target instance, bfs
    covdbHandle unqInsts_hdl = NULL;
    covdbHandle unqInst_hdl = NULL;
    covdbHandle dstInst_hdl = NULL;
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(design_hdl);
    while(dstInst_hdl==NULL && !inst_hdl_q.empty()) {
        unqInsts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        while(unqInst_hdl=covdb_scan(unqInsts_hdl)) {
            if(!strcmp(covdb_get_str(unqInst_hdl, covdbName), inst_str.c_str())) {
                dstInst_hdl = unqInst_hdl;
                break;
            }
            unqInst_hdl = covdb_make_persistent_handle(unqInst_hdl);
            inst_hdl_q.push(unqInst_hdl);
        }
        covdb_release_handle(unqInsts_hdl);
        covdb_release_handle(inst_hdl_q.front());
        inst_hdl_q.pop();
    }
    while(!inst_hdl_q.empty()) {
        covdb_release_handle(inst_hdl_q.front());
        inst_hdl_q.pop();
    }
    if(dstInst_hdl == NULL) {
        printf("Instance %s not exist\n", inst_str.c_str());
        exit(-1);
    }

    covdbHandle met_inst_hdl = covdb_get_qualified_handle(dstInst_hdl, met_hdl, covdbIdentity);
    met_inst_hdl = covdb_make_persistent_handle(met_inst_hdl);

    if(!met_inst_hdl) {
        printf("Get metric qualified instance failed\n");
        exit(-1);
    }

    return met_inst_hdl;
}


/*  
    function: get_line_cov_all
    
    get line coverage of a instances and its sub instances

    input: a line-metric qualified instance handle, test handle

    process:
    1> bfs for instances;
    2> get covdbBlocks under a metric-qualified instance
        {
            1. get process/always block
            2. get basic block
        };
    3> get the all of the line coverage of the instance tree ;
    
    return: cov_map<bool>, 1 means this basic block is hit
    (line coverage doesn't record hit count)  
 */

vector<bool> get_line_cov_all(covdbHandle met_inst_hdl, covdbHandle test_hdl) {
    
    vector<bool> cov_map;
    // traverse instances tree
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(met_inst_hdl);
    while(!inst_hdl_q.empty()) {

        // traverse always block / process covdbContainer
        covdbHandle objs_1_hdl = covdb_iterate(inst_hdl_q.front(), covdbObjects);
        covdbHandle obj_1_hdl;
        while(obj_1_hdl=covdb_scan(objs_1_hdl)) {
            obj_1_hdl = covdb_make_persistent_handle(obj_1_hdl);

            // traverse basic block covdbContainer
            covdbHandle objs_2_hdl = covdb_iterate(obj_1_hdl, covdbObjects);
            covdbHandle obj_2_hdl;
            while(obj_2_hdl=covdb_scan(objs_2_hdl)) {
                if(covdb_get(obj_2_hdl, NULL, test_hdl, covdbCoverable)>0) {
                    cov_map.push_back(covdb_get(obj_2_hdl, NULL, test_hdl, covdbCovered)>0);
                }
            }
            covdb_release_handle(objs_2_hdl);
        }
        covdb_release_handle(obj_1_hdl);
        covdb_release_handle(objs_1_hdl);
        
        // add sub instances to queue
        covdbHandle insts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        covdbHandle inst_hdl;
        while(inst_hdl = covdb_scan(insts_hdl)) {
            inst_hdl = covdb_make_persistent_handle(inst_hdl);
            inst_hdl_q.push(inst_hdl);
        }
        covdb_release_handle(insts_hdl);

        if(inst_hdl_q.front()!=met_inst_hdl) {
            covdb_release_handle(inst_hdl_q.front());
        }
        inst_hdl_q.pop();
    }

    return cov_map;
}


/*  
    function: get_cond_cov_all
    
    get all condition coverage of a instance and its sub instances

    input: a condition-metric qualified instance handle, test handle

    process:
    1> bfs for instances;
    2> get table containers under a metric-qualified instance;
    3> bfs for table to get more containers, and get corresponded covdbCross,
       A covdbCross is a condition;
    
    return: cov_map<bool>, 1 means hit
    (condition coverage doesn't record hit count)  
 */
vector<bool> get_cond_cov_all(covdbHandle met_inst_hdl, covdbHandle test_hdl) {
    
    vector<bool> cov_map;
    // traverse instances tree
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(met_inst_hdl);
    while(!inst_hdl_q.empty()) {
        // get condition tables covdbContainer
        covdbHandle tables_hdl = covdb_iterate(inst_hdl_q.front(), covdbObjects);
        covdbHandle table_hdl;
        while(table_hdl=covdb_scan(tables_hdl)) {
            table_hdl = covdb_make_persistent_handle(table_hdl);

            // traverse containers of condition tree
            // get cross 
            queue<covdbHandle> con_hdl_q;
            con_hdl_q.push(table_hdl);
            while(!con_hdl_q.empty()) {
                covdbHandle cons_hdl = covdb_iterate(con_hdl_q.front(), covdbObjects);
                covdbHandle con_hdl;
                while(con_hdl=covdb_scan(cons_hdl)) {
                    if(covdb_get(con_hdl, NULL, test_hdl, covdbType)==covdbContainer) {
                        con_hdl = covdb_make_persistent_handle(con_hdl);
                        con_hdl_q.push(con_hdl);
                    }
                    else if(covdb_get(con_hdl, NULL, test_hdl, covdbType)==covdbCross) {
                        if(covdb_get(con_hdl, inst_hdl_q.front(), test_hdl, covdbCoverable)>0){
                            cov_map.push_back(covdb_get(con_hdl, inst_hdl_q.front(), test_hdl, covdbCovered));
                        }
                    }
                }
                covdb_release_handle(cons_hdl);
                covdb_release_handle(con_hdl_q.front());
                con_hdl_q.pop();
            }
        }
        covdb_release_handle(table_hdl);
        covdb_release_handle(tables_hdl);
        
        // add sub instances to queue
        covdbHandle insts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        covdbHandle inst_hdl;
        while(inst_hdl = covdb_scan(insts_hdl)) {
            inst_hdl = covdb_make_persistent_handle(inst_hdl);
            inst_hdl_q.push(inst_hdl);
        }
        covdb_release_handle(insts_hdl);

        if(inst_hdl_q.front()!=met_inst_hdl) {
            covdb_release_handle(inst_hdl_q.front());
        }
        inst_hdl_q.pop();
    }

    return cov_map;
}

/*  
    function: get_branch_cov_all
    
    get all branch coverage of a instance and its sub instances

    input: a branch-metric qualified instance handle, test handle

    process:
    1> bfs for instances;
    2> get "top-level branch statement" containers under a metric-qualified instance;
    3> get "branch vector" covdbCross under that statement,
       A "branch vector" is a branch path in that statement;
    
    return: cov_map<bool>, 1 means hit
    (branch coverage doesn't record hit count)  
 */
vector<bool> get_branch_cov_all(covdbHandle met_inst_hdl, covdbHandle test_hdl) {
    
    vector<bool> cov_map;
    // traverse instances tree
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(met_inst_hdl);
    while(!inst_hdl_q.empty()) {

        // get "top-level" branch statement covdbContainer
        covdbHandle stats_hdl = covdb_iterate(inst_hdl_q.front(), covdbObjects);
        covdbHandle stat_hdl;
        while(stat_hdl=covdb_scan(stats_hdl)) {
            stat_hdl = covdb_make_persistent_handle(stat_hdl);

            // get "branch vector" covdbCross
            covdbHandle cros_hdl = covdb_iterate(stat_hdl, covdbObjects);
            covdbHandle cro_hdl;
            while(cro_hdl = covdb_scan(cros_hdl)) {
                cov_map.push_back(covdb_get(cro_hdl, inst_hdl_q.front(), test_hdl, covdbCovered));
            }
            covdb_release_handle(cros_hdl);
        }
        covdb_release_handle(stat_hdl);
        covdb_release_handle(stats_hdl);
        
        
        // add sub instances to queue
        covdbHandle insts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        covdbHandle inst_hdl;
        while(inst_hdl = covdb_scan(insts_hdl)) {
            inst_hdl = covdb_make_persistent_handle(inst_hdl);
            inst_hdl_q.push(inst_hdl);
        }
        covdb_release_handle(insts_hdl);

        if(inst_hdl_q.front()!=met_inst_hdl) {
            covdb_release_handle(inst_hdl_q.front());
        }
        inst_hdl_q.pop();
    }

    return cov_map;
}

/*  
    function: get_toggle_cov_all
    
    get all branch coverage of a instance and its sub instances

    input: a branch-metric qualified instance handle, test handle

    process:
    1> bfs for instances;
    2> get "top-level branch statement" containers under a metric-qualified instance;
    3> get "branch vector" covdbCross under that statement,
       A "branch vector" is a branch path in that statement;
    
    return: cov_map<bool>, 1 means hit
    (branch coverage doesn't record hit count)  
 */
vector<bool> get_toggle_cov_all(covdbHandle met_inst_hdl, covdbHandle test_hdl) {
    
    vector<bool> cov_map;
    // traverse instances tree
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(met_inst_hdl);
    while(!inst_hdl_q.empty()) {

        // get "top-level signal table" covdbContainer
        covdbHandle tables_hdl = covdb_iterate(inst_hdl_q.front(), covdbObjects);
        covdbHandle table_hdl;
        while(table_hdl=covdb_scan(tables_hdl)) {
            table_hdl = covdb_make_persistent_handle(table_hdl);

            // get signal covdbContainer
            covdbHandle signals_hdl = covdb_iterate(table_hdl, covdbObjects);
            covdbHandle signal_hdl;
            while(signal_hdl = covdb_scan(signals_hdl)) {
                signal_hdl = covdb_make_persistent_handle(signal_hdl);

                // get bit covdbCross
                covdbHandle bits_hdl = covdb_iterate(signal_hdl, covdbObjects);
                covdbHandle bit_hdl; 
                while(bit_hdl = covdb_scan(bits_hdl)) {
                    bit_hdl = covdb_make_persistent_handle(bit_hdl);

                    // get covdbSequence: 0->1 / 1->0
                    covdbHandle seqs_hdl =  covdb_iterate(bit_hdl, covdbObjects);
                    covdbHandle seq_hdl;
                    while(seq_hdl = covdb_scan(seqs_hdl)) {
                        if(covdb_get(seq_hdl, NULL, NULL, covdbType)==covdbSequence) {
                            // Enter bit container
                            cov_map.push_back(covdb_get(seq_hdl, inst_hdl_q.front(), test_hdl, covdbCovered));
                        }
                        else {
                            // Enter dimension container
                            break;
                        }
                    }
                    covdb_release_handle(seq_hdl);
                    covdb_release_handle(seqs_hdl);
                }
                covdb_release_handle(bit_hdl);
                covdb_release_handle(bits_hdl);
            }
            covdb_release_handle(signal_hdl);
            covdb_release_handle(signals_hdl);
        }
        covdb_release_handle(table_hdl);
        covdb_release_handle(tables_hdl);
        
        
        // add sub instances to queue
        covdbHandle insts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        covdbHandle inst_hdl;
        while(inst_hdl = covdb_scan(insts_hdl)) {
            inst_hdl = covdb_make_persistent_handle(inst_hdl);
            inst_hdl_q.push(inst_hdl);
        }
        covdb_release_handle(insts_hdl);
        if(inst_hdl_q.front()!=met_inst_hdl) {
            covdb_release_handle(inst_hdl_q.front());
        }
        inst_hdl_q.pop();
    }

    return cov_map;
}

/*  
    function: get_assertion_cov_all
    
    get all assertion coverage of a instance and its sub instances

    input: a assert-metric qualified instance handle, test handle

    process:
    1> bfs for instances;
    2> get table containers under a metric-qualified instance;
    3> get "assert or cover" containers of table container;
    4> get covdbBlock which represents attempts/success...
       (Unimplemented: manual also mentions assertion path, but I didn't find containers for top-level paths)
    
    return: cov_map<int64_t>, covCount number of a assertion's realsuccess
    (I'm not clear why using vector<int> will cause link error)
 */
vector<int64_t> get_assertion_cov_all(covdbHandle met_inst_hdl, covdbHandle test_hdl) {
    
    vector<int64_t> cov_map;
    // traverse instances tree
    queue<covdbHandle> inst_hdl_q;
    inst_hdl_q.push(met_inst_hdl);
    while(!inst_hdl_q.empty()) {

        // get table covdbContainer
        covdbHandle tables_hdl = covdb_iterate(inst_hdl_q.front(), covdbObjects);
        covdbHandle table_hdl;
        while(table_hdl=covdb_scan(tables_hdl)) {
            table_hdl = covdb_make_persistent_handle(table_hdl);

            // get "assert or cover" covdbContainer
            covdbHandle cons_2_hdl = covdb_iterate(table_hdl, covdbObjects);
            covdbHandle con_2_hdl;
            while(con_2_hdl = covdb_scan(cons_2_hdl)) {
                con_2_hdl = covdb_make_persistent_handle(con_2_hdl);

                printf("%s\n", covdb_get_str(con_2_hdl, covdbName));
                // get covdbBlocks which record attempts, success, etc
                // get covdbContainers which record top-level path
                covdbHandle cons_3_hdl = covdb_iterate(con_2_hdl, covdbObjects);
                covdbHandle con_3_hdl;
                while(con_3_hdl = covdb_scan(cons_3_hdl)) {
                    con_3_hdl = covdb_make_persistent_handle(con_3_hdl);

                    if(covdb_get(con_3_hdl, NULL, NULL, covdbType)==covdbBlock) {
                        if(!strcmp(covdb_get_str(con_3_hdl, covdbName), "realsuccesses")) {
                            cov_map.push_back(covdb_get(con_3_hdl, inst_hdl_q.front(), test_hdl, covdbCovCount));
                        }
                    }
                    else if(covdb_get(con_3_hdl, NULL, NULL, covdbType)==covdbContainer) {
                        // not implemented
                    }
                }
                covdb_release_handle(con_3_hdl);
                covdb_release_handle(cons_3_hdl);
            }
            covdb_release_handle(con_2_hdl);
            covdb_release_handle(cons_2_hdl);
        }
        covdb_release_handle(table_hdl);
        covdb_release_handle(tables_hdl);
        
        // add sub instances to queue
        covdbHandle insts_hdl = covdb_iterate(inst_hdl_q.front(), covdbInstances);
        covdbHandle inst_hdl;
        while(inst_hdl = covdb_scan(insts_hdl)) {
            inst_hdl = covdb_make_persistent_handle(inst_hdl);
            inst_hdl_q.push(inst_hdl);
        }
        covdb_release_handle(insts_hdl);

        if(inst_hdl_q.front()!=met_inst_hdl) {
            covdb_release_handle(inst_hdl_q.front());
        }
        inst_hdl_q.pop();
    }

    return cov_map;
}


/*
    Used in get_testbench_cov function
    If bin do not have its name, generate one according to its sub blocks
*/
string get_auto_cross_bin_name(covdbHandle bin){
    string bin_name_str;
    int isFirst = 1;
    covdbHandle comp, compI = covdb_iterate(bin, covdbComponents);
    while(comp = covdb_scan(compI)) {
        if(!isFirst)
            bin_name_str.append("."); // Delimiter between components
        isFirst = 0;
        string comp_name = covdb_get_str(comp, covdbName);
        if(comp_name.size()==0) continue;
        if(comp_name[0]=='[') {
            if(comp_name.size()<3) continue;
            comp_name = comp_name.substr(1, comp_name.size()-2);
        }
        bin_name_str.append(comp_name); // Append the component name
    }
    covdb_release_handle(compI);
    return bin_name_str;
}

/*  
    function: get_testbench_cov_all
    
    get all testbench coverage (covergroup/coverpoint) under a test handle

    input: test handle, a testbench-metric handle, 

    process:
    1> get testbench metric qualified covergroup definition;
    2> get test qualified definitions;
    3> get point/cross containers, one container means a covergroup/coverpoint;
       (a STL map<string,int> is initialized from here. because UCAPI make some missed bins compressed, we need to rearrange bin's place according to its name) 
    4> get bin table containers;
    5> get bin;
    6> if the bin is compressed, get its separate sub bins;

    return: cov_map<int64_t>, covCount number of every coverpoint's hit count

    (TODO: another function which targets at specific coverpoint/group should be written if needed)
 */

vector<int64_t> get_testbench_cov_all(covdbHandle test_hdl, covdbHandle met_hdl) {
    vector<int64_t> cov_map;
    printf("get testbench cov\n");
    // get testbench-metric-qualified covergroup definitions
    covdbHandle defs_hdl = covdb_qualified_iterate(test_hdl, met_hdl, covdbDefinitions);
    covdbHandle def_hdl;
    while(def_hdl = covdb_scan(defs_hdl)) {
        def_hdl = covdb_make_persistent_handle(def_hdl);
        printf("def: %s\n", covdb_get_str(def_hdl, covdbName));
        // get test-qualified covergroup definition
        covdbHandle test_defs_hdl = covdb_qualified_iterate(def_hdl, test_hdl, covdbDefinitions);
        covdbHandle test_def_hdl;
        while(test_def_hdl = covdb_scan(test_defs_hdl)) {
            test_def_hdl = covdb_make_persistent_handle(test_def_hdl);
            printf("test def: %s\n", covdb_get_str(test_def_hdl, covdbName));
            // get containers representing point or cross declarations within the group
            covdbHandle decls_hdl = covdb_iterate(test_def_hdl, covdbObjects);
            covdbHandle decl_hdl;
            while(decl_hdl = covdb_scan(decls_hdl)) {
                decl_hdl = covdb_make_persistent_handle(decl_hdl);
                printf("decl: %s\n", covdb_get_str(decl_hdl, covdbName));
                // use map to arrange every bin a fixed place according to their names
                map<string, int64_t> cov_tree;

                // get bin table containers
                covdbHandle tables_hdl = covdb_iterate(decl_hdl, covdbObjects);
                covdbHandle table_hdl;
                while(table_hdl = covdb_scan(tables_hdl)) {
                    table_hdl = covdb_make_persistent_handle(table_hdl);
                    
                    // TODO: noww can only handle cross coverage in covergroup
                    if(!strcmp("Automatically Generated Cross Bins", covdb_get_str(table_hdl, covdbName))) {
                        // get bin 

                        covdbHandle bins_hdl = covdb_iterate(table_hdl, covdbObjects);
                        covdbHandle bin_hdl;
                        while(bin_hdl = covdb_scan(bins_hdl)) {
                            bin_hdl = covdb_make_persistent_handle(bin_hdl);
                            
                            // exclude invalid bins
                            unsigned int status = covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovStatus);
                            if(status & covdbStatusExcluded) {
                                continue;
                            }

                            // uncompressed bin
                            if(covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCoverable)==1) {
                                string bin_name = get_auto_cross_bin_name(bin_hdl);
                                cov_tree.insert(pair<string, int64_t>(bin_name, covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovCount)));
                            }
                            // compressed bin
                            else if(covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCoverable)>1){
                                // get separate uncompressed bins
                                // these bins do not have name, we need to make their names
                                covdbHandle sep_bins_hdl = covdb_iterate(bin_hdl, covdbObjects);
                                covdbHandle sep_bin_hdl;
                                while(sep_bin_hdl = covdb_scan(sep_bins_hdl)) {
                                    sep_bin_hdl = covdb_make_persistent_handle(sep_bin_hdl);
                                    string bin_name = get_auto_cross_bin_name(sep_bin_hdl);
                                    cov_tree.insert(pair<string, int64_t>(bin_name, covdb_get(sep_bin_hdl, test_def_hdl, test_hdl, covdbCovCount)));
                                    covdb_release_handle(sep_bin_hdl);
                                }
                                
                                covdb_release_handle(sep_bins_hdl);
                            }
                            covdb_release_handle(bin_hdl);
                        }
                        
                        covdb_release_handle(bins_hdl);
                    }
                    covdb_release_handle(table_hdl);
                }
                
                covdb_release_handle(tables_hdl);
                
                // dump map to vector
                for(map<string,int64_t>::iterator it=cov_tree.begin(); it!=cov_tree.end(); ++it) {
                    cov_map.push_back(it->second);
                }
                
                covdb_release_handle(decl_hdl);
            }
            
            covdb_release_handle(decls_hdl);
            covdb_release_handle(test_def_hdl);
        }
        
        covdb_release_handle(test_defs_hdl);
        covdb_release_handle(def_hdl);
    }
    
    covdb_release_handle(defs_hdl);
    
    return cov_map;
}


/*  
    function: get_testbench_auto_cross_cov
    
    get target testbench coverage (covergroup/coverpoint) under a test handle
    
    This function can only handle "Automatically Generated Cross Bins"
    
    input: test handle, a testbench-metric handle, covergroup definition name 

    process:
    1> get testbench metric qualified covergroup definition;
       in def, a covergroup definition (not instance) is included. (e.x, dynamic_output_control::routing_algorithm_cover)
    2> get test qualified definitions;
       in test def, a covergroup instance is defined. (e.x, top_tb.dynamic_node.dynamic_node_top.north_output.control::routing_algorithm_cover)
    3> get point/cross containers, one container means a covergroup/coverpoint;
       (a STL map<string,int> is initialized from here. because UCAPI make some missed bins compressed, we need to rearrange bin's place according to its name) 
    4> get bin table containers;
    5> get bin;
    6> if the bin is compressed, get its separate sub bins;

    return: cov_map<int64_t>, covCount number of every coverpoint's hit count
 */

vector<int64_t> get_testbench_auto_cross_cov(covdbHandle test_hdl, covdbHandle met_hdl, string cov_name) {
    vector<int64_t> cov_map;
    // printf("get testbench cov\n");
    // get testbench-metric-qualified covergroup definitions
    covdbHandle defs_hdl = covdb_qualified_iterate(test_hdl, met_hdl, covdbDefinitions);
    covdbHandle def_hdl;
    while(def_hdl = covdb_scan(defs_hdl)) {
        def_hdl = covdb_make_persistent_handle(def_hdl);
        // printf("def: %s\n", covdb_get_str(def_hdl, covdbName));
        // get test-qualified covergroup definition
        covdbHandle test_defs_hdl = covdb_qualified_iterate(def_hdl, test_hdl, covdbDefinitions);
        covdbHandle test_def_hdl;
        while(test_def_hdl = covdb_scan(test_defs_hdl)) {
            test_def_hdl = covdb_make_persistent_handle(test_def_hdl);
            // printf("test def: %s\n", covdb_get_str(test_def_hdl, covdbName));
            string test_def_name = covdb_get_str(test_def_hdl, covdbName);
            if(test_def_name.find(cov_name)==-1) {
                continue;
            }
            // get containers representing point or cross declarations within the group
            covdbHandle decls_hdl = covdb_iterate(test_def_hdl, covdbObjects);
            covdbHandle decl_hdl;
            while(decl_hdl = covdb_scan(decls_hdl)) {
                decl_hdl = covdb_make_persistent_handle(decl_hdl);
                // printf("decl: %s\n", covdb_get_str(decl_hdl, covdbName));
                // use map to arrange every bin a fixed place according to their names
                map<string, int64_t> cov_tree;

                // get bin table containers
                covdbHandle tables_hdl = covdb_iterate(decl_hdl, covdbObjects);
                covdbHandle table_hdl;
                while(table_hdl = covdb_scan(tables_hdl)) {
                    table_hdl = covdb_make_persistent_handle(table_hdl);
                    // printf("table: %s\n", covdb_get_str(table_hdl, covdbName));
                    // TODO: noww can only handle cross coverage in covergroup
                    if(!strcmp("Automatically Generated Cross Bins", covdb_get_str(table_hdl, covdbName))) {
                        // get bin 

                        covdbHandle bins_hdl = covdb_iterate(table_hdl, covdbObjects);
                        covdbHandle bin_hdl;
                        while(bin_hdl = covdb_scan(bins_hdl)) {
                            bin_hdl = covdb_make_persistent_handle(bin_hdl);
                            
                            // exclude invalid bins
                            unsigned int status = covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovStatus);
                            if(status & covdbStatusExcluded) {
                                continue;
                            }

                            // uncompressed bin
                            if(covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCoverable)==1) {
                                string bin_name = get_auto_cross_bin_name(bin_hdl);
                                cov_tree.insert(pair<string, int64_t>(bin_name, covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovCount)));
                            }
                            // compressed bin
                            else if(covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCoverable)>1){
                                // get separate uncompressed bins
                                // these bins do not have name, we need to make their names
                                covdbHandle sep_bins_hdl = covdb_iterate(bin_hdl, covdbObjects);
                                covdbHandle sep_bin_hdl;
                                while(sep_bin_hdl = covdb_scan(sep_bins_hdl)) {
                                    sep_bin_hdl = covdb_make_persistent_handle(sep_bin_hdl);
                                    string bin_name = get_auto_cross_bin_name(sep_bin_hdl);
                                    cov_tree.insert(pair<string, int64_t>(bin_name, covdb_get(sep_bin_hdl, test_def_hdl, test_hdl, covdbCovCount)));
                                    covdb_release_handle(sep_bin_hdl);
                                }
                                
                                covdb_release_handle(sep_bins_hdl);
                            }
                            covdb_release_handle(bin_hdl);
                        }
                        
                        covdb_release_handle(bins_hdl);
                    }
                    covdb_release_handle(table_hdl);
                }
                
                covdb_release_handle(tables_hdl);
                
                // dump map to vector
                for(map<string,int64_t>::iterator it=cov_tree.begin(); it!=cov_tree.end(); ++it) {
                    cov_map.push_back(it->second);
                }
                
                covdb_release_handle(decl_hdl);
            }
            
            covdb_release_handle(decls_hdl);
            covdb_release_handle(test_def_hdl);
        }
        
        covdb_release_handle(test_defs_hdl);
        covdb_release_handle(def_hdl);
    }
    
    covdb_release_handle(defs_hdl);
    
    return cov_map;
}


/*  
    function: get_testbench_user_defined_bins_cov
    
    get target testbench coverage (covergroup/coverpoint) under a test handle
    
    This function can only handle "User Defined Bins"
    
    input: test handle, a testbench-metric handle, covergroup definition name 

    process:
    1> get testbench metric qualified covergroup definition;
       in def, a covergroup definition (not instance) is included. (e.x, dynamic_output_control::routing_algorithm_cover)
    2> get test qualified definitions;
       in test def, a covergroup instance is defined. (e.x, top_tb.dynamic_node.dynamic_node_top.north_output.control::routing_algorithm_cover)
    3> get point/cross containers, one container means a covergroup/coverpoint;
       (a STL map<string,int> is initialized from here. because UCAPI make some missed bins compressed, we need to rearrange bin's place according to its name) 
    4> get bin table containers;
    5> get bin;
    6> if the bin is compressed, get its separate sub bins;

    return: cov_map<int64_t>, covCount number of every coverpoint's hit count
 */

vector<int64_t> get_testbench_user_defined_bins_cov(covdbHandle test_hdl, covdbHandle met_hdl, string cov_name) {
    vector<int64_t> cov_map;
    // printf("get testbench cov\n");
    // get testbench-metric-qualified covergroup definitions
    covdbHandle defs_hdl = covdb_qualified_iterate(test_hdl, met_hdl, covdbDefinitions);
    covdbHandle def_hdl;
    while(def_hdl = covdb_scan(defs_hdl)) {
        def_hdl = covdb_make_persistent_handle(def_hdl);
        // printf("def: %s\n", covdb_get_str(def_hdl, covdbName));
        // get test-qualified covergroup definition
        covdbHandle test_defs_hdl = covdb_qualified_iterate(def_hdl, test_hdl, covdbDefinitions);
        covdbHandle test_def_hdl;
        while(test_def_hdl = covdb_scan(test_defs_hdl)) {
            test_def_hdl = covdb_make_persistent_handle(test_def_hdl);
            // printf("test def: %s\n", covdb_get_str(test_def_hdl, covdbName));
            string test_def_name = covdb_get_str(test_def_hdl, covdbName);
            if(test_def_name.find(cov_name)==-1) {
                continue;
            }
            // get containers representing point or cross declarations within the group
            covdbHandle decls_hdl = covdb_iterate(test_def_hdl, covdbObjects);
            covdbHandle decl_hdl;
            while(decl_hdl = covdb_scan(decls_hdl)) {
                decl_hdl = covdb_make_persistent_handle(decl_hdl);
                // printf("decl: %s\n", covdb_get_str(decl_hdl, covdbName));

                // get bin table containers
                covdbHandle tables_hdl = covdb_iterate(decl_hdl, covdbObjects);
                covdbHandle table_hdl;
                while(table_hdl = covdb_scan(tables_hdl)) {
                    table_hdl = covdb_make_persistent_handle(table_hdl);
                    // printf("table: %s\n", covdb_get_str(table_hdl, covdbName));
                    // TODO: noww can only handle cross coverage in covergroup
                    if(!strcmp("User Defined Bins", covdb_get_str(table_hdl, covdbName))) {
                        // get bin 

                        covdbHandle bins_hdl = covdb_iterate(table_hdl, covdbObjects);
                        covdbHandle bin_hdl;
                        while(bin_hdl = covdb_scan(bins_hdl)) {
                            bin_hdl = covdb_make_persistent_handle(bin_hdl);
                            // printf("bin: %s\n", covdb_get_str(bin_hdl, covdbName));
                            // printf("count: %d\n", covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovCount));
                            cov_map.push_back(covdb_get(bin_hdl, test_def_hdl, test_hdl, covdbCovCount));
                            covdb_release_handle(bin_hdl);
                        }
                        
                        covdb_release_handle(bins_hdl);
                    }
                    covdb_release_handle(table_hdl);
                }
                
                covdb_release_handle(tables_hdl);
                covdb_release_handle(decl_hdl);
            }
            
            covdb_release_handle(decls_hdl);
            covdb_release_handle(test_def_hdl);
        }
        
        covdb_release_handle(test_defs_hdl);
        covdb_release_handle(def_hdl);
    }
    
    covdb_release_handle(defs_hdl);
    
    return cov_map;
}


bool get_coverage(char* test_name, vector<int64_t>& cov_map_ret) {
    static bool first_flag = 1;
    static covdbHandle design_hdl;
    if(first_flag) {
        design_hdl = load_design("simv.vdb");
        first_flag = 0;
    }

    string test_name_str = "simv/";
    test_name_str += test_name;

    covdbHandle test_hdl = load_test(design_hdl, test_name_str.c_str());
    covdbHandle met_hdl = get_metric_hdl(test_hdl, "testbench");
    
    // vector<int64_t> cov_map_ret_cp1 = get_testbench_auto_cross_cov(test_hdl, met_hdl, "routing_algorithm_cover");
    // vector<int64_t> cov_map_ret_cp2 = get_testbench_auto_cross_cov(test_hdl, met_hdl, "input_req_cover");
    vector<int64_t> cov_map_ret_crossbar = get_testbench_auto_cross_cov(test_hdl, met_hdl, "crossbar_cover");
    // cov_map_ret.insert(cov_map_ret.end(), cov_map_ret_cp1.begin(), cov_map_ret_cp1.end());
    // cov_map_ret.insert(cov_map_ret.end(), cov_map_ret_cp2.begin(), cov_map_ret_cp2.end());
    cov_map_ret.insert(cov_map_ret.end(), cov_map_ret_crossbar.begin(), cov_map_ret_crossbar.end());

    // static bool covered_cp1[6000] = {false};
    // static int covered_cnt_cp1 = 0;
    // bool flag_cp1 = false;
    // for(int i=0;i<cov_map_ret_cp1.size();i++) {
    //     if(cov_map_ret_cp1[i] && !covered_cp1[i]) {
    //         covered_cp1[i] = true;
    //         covered_cnt_cp1 ++;
    //         flag_cp1 = true;
    //     }
    // }
    // if(flag_cp1) printf("INFO: cp1 covered %d points\n", covered_cnt_cp1);

    // static bool covered_cp2[10000] = {false};
    // static int covered_cnt_cp2 = 0;
    // bool flag_cp2 = false;
    // for(int i=0;i<cov_map_ret_cp2.size();i++) {
    //     if(cov_map_ret_cp2[i] && !covered_cp2[i]) {
    //         covered_cp2[i] = true;
    //         covered_cnt_cp2 ++;
    //         flag_cp2 = true;
    //     }
    // }
    // if(flag_cp2) printf("INFO: cp2 covered %d points\n", covered_cnt_cp2);

    static bool covered[10000] = {false};
    static int covered_cnt = 0;
    bool flag_print = false;
    for(int i=0;i<cov_map_ret_crossbar.size();i++) {
        if(cov_map_ret_crossbar[i] && !covered[i]) {
            covered[i] = true;
            covered_cnt ++;
            flag_print = true;
        }
    }
    if(flag_print) printf("INFO: cp_crossbar covered %d points\n", covered_cnt);

    if(covered_cnt == 1546) {
        return true;
    }
    
    covdb_unload(test_hdl);
    covdb_release_handle(met_hdl);

    return false;
}



// return cov map: 1024*5
bool get_coverage_starvation(char* test_name, vector<int64_t>& cov_map_ret) {
    static bool first_flag = 1;
    static covdbHandle design_hdl;
    if(first_flag) {
        design_hdl = load_design("simv.vdb");
        first_flag = 0;
    }

    string test_name_str = "simv/";
    test_name_str += test_name;

    covdbHandle test_hdl = load_test(design_hdl, test_name_str.c_str());
    covdbHandle met_hdl = get_metric_hdl(test_hdl, "testbench");
    
    vector<int64_t> cov_map = get_testbench_user_defined_bins_cov(test_hdl, met_hdl, "starvation_cover");

    static int cov_max[5] = {0};
    bool progress_flag = false;
    for(int i=0;i<5;i++) {
        for(int j=0;j<1024;j++) {
            if(j==1023) {
                printf("FIND STARVATION!!!\n");
                return true;
            }
            if(cov_map[i*1024+j]==0) {
                if(j>cov_max[i]) {
                    cov_max[i] = j;
                    progress_flag = true;
                }
                break;
            }
        }
    }
    cov_map_ret.insert(cov_map_ret.end(), cov_map.begin(), cov_map.end());
    
    if(progress_flag) {
        printf("cov cnt: %d %d %d %d %d\n", cov_max[0], cov_max[1], cov_max[2], cov_max[3], cov_max[4]);
    }

    covdb_unload(test_hdl);
    covdb_release_handle(met_hdl);

    return false;
}
