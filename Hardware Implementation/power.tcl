#====14nm Technology 
#set OSU_FREEPDK "/home/C00433233/Technology/14nm"
#====32nm Technology 
#set OSU_FREEPDK "/home/C00433233/Technology/32nm"
set OSU_FREEPDK "/home/C00505755/Documents/HDC_Synopsys/32nmLibrary/"
#====45 nm 
#set OSU_FREEPDK "/home/C00433233/NCSU-FreePDK45-1.4/FreePDK45/osu_soc/lib/files"


set search_path [concat  $search_path $OSU_FREEPDK]
set alib_library_analysis_path $OSU_FREEPDK


#======14nm Technology 
#set link_library [set target_library [concat  [list saed14rvt_tt0p8v25c.db] [list dw_foundation.sldb]]]
#set target_library "saed14rvt_tt0p8v25c.db"
#======32nm Technology 
set link_library [set target_library [concat  [list saed32rvt_tt1p05v25c.db] [list dw_foundation.sldb]]]
set target_library "saed32rvt_tt1p05v25c.db"
#======45nm Technology 
#set link_library [set target_library [concat  [list gscl45nm.db] [list dw_foundation.sldb]]]
#set target_library "gscl45nm.db"


set synlib_wait_for_design_license [list "DesignWare-Foundation"]

set power_preserve_rtl_hier_names "true"

# It is important to read design 'ddc' and not the design 'netlist' for power analysis. This is because 
# the 'ddc' is expected to contain the clock information, the input slopes, ouput loads which all influence 
# the power consumption.
read_ddc Outputs/Unary_generator.ddc 

# Convert you VCD file to saif format using: vcd2saif -input Outputs/mips.vcd -output Outputs/mips.saif
# Note that the instance name used in 'read_saif' command must be given with full path
# This is very important for successfull annotation of saif.
#set find_ignore_case "true"
read_saif -input Outputs/ugen2.saif -instance_name "top/ugen/Unary_generator"  -verbose
#set find_ignore_case "false"

#Generate power report
report_power > Outputs/power_final_ugen2.txt

exit

# It is important to note that: 
# You may see warnings about the nets not being properly annotated. If these nets are internal nets of 
# the cells of the techology library, then these warnings can be safely ignored. If not, then the annotation 
# is unsuccessfull. Here is a copy of some warnings: http://www.vlsiip.com/power/warn.txt
# These are safely ignored. As you may note that these warnings are all referring to internodes of cells form 
# a tech lib.
  
# Other problems may look something like: 
# Error: No switching activity has been annotated 
# This usually means that the saif annotation has not been successfull. Problem may lie in the 
# instance name used in 'read_saif' command.