vlib work
vlog draw.v
vsim draw -L altera_mf_ver bluedot altera_mf_ver reddot

log {/*}
add wave {/*}
force clk 0 0ns, 1 10ns -r 20ns

force {resetn} 0
run 10ns
force {resetn} 1


force {xin} 8'd16
force {yin} 7'd32
force {drawr} 1
force {colourin} 3'b100
force {en_cycle} 1
run 10000ns

force {xin} 8'd16
force {yin} 7'd48
force {drawb} 1
force {colourin} 3'b001
force {en_cycle} 1
run 1000ns

