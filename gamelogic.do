vlib work
vlog gamelogic.v
vsim gamelogic

log {/*}
add wave {/*}
force clk 0 0ns, 1 10ns -r 20ns


force {resetn} 0
run 20ns
force {resetn} 1

force red 000000000000000000000000001000000000011110
force blue 000000000000000000000000000100000010000001
force checkr 1
run 80ns
