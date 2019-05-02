vlib work
vlog gamecontrol.v
vsim gamecontrol

log {/*}
add wave {/*}
force clk 0 0ns, 1 10ns -r 20ns

force {resetn} 0
run 10ns
force {resetn} 1

force {spacebar} 1
run 20ns
force {spacebar} 0
run 20ns

force {spacebar} 1
run 20ns
force {spacebar} 0
run 20ns

force {boardcycle} 15'd19199
run 20ns
force {COL} 3'b001
force {colchoose} 1
run 20ns

force {colchoose} 0
run 20ns

force {cycle} 8'd255
force {boardcycle} 15'd0
run 20ns

force {win} 1
force {rwin} 1
run 100ns

run 1000ns