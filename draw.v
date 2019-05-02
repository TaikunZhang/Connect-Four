`timescale 1ns/1ns
module draw(
input clk,resetn,drawr,drawb,
input [7:0] xin,
input [6:0] yin,
input en_cycle,

output [7:0] xout,
output [6:0] yout,
output [8:0] colour,
output reg [8:0] cycle);


reg [7:0] counter;
reg [8:0] memory_addressr,memory_addressb;
reg [8:0] c;
wire [8:0] colour_b,colour_r;



bluedot b0(.address(memory_addressb),.clock(clk),.data(0),.wren(0),.q(colour_b));
reddot  r1(.address(memory_addressr),.clock(clk),.data(0),.wren(0),.q(colour_r));

always@(posedge clk)begin
if (!resetn)begin
memory_addressr<=0;
memory_addressb<=0;
counter<=0;
c<=0;
end
else if(counter==9'd255)begin
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

assign xout=xin+counter[3:0];
assign yout=yin+counter[7:4];
assign colour=c;

always@(posedge clk)begin
		if (!resetn)
			cycle<=9'b0;
		else if (cycle==9'd255)
			cycle<=9'b0;
		else if (en_cycle==1'b1)
			cycle<=cycle+1;
	end

endmodule

	