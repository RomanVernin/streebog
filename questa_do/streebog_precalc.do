vlib work
vmap work work
vlog -define PRECALC -f questa_do/streebog_precalc.f
vsim -voptargs=+acc streebog_tb
#add wave -color "light blue" -depth 0 -ports -noupdate /streebog_tb/u_streebog_top/*
add wave -color "blue" -noupdate /streebog_tb/u_streebog_top/clk_i 
add wave -color "blue" -noupdate /streebog_tb/u_streebog_top/rstn_i 
add wave -color "dark red" -noupdate /streebog_tb/u_streebog_top/mes_last_i 
add wave -color "dark red" -noupdate /streebog_tb/u_streebog_top/mes_last_len_i 
add wave -color "dark red" -noupdate /streebog_tb/u_streebog_top/mes_valid_i 
add wave -color "dark red" -noupdate /streebog_tb/u_streebog_top/mes_ready_o 
add wave -color "dark red" -noupdate /streebog_tb/u_streebog_top/message_i 
add wave -color "web green" -noupdate /streebog_tb/u_streebog_top/hash_len_i 
add wave -color "dark orange" -noupdate /streebog_tb/u_streebog_top/fsm_start_req_i 
add wave -color "dark orange" -noupdate /streebog_tb/u_streebog_top/fsm_start_ack_o 
add wave -color "dark blue" -noupdate /streebog_tb/u_streebog_top/hash_o 
add wave -color "dark blue" -noupdate /streebog_tb/u_streebog_top/hash_valid_o 
add wave -color "dark blue" -noupdate /streebog_tb/u_streebog_top/hash_ready_i 
run -all
WaveRestoreZoom {0 ps} {1000000 ps}
configure wave -signalnamewidth 1 -timelineunits ns



