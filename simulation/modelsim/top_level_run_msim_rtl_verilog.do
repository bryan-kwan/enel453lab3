transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/register.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/MUX4TO1.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/debounce.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/binary_bcd.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/SevenSegment.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/SevenSegment_decoder.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/top_level.sv}
vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/synchronizer.sv}

vlog -sv -work work +incdir+C:/Users/bryan/Quartus/ENEL453_Lab3 {C:/Users/bryan/Quartus/ENEL453_Lab3/top_level_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  top_level_tb

add wave *
view structure
view signals
run -all
