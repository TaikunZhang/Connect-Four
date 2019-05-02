`timescale 1ns / 1ns
module gamecontrol(
input clk,resetn,resetb,
input [7:0] COL,
input [7:0] aicol,
input [8:0] cycle,
input [14:0] boardcycle,
input spacebar,colchoose,rwin,bwin,win,
input [5:0] boardcounter,

output reg r_a,r_b,r_c,r_d,r_e,r_f,r_g,
output reg b_a,b_b,b_c,b_d,b_e,b_f,b_g,
output reg c_a,c_b,c_c,c_d,c_e,c_f,c_g,
output reg en_cycle,drawr,drawb,writeEn,checkr,checkb,reset_b,drawboard,drawredwin,drawbluewin,gamedraw,en_cycleb,AI_move,AI_check);

reg[5:0] current_state,next_state;

localparam  S_START=5'd0,
				S_START_WAIT=5'd1,
				S_CHOOSE_R=5'd2,
				S_CHOOSE_B=5'd3,
				S_R_TURN=5'd4,
				S_R_WAIT=5'd5,
				S_R_LOAD=5'd6,
				S_R_DRAW=5'd7,
				S_CHECK_R=5'd8,
				S_B_TURN=5'd9,
				S_B_WAIT=5'd10,
				S_B_LOAD=5'd11,
				S_B_DRAW=5'd12,
				S_CHECK_B=5'd13,
				S_GAME_OVER=5'd14,
				S_RESET=5'd15,
				S_UPDATE_R=5'd16,
				S_UPDATE_B=5'd17,
				S_DRAW_BOARD=5'd18,
				S_DRAW_BOARD_WAIT=5'd19,
				S_CONFIRM=5'd20,
				S_DRAW_MESSAGE=5'd21,
				S_GAME_OVER_WAIT=5'd22,
				S_B_LOAD_C=5'd23,
				S_R_LOAD_C=5'd24,
				AI_CHECK_FOR_WIN=5'd26,
				S_R_AI=5'd25;
	
	//state table
	always @(*)
	begin: state_table
	case(current_state)
	
	S_START: next_state = spacebar ? S_START_WAIT:S_START;
	S_START_WAIT: next_state = spacebar ? S_START_WAIT:S_DRAW_BOARD;
	//S_DRAW_BOARD_WAIT: next_state = spacebar ? S_DRAW_BOARD_WAIT: S_R_TURN;
	S_DRAW_BOARD: next_state = (boardcycle==15'd19199) ? S_R_TURN:S_DRAW_BOARD;//
	S_R_TURN: next_state = colchoose ? S_R_WAIT:S_R_TURN;
	S_R_WAIT: next_state = colchoose ? S_R_WAIT:AI_CHECK_FOR_WIN;
	AI_CHECK_FOR_WIN : next_state=S_R_AI;
	S_R_AI: next_state = S_R_LOAD;
	S_R_LOAD: next_state = S_R_LOAD_C;
	S_R_LOAD_C: next_state = S_R_DRAW;
	//S_R_LOAD_C: next_state = S_CHECK_R;
	S_R_DRAW: next_state = (cycle==9'd255) ? S_CHECK_R:S_R_DRAW;
	S_CHECK_R: next_state = S_UPDATE_R;
	S_UPDATE_R :next_state = win ? S_GAME_OVER:S_B_TURN;
	S_B_TURN: next_state = colchoose ? S_B_WAIT:S_B_TURN;
	S_B_WAIT: next_state = colchoose ? S_B_WAIT:S_B_LOAD;
	S_B_LOAD: next_state = S_B_LOAD_C;
	S_B_LOAD_C:next_state = S_B_DRAW;
	//S_B_LOAD_C:next_state = S_CHECK_B;
	S_B_DRAW: next_state = (cycle==9'd255) ? S_CHECK_B:S_B_DRAW;
	S_CHECK_B: next_state = S_UPDATE_B;
	S_UPDATE_B: next_state = win ? S_GAME_OVER:S_R_TURN;
	S_GAME_OVER: next_state = spacebar ? S_GAME_OVER_WAIT:S_GAME_OVER;
	S_GAME_OVER_WAIT: next_state=spacebar ? S_GAME_OVER_WAIT:S_DRAW_MESSAGE;
	S_DRAW_MESSAGE: next_state =(boardcycle==15'd19199) ? S_START:S_DRAW_MESSAGE;
	
	default : next_state = S_START;
	endcase
	end
	
	//output logic
	always @(*)
	begin: enable_signals
	
	r_a=1'b0;
	r_b=1'b0;
	r_c=1'b0;
	r_d=1'b0;
	r_e=1'b0;
	r_f=1'b0;
	r_g=1'b0;
	b_a=1'b0;
	b_b=1'b0;
	b_c=1'b0;
	b_d=1'b0;
	b_e=1'b0;
	b_f=1'b0;
	b_g=1'b0;
	c_a=1'b0;
	c_b=1'b0;
	c_c=1'b0;
	c_d=1'b0;
	c_e=1'b0;
	c_f=1'b0;
	c_g=1'b0;
	drawr=1'b0;
	drawb=1'b0;
	drawboard=1'b0;
	drawredwin=1'b0;
	drawbluewin=1'b0;
	gamedraw=1'b0;
	writeEn=1'b0;
	en_cycle=1'b0;
	checkr=1'b0;
	checkb=1'b0;
	en_cycleb=1'b0;
	AI_move=1'b0;
	AI_check=1'b0;
	
		case (current_state)
				S_START:begin
				end
				S_CHOOSE_R:begin
				end
				S_CHOOSE_B:begin
				end
				S_DRAW_BOARD:begin
				en_cycleb=1'b1;
				drawboard=1'b1;
				writeEn=1'b1;
				end
				AI_CHECK_FOR_WIN:begin
				AI_check=1'b1;
				end
				S_R_AI:begin
				AI_move=1'b1;
				end
				S_R_LOAD:begin
				//assigning signals per column
				case(aicol[7:0])
					8'b00000010: r_a=1'b1;
					8'b00000100: r_b=1'b1;
					8'b00001000: r_c=1'b1;
					8'b00010000: r_d=1'b1;
					8'b00100000: r_e=1'b1;
					8'b01000000: r_f=1'b1;
					8'b10000000: r_g=1'b1;
				endcase
				end
				S_R_LOAD_C:begin
					case(aicol[7:0])
					8'b00000010: c_a=1'b1;
					8'b00000100: c_b=1'b1;
					8'b00001000: c_c=1'b1;
					8'b00010000: c_d=1'b1;
					8'b00100000: c_e=1'b1;
					8'b01000000: c_f=1'b1;
					8'b10000000: c_g=1'b1;
				endcase
				end
				//draw and cyclecounter cycle
				S_R_DRAW:begin
					drawr=1'b1;
					en_cycle=1'b1;
					writeEn=1'b1;
				end
				S_CHECK_R:begin
					checkr=1'b1;
				end
				//assigning signals per column
				S_B_LOAD:begin
					case(COL[7:0])
					8'b00000010: b_a=1'b1;
					8'b00000100: b_b=1'b1;
					8'b00001000: b_c=1'b1;
					8'b00010000: b_d=1'b1;
					8'b00100000: b_e=1'b1;
					8'b01000000: b_f=1'b1;
					8'b10000000: b_g=1'b1;
				endcase
				end
				S_B_LOAD_C:begin
					case(COL[7:0])
					8'b00000010: c_a=1'b1;
					8'b00000100: c_b=1'b1;
					8'b00001000: c_c=1'b1;
					8'b00010000: c_d=1'b1;
					8'b00100000: c_e=1'b1;
					8'b01000000: c_f=1'b1;
					8'b10000000: c_g=1'b1;
				endcase
				end
				S_B_DRAW:begin
					drawb=1'b1;
					en_cycle=1'b1;
					writeEn=1'b1;
				end
				S_CHECK_B:begin
					checkb=1'b1;
				end
				S_DRAW_MESSAGE:begin
					if (rwin)begin
					drawredwin=1'b1;
					en_cycleb=1'b1;
					writeEn=1'b1;
					end
					else if (bwin)begin
					drawbluewin=1'b1;
					en_cycleb=1'b1;
					writeEn=1'b1;
					end
					else if (boardcounter==6'd42)begin
					gamedraw=1'b1;
					en_cycleb=1'b1;
					writeEn=1'b1;
					end
				end
			endcase
		end
		
		//state registers
		always @(posedge clk)
		begin: stateFFS
		if (!resetn)
			current_state <= S_START;
		else if(!resetb)begin
			current_state <= S_START;
		end
		else if (boardcounter==6'd42)
			current_state <= S_DRAW_MESSAGE;
		else
			current_state <= next_state;
		end
		
endmodule
