module AI(
input clk,resetn,resetb,
input AI_turn,AI_check,
input [41:0] r_board,
input [41:0] b_board,
input c_a,c_b,c_c,c_d,c_e,c_f,c_g,

output [7:0] AI_COL);

reg [7:0] col;
reg[2:0]counterA;
reg[2:0]counterB;
reg[2:0]counterC;
reg[2:0]counterD;
reg[2:0]counterE;
reg[2:0]counterF;
reg[2:0]counterG;

reg bwinr,bwinc,bwinldiag,bwinrdiag,bwin;
reg[5:0] rowbr,rowbl,colbu;
reg rwinr,rwinc,rwinldiag,rwinrdiag,rwin;
reg[5:0] rowrr,rowrl,colru;
integer i;
//AI 
//order of move
//1. checks if it has a winning combination
//2. checks if opposing has a winning combination
//3. else controls the middle of the baord

always @(posedge clk)begin
if (!resetn)begin
		counterA<=0;
		counterB<=0;
		counterC<=0;
		counterD<=0;
		counterE<=0;
		counterF<=0;
		counterG<=0;
end
else if (!resetb)begin
		counterA<=0;
		counterB<=0;
		counterC<=0;
		counterD<=0;
		counterE<=0;
		counterF<=0;
		counterG<=0;
end
else if (c_a)
counterA<=counterA+1;
else if (c_b)
counterB<=counterB+1;
else if (c_c)
counterC<=counterC+1;
else if (c_d)
counterD<=counterD+1;
else if (c_e)
counterE<=counterE+1;
else if (c_f)
counterF<=counterF+1;
else if (c_g)
counterG<=counterG+1;
end


//check if opposing player might win
always@(posedge clk)begin 
if(!resetn)begin
		bwin<=0;
		bwinr<=0;
		bwinc<=0;
		rowbr<=0;
		rowbl<=0;
		colbu<=0;
		rwin<=0;
		rwinr<=0;
		rwinc<=0;
		rowrr<=0;
		rowrl<=0;
		colru<=0;
end
else if (!resetb)begin
		bwin<=0;
		bwinr<=0;
		bwinc<=0;
		rowbr<=0;
		rowbl<=0;
		colbu<=0;
		rwin<=0;
		rwinr<=0;
		rwinc<=0;
		rowrr<=0;
		rowrl<=0;
		colru<=0;
end
//checks for 3 in a row in any direction of its own colour
else if(AI_check)begin
	if(!rwin)begin
		if (!rwinr)begin
			for(i=0;i<=38;i=i+1)begin
				if ((i<=3) || (i>=7 && i<=10) || (i>=14 && i<=17) || (i>=21 && i<=24) || (i>=28 && i<=31) || (i>=35))begin
					if (r_board[i]&r_board[1+i]&r_board[2+i])begin
						rwin<=1;
						rwinr<=1;
						rowrr<=i;
					end
				end
				else if ((i>=3 && i<=6) || (i>=10 && i<=13) || (i>=17 && i<=20) || (i>=24 && i<=27) || (i>=31 && i<=34) || (i>=35 && i<=41))begin
					if (r_board[i]&r_board[i-1]&r_board[i-2])begin
						rwin<=1;
						rwinr<=1;
						rowrl<=i;
				end
			end
		end
	end
		if(!rwinc)begin
			for(i=0;i<=20;i=i+1)begin
				if(r_board[i]&r_board[7+i]&r_board[14+i])begin
						rwin<=1;
						rwinc<=1;
						colru<=i;
				end
			end
		end
	end
end
//checks for 3 in a row of opposing colour
else if(!bwin)begin
		if (!bwinr)begin
			for(i=0;i<=38;i=i+1)begin
				if ((i<=3) || (i>=7 && i<=10) || (i>=14 && i<=17) || (i>=21 && i<=24) || (i>=28 && i<=31) || (i>=35))begin
					if (b_board[i]&b_board[1+i]&b_board[2+i])begin
						bwin<=1;
						bwinr<=1;
						rowbr<=i;
					end
				end
				else if ((i>=3 && i<=6) || (i>=10 && i<=13) || (i>=17 && i<=20) || (i>=24 && i<=27) || (i>=31 && i<=34) || (i>=35 && i<=41))begin
					if (b_board[i]&b_board[i-1]&b_board[i-2])begin
						bwin<=1;
						bwinr<=1;
						rowbl<=i;
				end
			end
		end
	end
		if(!bwinc)begin
			for(i=0;i<=20;i=i+1)begin
				if(b_board[i]&b_board[7+i]&b_board[14+i])begin
						bwin<=1;
						bwinc<=1;
						colbu<=i;
				end
			end
		end
	end
	else begin
		bwin<=0;
		bwinr<=0;
		bwinc<=0;
		rowbr<=0;
		rowbl<=0;
		colbu<=0;
		rwin<=0;
		rwinr<=0;
		rwinc<=0;
		rowrr<=0;
		rowrl<=0;
		colru<=0;
end
end

//chooses its move 
always @(posedge clk)begin
if (!resetn)begin
col<=0;
end
else if (!resetb)begin
col<=0;
end
//win first, then block, then control middle
else if (AI_turn)begin
if (rwin)begin
	if (rwinr)begin
		if (rowrr)begin
			if ((rowrr==0) || (rowrr==7) || (rowrr==14) || (rowrr==21) || (rowrr==28) || (rowrr==35))
				col<=8'b00010000;
			if ((rowrr==1) || (rowrr==8) || (rowrr==15) || (rowrr==22) || (rowrr==29) || (rowrr==36))
				col<=8'b00100000;
			if ((rowrr==2) || (rowrr==9) || (rowrr==16) || (rowrr==23) || (rowrr==30) || (rowrr==37))
				col<=8'b01000000;
			if ((rowrr==3) || (rowrr==10) || (rowrr==17) || (rowrr==24) || (rowrr==31) || (rowrr==38))
				col<=8'b10000000;
		end
		else if (rowrl)begin
			if ((rowrl==6) || (rowrl==13) || (rowrl==20) || (rowrl==27) || (rowrl==34) || (rowrl==41))
				col<=8'b00010000;
			if ((rowrl==40) || (rowrl==5) || (rowrl==12) || (rowrl==19) || (rowrl==26) || (rowrl==33))
				col<=8'b00001000;
			if ((rowrl==4) || (rowrl==11) || (rowrl==18) || (rowrl==25) || (rowrl==32) || (rowrl==39))
				col<=8'b00000100;
			if ((rowrl==3) || (rowrl==10) || (rowrl==17) || (rowrl==24) || (rowrl==31) || (rowrl==38))
				col<=8'b00000010;
		end
	end
	else if (rwinc)begin
			if ((colbu==0) || (colbu==7) || (colbu==14))
				col<=8'b00000010;
			if ((colbu==1) || (colbu==8) || (colbu==15))
				col<=8'b00000100;
			if ((colbu==2) || (colbu==9) || (colbu==16))
				col<=8'b00001000;
			if ((colbu==3) || (colbu==10) || (colbu==17))
				col<=8'b00010000;
			if ((colbu==4) || (colbu==11) || (colbu==18))
				col<=8'b00100000;
			if ((colbu==5) || (colbu==12) || (colbu==19))
				col<=8'b01000000;
			if ((colbu==6) || (colbu==13) || (colbu==20))
				col<=8'b10000000;
		end
	end

else if (bwin)begin
	if (bwinr)begin
		if (rowbr)begin
			if ((rowbr==0) || (rowbr==7) || (rowbr==14) || (rowbr==21) || (rowbr==28) || (rowbr==35))
				col<=8'b00010000;
			if ((rowbr==1) || (rowbr==8) || (rowbr==15) || (rowbr==22) || (rowbr==29) || (rowbr==36))
				col<=8'b00100000;
			if ((rowbr==2) || (rowbr==9) || (rowbr==16) || (rowbr==23) || (rowbr==30) || (rowbr==37))
				col<=8'b01000000;
			if ((rowbr==3) || (rowbr==10) || (rowbr==17) || (rowbr==24) || (rowbr==31) || (rowbr==38))
				col<=8'b10000000;
		end
		else if (rowbl)begin
			if ((rowbl==6) || (rowbl==13) || (rowbl==20) || (rowbl==27) || (rowbl==34) || (rowbl==41))
				col<=8'b00010000;
			if ((rowbl==40) || (rowbl==5) || (rowbl==12) || (rowbl==19) || (rowbl==26) || (rowbl==33))
				col<=8'b00001000;
			if ((rowbl==4) || (rowbl==11) || (rowbl==18) || (rowbl==25) || (rowbl==32) || (rowbl==39))
				col<=8'b00000100;
			if ((rowbl==3) || (rowbl==10) || (rowbl==17) || (rowbl==24) || (rowbl==31) || (rowbl==38))
				col<=8'b00000010;
		end
	end
	else if (bwinc)begin
			if ((colbu==0) || (colbu==7) || (colbu==14))
				col<=8'b00000010;
			if ((colbu==1) || (colbu==8) || (colbu==15))
				col<=8'b00000100;
			if ((colbu==2) || (colbu==9) || (colbu==16))
				col<=8'b00001000;
			if ((colbu==3) || (colbu==10) || (colbu==17))
				col<=8'b00010000;
			if ((colbu==4) || (colbu==11) || (colbu==18))
				col<=8'b00100000;
			if ((colbu==5) || (colbu==12) || (colbu==19))
				col<=8'b01000000;
			if ((colbu==6) || (colbu==13) || (colbu==20))
				col<=8'b10000000;
	end
end
	else if(counterD<=5)
		col<=8'b00010000;
	else if(counterD>5)begin
		if (counterC<=5)
		col<=8'b00001000;
		else if (counterE<=5)
		col<=8'b00100000;
	end
	else if ((counterD>5)&&(counterC>5)&&(counterE>5))begin
		if (counterB<=5)
		col<=8'b00000100;
		else if (counterF<=5)
		col<=8'b01000000;
	end
	else if ((counterD>5)&&(counterC>5)&&(counterE>5)&&(counterB>5)&&(counterF>5))begin
		if (counterA<=5)
		col<=8'b10000000;
		else if (counterG<=5)
		col<=8'b00000010;
	end
end
end
//assign final column of choice
assign AI_COL=col;

endmodule