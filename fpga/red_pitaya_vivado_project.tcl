################################################################################
# Vivado tcl script for building RedPitaya FPGA in non project mode
#
# Usage:
# vivado -mode batch -source red_pitaya_vivado_project.tcl
################################################################################

################################################################################
# define paths
################################################################################

global env
set srcdir   $env(srcdir)
set system   $env(system)
set_param general.maxThreads $env(maxThreads)

set path_rtl rtl
set path_ip  ip
set path_sdc sdc

################################################################################
# setup an in memory project
################################################################################

set part xc7z010clg400-1

create_project -part $part -force redpitaya ./project

################################################################################
# create PS BD (processing system block design)
################################################################################

# create PS BD
source                            $srcdir/$path_ip/$system

# generate SDK files
generate_target all [get_files    system.bd]

################################################################################
# read files:
# 1. RTL design sources
# 2. IP database files
# 3. constraints
################################################################################

read_verilog                      ./project/redpitaya.srcs/sources_1/bd/system/hdl/system_wrapper.v

add_files -fileset constrs_1      $srcdir/$path_sdc/red_pitaya.xdc

import_files -force

update_compile_order -fileset sources_1

################################################################################
################################################################################

#start_gui
