transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib adc_qsys
vmap adc_qsys adc_qsys
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/adc_qsys.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/adc_qsys_modular_adc_0.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/altera_modular_adc_control.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/altera_modular_adc_control_avrg_fifo.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/altera_modular_adc_control_fsm.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/chsel_code_converter_sw_to_hw.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/fiftyfivenm_adcblock_primitive_wrapper.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/fiftyfivenm_adcblock_top_wrapper.v}
vlog -vlog01compat -work adc_qsys +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules {C:/Users/bryan/Quartus/ENEL453_Lab3/adc_qsys/synthesis/submodules/adc_qsys_altpll_sys.v}
vlog -vlog01compat -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/ADC_Conversion.v}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/voltage2distance_array2.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/register.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/averager256.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/ADC_Data.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/MUX4TO1.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/debounce.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/binary_bcd.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/SevenSegment.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/SevenSegment_decoder.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/top_level.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/synchronizer.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/digit_manager.sv}

vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/top_level_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -L adc_qsys -voptargs="+acc"  top_level_tb

add wave *
view structure
view signals
run -all
