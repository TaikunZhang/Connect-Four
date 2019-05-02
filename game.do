vlib work
vlog connectfour.v board.v gamecontrol.v gamelogic.v drawchip.v drawboard.v pictureboard.v gamedraw.v redwin.v bluewin.v
vsim -L altera_mf_ver game
log -r {/*}
add wave {/*}
set time 0
force clk 0 0ns, 1 1ns -r 2ns

force {resetb} 0
run 1ns
force {resetb} 1

force {spacebar} 1
run 2ns
force {spacebar} 0
run 2ns

force {spacebar} 1
run 2ns
force {spacebar} 0
run 2ns
run 38396ns

force {colchoose} 1
run 2ns
force {column} 8'b00000010
force {colchoose} 0
run 10ns


force {colchoose} 1
run 2ns
force {column} 8'b00000100
force {colchoose} 0
run 10ns

force {colchoose} 1
run 2ns
force {column} 8'b00000010
force {colchoose} 0
run 10ns


force {colchoose} 1
run 2ns
force {column} 8'b00000100
force {colchoose} 0
run 10ns
force {colchoose} 1
run 2ns
force {column} 8'b00000010
force {colchoose} 0
run 10ns


force {colchoose} 1
run 2ns
force {column} 8'b00000100
force {colchoose} 0
run 10ns
force {colchoose} 1
run 2ns
force {column} 8'b00000010
force {colchoose} 0
run 10ns


force {colchoose} 1
run 2ns
force {column} 8'b00000100
force {colchoose} 0
run 10ns








