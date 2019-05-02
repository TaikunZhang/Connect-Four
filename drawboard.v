module drawboard(
input clk,resetn,resetb,
input drawboard,drawredwin,drawbluewin,gamedraw,en_cycleb,

output [8:0] colour,
output [7:0] x,
output [6:0] y,
output reg [14:0] boardcycle);

reg [7:0] xcounter;
reg [6:0] ycounter;
wire [14:0] counter;
reg [14:0] memory_address;
wire[8:0] colourboard;
wire[8:0] coloured;
wire [8:0] colourblue;
wire [8:0]colourdraw;
reg[8:0] outcolour;



pictureboard p0(.address(memory_address),.clock(clk),.data(0),.wren(0),.q(colourboard));
redwin r1(.address(memory_address),.clock(clk),.data(0),.wren(0),.q(coloured));
bluewin b2(.address(memory_address),.clock(clk),.data(0),.wren(0),.q(colourblue));
gamedraw g3(.address(memory_address),.clock(clk),.data(0),.wren(0),.q(colourdraw));

always@(posedge clk)begin
if(!resetn || !resetb)begin
xcounter<=0;
ycounter<=0;
memory_address<=0;
end
else if ((ycounter==7'd119) && (xcounter==8'd159))begin
xcounter<=0;
ycounter<=0;
memory_address<=0;
outcolour<=0;
end
else if (drawboard)begin
outcolour<=colourboard;
memory_address<=memory_address+1;
if (xcounter<8'd160)begin
xcounter<=xcounter+1;
end
if (xcounter>=8'd159 && ycounter<7'd120)begin
ycounter<=ycounter+1;
xcounter<=0;
end
end
else if (drawredwin)begin
memory_address<=memory_address+1;
outcolour<=coloured;
if (xcounter<8'd160)begin
xcounter<=xcounter+1;
end
if (xcounter>=8'd159 && ycounter<7'd120)begin
ycounter<=ycounter+1;
xcounter<=0;
end
end
else if (drawbluewin)begin
memory_address<=memory_address+1;
outcolour<=colourblue;
if (xcounter<8'd160)begin
xcounter<=xcounter+1;
end
if (xcounter>=8'd159 && ycounter<7'd120)begin
ycounter<=ycounter+1;
xcounter<=0;
end
end
else if (gamedraw)begin
memory_address<=memory_address+1;
outcolour<=colourdraw;
if (xcounter<8'd160)begin
xcounter<=xcounter+1;
end
if (xcounter>=8'd159 && ycounter<7'd120)begin
ycounter<=ycounter+1;
xcounter<=0;
end
end
end

assign x=xcounter;
assign y=ycounter;
assign colour=outcolour;

always@(posedge clk)begin
		if (!resetn)
			boardcycle<=15'b0;
		else if (boardcycle==15'd19199)
			boardcycle<=15'b0;
		else if (en_cycleb==1'b1)
			boardcycle<=boardcycle+1;
end
endmodule








