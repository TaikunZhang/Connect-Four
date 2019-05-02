`timescale 1ns / 1ns
module gamelogic(
input clk,resetn,resetb,
input [41:0] red,
input [41:0] blue,
input checkr,checkb,

output rwin,bwin,win);

integer i;
reg rwinr,rwinc,rwinldiag,rwinrdiag;
reg bwinr,bwinc,bwinldiag,bwinrdiag;

//row
always@(posedge clk)begin 
if(!resetn || !resetb)
		rwinr<=0;
else if(checkr)begin
		if (!rwinr)begin
			for(i=0;i<=38;i=i+1)begin
				if ((i<=3) || (i>=7 && i<=10) || (i>=14 && i<=17) || (i>=21 && i<=24) || (i>=28 && i<=31) || (i>=35))begin
					if ((red[i]&red[i+1]&red[i+2]&red[i+3]))
						rwinr<=1;
				end
			end
		end
	end
end
	//col
always@(posedge clk)begin 
if(!resetn || !resetb)
	rwinc<=0;
else if(checkr)begin
		if(!rwinc)begin
			for(i=0;i<=20;i=i+1)begin
				if ((red[i]&red[7+i]&red[14+i]&red[21+i]))
					rwinc<=1;
			end
		end
	end
end
//left diag
always@(posedge clk)begin 
if(!resetn || !resetb)
		rwinldiag<=0;
else if(checkr)begin
		if (!rwinldiag)begin
			for(i=0;i<=20;i=i+1)begin
				if (i==20 || i==13 || i==19 || i==6 || i==12 || i==18 || i==11 || i==5 || i==17 || i==4 || i==10 || i==3)begin
					if ((red[i]&red[6+i]&red[12+i]&red[18+i]))
						rwinldiag<=1;
				end					
			end
		end
	end
end
//rightdiag
always@(posedge clk)begin 
if(!resetn || !resetb)
		rwinrdiag<=0;
else if(checkr)begin
		if (!rwinrdiag)begin
			for(i=0;i<=17;i=i+1)begin
				if (i==14 || i==7 || i==15 || i==0 || i==8 || i==16 || i==1 || i==9 || i==17 || i==2 || i==10 || i==3)begin
					if ((red[i]&red[8+i]&red[16+i]&red[24+i]))
						rwinrdiag<=1;
				end					
			end
		end
	end
end
	
always@(posedge clk)begin 
if(!resetn || !resetb)
		bwinr<=0;
else if(checkb)begin
		if (!bwinr)begin
			for(i=0;i<=38;i=i+1)begin
				if (( i<=3) || (i>=7 && i<=10) || (i>=14 && i<=17) || (i>=21 && i<=24) || (i>=28 && i<=31) || (i>=35))begin
					if ((blue[i]&blue[1+i]&blue[2+i]&blue[3+i]))begin
						bwinr<=1;
					end
				end
			end
		end
	end
end
always@(posedge clk)begin 
if(!resetn || !resetb)
		bwinc<=0;
else if(checkb)begin
		if(!bwinc)begin
			for(i=0;i<=20;i=i+1)begin
				if ((blue[i]&blue[7+i]&blue[14+i]&blue[21+i]))begin
						bwinc<=1;
				end
			end
		end
	end
end
always@(posedge clk)begin 
if(!resetn || !resetb)
		bwinldiag<=0;
else if(checkb)begin
		if (!bwinldiag)begin
			for(i=0;i<=20;i=i+1)begin
				if (i==20 || i==13 || i==19 || i==6 || i==12 || i==18 || i==5 || i==11 || i==17 || i==4 || i==10 || i==3)begin
					if ((blue[i]&blue[6+i]&blue[12+i]&blue[18+i]))begin
						bwinldiag<=1;
					end
				end
			end
		end
	end
end

always@(posedge clk)begin 
if(!resetn || !resetb)
		bwinrdiag<=0;
else if(checkb)begin
		if (!bwinrdiag)begin
			for(i=0;i<=17;i=i+1)begin
					if (i==14 || i==7 || i==15 || i==0 || i==8 || i==16 || i==1 || i==9 || i==17 || i==2 || i==10 || i==3)begin
						if ((blue[i]&blue[8+i]&blue[16+i]&blue[24+i])== 4)begin
							bwinrdiag<=1;
						end
					end					
				end
			end
		end
	end
	
assign rwin=rwinr+rwinc+rwinldiag+rwinrdiag;
assign bwin=bwinr+bwinc+bwinldiag+bwinrdiag;
assign win=rwin+bwin;
endmodule
	
	
	
	
	

		
	
	

		