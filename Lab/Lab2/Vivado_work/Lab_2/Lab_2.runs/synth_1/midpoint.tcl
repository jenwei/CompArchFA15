# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.cache/wt [current_project]
set_property parent.project_path C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.srcs/sources_1/imports/Lab2/shiftregister.v
  C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.srcs/sources_1/imports/Lab2/inputconditioner.v
  C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.srcs/sources_1/imports/Lab2/midpoint.v
}
read_xdc C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.srcs/constrs_1/imports/Lab2/ZYBO_Master.xdc
set_property used_in_implementation false [get_files C:/Users/rapto/OneDrive/Documents/GitHub/CALab0/CompArchFA15/Lab/Lab2/Vivado_work/Lab_2/Lab_2.srcs/constrs_1/imports/Lab2/ZYBO_Master.xdc]

synth_design -top midpoint -part xc7z010clg400-1
write_checkpoint -noxdef midpoint.dcp
catch { report_utilization -file midpoint_utilization_synth.rpt -pb midpoint_utilization_synth.pb }
