`timescale 1ns/1ns
module connectfour(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,
		SW,	// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,	
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,
		PS2_CLK,PS2_DAT
		);

	input	CLOCK_50;				//	50 MHz
	inout				PS2_DAT;
	inout				PS2_CLK;
	wire clk;
	assign clk = CLOCK_50;
	input	[3:0]	KEY;	
	// Declare your inputs and outputs here
	input [7:0] SW;
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;			//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	output   [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	
	wire resetn;
	assign resetn = KEY[0];
	wire spacebar;
	//assign spacebar = ~KEY[1];
	wire resetb;
	//assign resetb = KEY[2];
	wire colchoose;
	//assign colchoose = ~KEY[3];
	wire [7:0] column;
	assign column=SW[7:0];
	// Create the colour, x, y and writeEn wires that are inputs to the controller
		// Create the colour, x, y and writeEn wires that are inputs to the controller
	wire [8:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn,draw;
	wire [7:0] datakeyboard;
	wire key_press;
	reg space;
	reg resetgame;
	reg choosecol;
	
	PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(datakeyboard),
	.received_data_en	(key_press)
);

	
	always @(posedge clk)begin
	if (!resetn)begin
		space<=0;
		resetgame<=1;
		choosecol<=0;
	end
	else if (key_press)begin
	if (datakeyboard==8'b00101001)
		choosecol<=1;
	else if (datakeyboard==8'b01011010)
		space<=1;
	else if(datakeyboard==8'b01100110)
		resetgame<=0;
	end
	else if (datakeyboard==8'b11110000 && !key_press)begin
		space<=0;
		resetgame<=1;
		choosecol<=0;
	end
end

assign spacebar=space;
assign colchoose=choosecol;
assign resetb=resetgame;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
	
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "mainnew.mif";
		
		game g0(.clk(clk),.resetn(resetn),.resetb(resetb),.spacebar(spacebar),.colchoose(colchoose),.column(column),.xout(x),.yout(y),.colourout(colour),.writeEn(writeEn),.drawwin(drawwin));
		
endmodule

module game(
input clk,resetn,resetb,spacebar,colchoose,
input [7:0] column,

output [7:0] xout,
output [6:0] yout,
output [8:0] colourout,
output writeEn,drawwin);

//wires for signals
wire r_a,r_b,r_c,r_d,r_e,r_f,r_g;
wire b_a,b_b,b_c,b_d,b_e,b_f,b_g;
wire en_cycle,en_cycleb,drawr,drawb,checkr,checkb,plot,drawboard,drawredwin,drawbluewin,gamedraw,rwin,bwin;
wire ai_move,ai_check;
wire c_a,c_b,c_c,c_d,c_e,c_f,c_g;
//wire for ai col
wire [7:0] ai_col;
//wire for x and y
wire [7:0] x_transfer;
wire [6:0] y_transfer;
//wire for colour
wire[7:0] colour_transfer;
//registers for each colour
wire [41:0] red_board;
wire [41:0] blue_board;
//wire for cycle counter
wire[8:0] cycle;
wire[14:0] bcycle;
//wires for win
wire win;
// wires for x,y and colour
wire [7:0] xchip;
wire [6:0] ychip;
wire [8:0] colourchip;
wire [7:0] xboard;
wire [6:0] yboard;
wire [8:0] colourboard;
//wire for board
wire [5:0] boardcounter;

gamecontrol g0(
.clk(clk),
.resetn(resetn),
.resetb(resetb),
.spacebar(spacebar),
.colchoose(colchoose),
.COL(column),.aicol(ai_col),
.cycle(cycle),
.boardcycle(bcycle),
.rwin(rwin),
.bwin(bwin),
.win(win),
.boardcounter(boardcounter),

.r_a(r_a),.r_b(r_b),.r_c(r_c),.r_d(r_d),.r_e(r_e),.r_f(r_f),.r_g(r_g),
.b_a(b_a),.b_b(b_b),.b_c(b_c),.b_d(b_d),.b_e(b_e),.b_f(b_f),.b_g(b_g),
.c_a(c_a),.c_b(c_b),.c_c(c_c),.c_d(c_d),.c_e(c_e),.c_f(c_f),.c_g(c_g),
.en_cycle(en_cycle),.drawr(drawr),.drawb(drawb),.checkr(checkr),.checkb(checkb),
.drawboard(drawboard),.drawredwin(drawredwin),.drawbluewin(drawbluewin),.gamedraw(gamedraw),.en_cycleb(en_cycleb),.writeEn(plot),
.AI_move(ai_move),.AI_check(ai_check));

drawboard d1(
.clk(clk),
.resetn(resetn),.resetb(resetb),

.drawboard(drawboard),.drawredwin(drawredwin),.drawbluewin(drawbluewin),.gamedraw(gamedraw),.en_cycleb(en_cycleb),
.x(xboard),.y(yboard),.colour(colourboard),.boardcycle(bcycle));

AI(
.clk(clk),
.resetn(resetn),.resetb(resetb),
.AI_turn(ai_move),.AI_check(ai_check),.r_board(red_board),.b_board(blue_board),
.c_a(c_a),.c_b(c_b),.c_c(c_c),.c_d(c_d),.c_e(c_e),.c_f(c_f),.c_g(c_g),

.AI_COL(ai_col));


board b2(
.clk(clk),
.resetn(resetn),.resetb(resetb),
.r_a(r_a),.r_b(r_b),.r_c(r_c),.r_d(r_d),.r_e(r_e),.r_f(r_f),.r_g(r_g),
.b_a(b_a),.b_b(b_b),.b_c(b_c),.b_d(b_d),.b_e(b_e),.b_f(b_f),.b_g(b_g),
.c_a(c_a),.c_b(c_b),.c_c(c_c),.c_d(c_d),.c_e(c_e),.c_f(c_f),.c_g(c_g),
//.en_cycle(en_cycle),
.x(x_transfer),.y(y_transfer),.r(red_board),.b(blue_board),.boardcounter(boardcounter));

drawchip d3(
.clk(clk),.resetn(resetn),
.xin(x_transfer),.yin(y_transfer),.cycle(cycle),
.drawr(drawr),.drawb(drawb),.en_cycle(en_cycle),

.xout(xchip),.yout(ychip),.colour(colourchip),.outcycle(cycle));


/*reg [7:0] counter;
reg [8:0] memory_addressr,memory_addressb;
reg [8:0] c;
wire[8:0] colour_b,colour_r;
bluedot b2(.address(memory_addressb),.clock(clk),.data(0),.wren(0),.q(colour_b));
reddot  r3(.address(memory_addressr),.clock(clk),.data(0),.wren(0),.q(colour_r));
always@(posedge clk)begin
if (!resetn)begin
memory_addressr<=0;
memory_addressb<=0;
counter<=0;
c<=0;
end
else if(counter==9'd256)begin
memory_addressr<=0;
memory_addressb<=0;
counter<=0;
end
else if (drawr)begin
memory_addressr<=memory_addressr+1;
counter<=counter+1;
c<=colour_r;
end
else if (drawb)begin
memory_addressb<=memory_addressb+1;
counter<=counter+1;
c<=colour_b;
end
end
assign x=x_transfer+counter[3:0];
assign y=y_transfer+counter[7:4];
assign colour=c;
always@(posedge clk)begin
		if (!resetn)
			cycle<=9'b0;
		else if (cycle==9'd255)
			cycle<=9'b0;
		else if (en_cycle==1'b1)
			cycle<=cycle+1;
	end
*/
gamelogic g5(
.clk(clk),.resetn(resetn),.resetb(resetb),
.red(red_board),.blue(blue_board),
.checkr(checkr),.checkb(checkb),

.rwin(rwin),.bwin(bwin),.win(win));

reg [7:0] xfinal;
reg [6:0] yfinal;
reg [8:0] colourfinal;

always@(posedge clk)begin
if (!resetb || !resetn)begin
xfinal<=0;
yfinal<=0;
colourfinal<=0;
end
else if (drawr || drawb)begin
xfinal<=xchip;
yfinal<=ychip;
colourfinal<=colourchip;
end
else if (drawboard || drawredwin || drawbluewin)begin
xfinal<=xboard;
yfinal<=yboard;
colourfinal<=colourboard;
end
end

assign writeEn=plot;
assign xout=xfinal;
assign yout=yfinal;
assign colourout=colourfinal;
assign drawwin=drawredwin + drawbluewin;

endmodule


module hex_decoder(input [3:0] hex_digits, output reg [6:0] segments);
	
	always @(*)begin
        case (hex_digits)
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0011000;
            4'hA: segments = 7'b0001000;
            4'hB: segments = 7'b0000011;
            4'hC: segments = 7'b1000110;
            4'hD: segments = 7'b0100001;
            4'hE: segments = 7'b0000110;
            4'hF: segments = 7'b0001110;   
            default: segments = 7'h7f;
		  endcase
	end
	
endmodule








		