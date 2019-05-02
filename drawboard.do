vlib work
vlog drawboard.v pictureboard.v redwin.v bluewin.v
vsim -L altera_mf_ver drawboard

log {/*}
add wave {/*}
force clk 0 0ns, 1 1ns -r 2ns

force {resetn} 0
run 1ns
force {resetn} 1

force {drawredwin} 1
force {en_cycleb} 1
run 38400ns