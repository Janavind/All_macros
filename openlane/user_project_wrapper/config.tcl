# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

# Base Configurations. Don't Touch
# section begin

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

# YOU ARE NOT ALLOWED TO CHANGE ANY VARIABLES DEFINED IN THE FIXED WRAPPER CFGS 
source $::env(CARAVEL_ROOT)/openlane/user_project_wrapper/fixed_wrapper_cfgs.tcl

# YOU CAN CHANGE ANY VARIABLES DEFINED IN THE DEFAULT WRAPPER CFGS BY OVERRIDING THEM IN THIS CONFIG.TCL
source $::env(CARAVEL_ROOT)/openlane/user_project_wrapper/default_wrapper_cfgs.tcl

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
#section end

# User Configurations

## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/user_project_wrapper.v"

## Clock configurations
set ::env(CLOCK_PORT) "user_clock2"
set ::env(CLOCK_NET) "clk"

set ::env(CLOCK_PERIOD) "10"
set ::env(PL_BASIC_PLACEMENT) 0

### Black-box verilog and views
#set ::env(VERILOG_FILES_BLACKBOX) "\
#	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
#	$script_dir/../../verilog/rtl/user_proj_example.v"

## Internal Macros
#### Macro PDN Connections
#set ::env(FP_PDN_MACRO_HOOKS) "\
  #      u_macro_7 vccd1 vssd1 \
 #       u_macro_10 vccd1 vssd1 \  
#	u_macro_13 vccd1 vssd1"

        ### Macro Placement
set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg
### Black-box verilog and views
set ::env(VERILOG_FILES_BLACKBOX) "\
        $::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
        $script_dir/../../verilog/rtl/macro_7.v \
        $script_dir/../../verilog/rtl/macro_10.v \
	$script_dir/../../verilog/rtl/macro_13.v \
	 $script_dir/../../verilog/rtl/macro_15.v \
	$script_dir/../../verilog/rtl/macro_decap_3.v \
	$script_dir/../../verilog/rtl/macro_decap_12.v "
#	script_dir/../../verilog/rtl/macro_no_decap.v "
#	$script_dir/../../verilog/rtl/macro_no_fill.v "

set ::env(EXTRA_LEFS) "\ 
	$script_dir/../../lef/macro_7.lef \
        $script_dir/../../lef/macro_10.lef \
	$script_dir/../../lef/macro_13.lef \
	$script_dir/../../lef/macro_15.lef \
	$script_dir/../../lef/macro_decap_3.lef \
	$script_dir/../../lef/macro_decap_12.lef "
#	$script_dir/../../lef/macro_no_decap.lef "
#	$script_dir/../../lef/macro_no_fill.lef "

set ::env(EXTRA_GDS_FILES) "\ 
	$script_dir/../../gds/macro_7.gds\
        $script_dir/../../gds/macro_10.gds \
	$script_dir/../../gds/macro_13.gds \
	$script_dir/../../gds/macro_15.gds \
	$script_dir/../../gds/macro_decap_3.gds \
	$script_dir/../../gds/macro_decap_12.gds "
#	$script_dir/../../gds/macro_no_decap.gds "
#	$script_dir/../../gds/macro_no_fill.gds "

set ::env(FP_PDN_ENABLE_MACROS_GRID) "1"
set ::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS) "1"

#set ::env(VDD_NETS) "vccd1 vccd2 vdda1 vdda2"
#set ::env(GND_NETS) "vssd1 vssd2 vssa1 vssa2"

#set ::env(VDD_PIN) "vccd1"
#set ::env(GND_PIN) "vssd1"

 ## Internal Macros
 ##### Macro PDN Connections
#    set ::env(FP_PDN_MACRO_HOOKS) "\
#        user_proj_example vccd1 vssd1"
 ### Macro Placement
 #   set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro.cfg

# set ::env(GLB_RT_MAXLAYER) 5
set ::env(RT_MAX_LAYER) "met4"

# disable pdn check nodes becuase it hangs with multiple power domains.
# any issue with pdn connections will be flagged with LVS so it is not a critical check.
#set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(FP_PDN_CHECK_NODES) 1

#set ::env(GLB_RT_ALLOW_CONGESTION) 1

set ::env(GLB_RT_ADJUSTMENT) "0.25"
#set ::env(FP_PDN_POWER_STRAPS) "vccd1 vssd1 1, vccd2 vssd2 0, vdda1 vssa1 0, vdda2 vssa2 0"
set ::env(MAGIC_WRITE_FULL_LEF) 1

# The following is because there are no std cells in the example wrapper project.
set ::env(SYNTH_TOP_LEVEL) 0
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(FP_PDN_ENABLE_RAILS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0

