`timescale 1ns/1ns
module drawbluechip(
input clk,resetn,drawb,
input [7:0] xin,
input [6:0] yin,
input en_cycle,

output [7:0] xout,
output [6:0] yout,
output [7:0] colour,
output reg [8:0] cycle);


reg [7:0] counter;
reg [8:0] memory_address;




always@(posedge clk)begin
if (!resetn)begin
memory_address<=0;
counter<=0;
end
else if(counter==9'd255)begin
memory_address<=1'b0;
end
else if (drawb)begin
memory_address<=memory_address+1;
counter<=counter+1;
end
end
bluedot b1(.address(memory_address),.clock(clk),.data(0),.wren(0),.q(colour));
assign xout=xin+counter[3:0];
assign yout=yin+counter[7:4];

always@(posedge clk)begin
		if (!resetn)
			cycle<=9'b0;
		else if (cycle==9'd255)
			cycle<=9'b0;
		else if (en_cycle==1'b1)
			cycle<=cycle+1;
	end

endmodule

	