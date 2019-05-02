`timescale 1ns /1ns

module board(
input resetn,resetb,clk,
input r_a,r_b,r_c,r_d,r_e,r_f,r_g,
input b_a,b_b,b_c,b_d,b_e,b_f,b_g,
input c_a,c_b,c_c,c_d,c_e,c_f,c_g,


output [7:0] x,
output [6:0] y,
//output [7:0] colour,
output [41:0] r,
output [41:0] b,
output reg [5:0] boardcounter);
//output reg [8:0]cycle);

//counters for each column
reg[2:0]counterA;
reg[2:0]counterB;
reg[2:0]counterC;
reg[2:0]counterD;
reg[2:0]counterE;
reg[2:0]counterF;
reg[2:0]counterG;

//x and y locations to draw
reg [7:0]xloc;
reg [6:0]yloc;
//reg for colour
reg [7:0]outcolour;
//reg describing board for each colour
reg [41:0] red;
reg [41:0] blue;
//counter for draw
reg [7:0] counter;
localparam RED = 8'b10000000,
			  BLUE = 8'b00000001;


//register for colA
always @(posedge clk)begin
		if (!resetn)begin
		xloc<=0;
		yloc<=0;
		outcolour<=0;
		counterA<=0;
		counterB<=0;
		counterC<=0;
		counterD<=0;
		counterE<=0;
		counterF<=0;
		counterG<=0;
		red<=0;
		blue<=0;
		counter<=0;
		end
		else if(!resetb)begin
		xloc<=0;
		yloc<=0;
		outcolour<=0;
		counterA<=0;
		counterB<=0;
		counterC<=0;
		counterD<=0;
		counterE<=0;
		counterF<=0;
		counterG<=0;
		red<=0;
		blue<=0;
		counter<=0;
		end
		else if (r_a)begin
			if (counterA<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterA[2:0])
					3'b000:begin
						xloc<=8'd26;
						yloc<=92;
						red[0]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd26;
						yloc<=7'd76;
						red[7]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd26;
						yloc<=7'd60;
						red[14]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd26;
						yloc<=7'd44;
						red[21]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd26;
						yloc<=7'd28;
						red[28]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd26;
						yloc<=7'd12;
						red[35]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_a)begin
			if (counterA<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterA[2:0])
					3'b000:begin
						xloc<=8'd26;
						yloc<=92;
						blue[0]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd26;
						yloc<=7'd76;
						blue[7]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd26;
						yloc<=7'd60;
						blue[14]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd26;
						yloc<=7'd44;
						blue[21]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd26;
						yloc<=7'd28;
						blue[28]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd26;
						yloc<=7'd12;
						blue[35]<=1'b1;
					end
			endcase
				outcolour<=BLUE;
		end	
	end
//end for COLA
//register for colB		
else if (r_b)begin
			if (counterB<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterB[2:0])
					3'b000:begin
						xloc<=8'd42;
						yloc<=7'd92;
						red[1]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd42;
						yloc<=7'd76;
						red[8]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd42;
						yloc<=7'd60;
						red[15]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd42;
						yloc<=7'd44;
						red[22]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd42;
						yloc<=7'd28;
						red[29]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd42;
						yloc<=7'd12;
						red[36]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_b)begin
			if (counterB<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterB[2:0])
					3'b000:begin
						xloc<=8'd42;
						yloc<=7'd92;
						blue[1]<=1'b1;//changed
					end
					3'b001:begin
						xloc<=8'd42;
						yloc<=7'd76;
						blue[8]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd42;
						yloc<=7'd60;
						blue[15]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd42;
						yloc<=7'd44;
						blue[22]<=1'b1;
					end
						3'b100:begin
						xloc<=8'd42;
						yloc<=7'd28;
						blue[29]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd42;
						yloc<=7'd12;
						blue[36]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
//end for COLB
//register for colC	
else if (r_c)begin
			if (counterC<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterC[2:0])
					3'b000:begin
						xloc<=8'd58;
						yloc<=7'd92;
						red[2]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd58;
						yloc<=7'd76;
						red[9]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd58;
						yloc<=7'd60;
						red[16]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd58;
						yloc<=7'd44;
						red[23]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd58;
						yloc<=7'd28;
						red[30]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd58;
						yloc<=7'd12;
						red[37]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_c)begin
			if (counterC<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterC[2:0])
					3'b000:begin
						xloc<=8'd58;
						yloc<=7'd92;
						blue[2]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd58;
						yloc<=7'd76;
						blue[9]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd58;
						yloc<=7'd60;
						blue[16]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd58;
						yloc<=7'd44;
						blue[23]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd58;
						yloc<=7'd28;
						blue[30]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd58;
						yloc<=7'd12;
						blue[37]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
//end for COLC
//register for colD
else if (r_d)begin
			if (counterD<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterD[2:0])
					3'b000:begin
						xloc<=8'd74;
						yloc<=7'd92;
						red[3]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd74;
						yloc<=7'd76;
						red[10]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd74;
						yloc<=7'd60;
						red[17]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd74;
						yloc<=7'd44;
						red[24]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd74;
						yloc<=7'd28;
						red[31]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd74;
						yloc<=7'd12;
						red[38]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_d)begin
			if (counterD<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterD[2:0])
					3'b000:begin
						xloc<=8'd74;
						yloc<=7'd92;
						blue[3]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd74;
						yloc<=7'd76;
						blue[10]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd74;
						yloc<=7'd60;
						blue[17]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd74;
						yloc<=7'd44;
						blue[24]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd74;
						yloc<=7'd28;
						blue[31]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd74;
						yloc<=7'd12;
						blue[38]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
//end of COLD
//register for colE
else if (r_e)begin
			if (counterE<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterE[2:0])
					3'b000:begin
						xloc<=8'd90;
						yloc<=7'd92;
						red[4]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd90;
						yloc<=7'd76;
						red[11]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd90;
						yloc<=7'd60;
						red[18]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd90;
						yloc<=7'd44;
						red[25]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd90;
						yloc<=7'd28;
						red[32]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd90;
						yloc<=7'd12;
						red[39]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_e)begin
			if (counterE<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterE[2:0])
					3'b000:begin
						xloc<=8'd90;
						yloc<=7'd92;
						blue[4]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd90;
						yloc<=7'd76;
						blue[11]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd90;
						yloc<=7'd60;
						blue[18]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd90;
						yloc<=7'd44;
						blue[25]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd90;
						yloc<=7'd28;
						blue[32]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd90;
						yloc<=7'd12;
						blue[39]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
//end of COLE
//register for colF
else if (r_f)begin
			if (counterF<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterF[2:0])
					3'b000:begin
						xloc<=8'd106;
						yloc<=7'd92;
						red[5]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd106;
						yloc<=7'd76;
						red[12]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd106;
						yloc<=7'd60;
						red[19]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd106;
						yloc<=7'd44;
						red[26]=1'b1;
					end
					3'b100:begin
						xloc<=8'd106;
						yloc<=7'd28;
						red[33]=1'b1;
					end
					3'b101:begin
						xloc<=8'd106;
						yloc<=7'd12;
						red[40]<=1'b1;
					end
				endcase
			outcolour<=RED;
		end
	end
else if (b_f)begin
			if (counterF<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterF[2:0])
					3'b000:begin
						xloc<=8'd106;
						yloc<=7'd92;
						blue[5]<=1'b1;
					end
					//change back
					3'b001:begin
						xloc<=8'd106;
						yloc<=7'd76;
						blue[12]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd106;
						yloc<=7'd60;
						blue[19]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd106;
						yloc<=7'd44;
						blue[26]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd106;
						yloc<=7'd28;
						blue[33]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd106;
						yloc<=7'd12;
						blue[40]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
//end of COLF
//register for colG
else if (r_g)begin
			if (counterG<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterG[2:0])
					3'b000:begin
						xloc<=8'd122;
						yloc<=7'd92;
						red[6]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd122;
						yloc<=7'd76;
						red[13]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd122;
						yloc<=7'd60;
						red[20]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd122;
						yloc<=7'd44;
						red[27]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd122;
						yloc<=7'd28;
						red[34]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd122;
						yloc<=7'd12;
						red[41]<=1'b1;
				end
			endcase
			outcolour<=RED;
		end
	end
else if (b_g)begin
			if (counterG<=5)begin//case statement to update red reg and x and y locations to draw
				case(counterG[2:0])
					3'b000:begin
						xloc<=8'd122;
						yloc<=7'd92;
						blue[6]<=1'b1;
					end
					3'b001:begin
						xloc<=8'd122;
						yloc<=7'd76;
						blue[13]<=1'b1;
					end
					3'b010:begin
						xloc<=8'd122;
						yloc<=7'd60;
						blue[20]<=1'b1;
					end
					3'b011:begin
						xloc<=8'd122;
						yloc<=7'd44;
						blue[27]<=1'b1;
					end
					3'b100:begin
						xloc<=8'd122;
						yloc<=7'd28;
						blue[34]<=1'b1;
					end
					3'b101:begin
						xloc<=8'd122;
						yloc<=7'd12;
						blue[41]<=1'b1;
				end
			endcase
			outcolour<=BLUE;
		end
	end
	//end of COLG

//counter register
else if (c_a)begin
			counterA<=counterA+1;
			end
else if (c_b)begin
			counterB<=counterB+1;
			end
else if (c_c)begin
			counterC<=counterC+1;
			end
else if (c_d)begin
			counterD<=counterD+1;
			end
else if (c_e)begin
			counterE<=counterE+1;
			end
else if (c_f)begin
			counterF<=counterF+1;
			end
else if (c_g)begin
			counterG<=counterG+1;
			end
/*else if (draw)begin
		if(counter==8'd255)begin
		counter<=0;
		end
		else begin
		counter<=counter+1;
		end*/
end

always @(posedge clk)begin
if (!resetn)
boardcounter<=0;
else if (!resetb)
boardcounter<=0;
else if (c_a+c_b+c_c+c_d+c_e+c_f+c_g)
boardcounter<=boardcounter+1;
end
//assign output values
assign r=red;
assign b=blue;
assign x=xloc;//+counter[3:0];
assign y=yloc;//+counter[7:4];
//assign colour=outcolour;


/*cycle
always@(posedge clk)begin
		if (!resetn)
			cycle<=9'b0;
		else if (cycle==9'd255)
			cycle<=9'b0;
		else if (en_cycle==1'b1)
			cycle<=cycle+1;
	end
*/
endmodule
