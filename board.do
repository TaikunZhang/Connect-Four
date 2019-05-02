vlib work
vlog board.v
vsim board

log {/*}
add wave {/*}
force clk 0 0ns, 1 10ns -r 20ns

force {resetn} 0
run 20ns
force {resetn} 1

force {r_b} 1
run 60ns
force {r_b} 0
force {r_c} 1
run 20ns
force {r_c} 0
force {r_d} 1
run 60ns
force {resetb} 1
run 20ns
force {resetb} 0
run 20ns
force {r_d} 0
