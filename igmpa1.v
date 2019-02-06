`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 04:36:42 AM
// Design Name: 
// Module Name: igmpa1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps



module igmpa1_tb();
reg clk;
reg reset;
reg [31:0] h1,h2,h3,h4;
wire valid;
wire invalid;
wire [7:0] typea;
wire [7:0] mrc;
wire [15:0] checksum;
wire [31:0] groupadd;
wire [3:0] resv;
wire s;
wire [2:0] qrv;
wire [7:0] qqic;
wire [15:0] source;
wire [31:0] sourceadd;




wire [3:0] x1;
assign x1=DUT.state;
receiving_igmp DUT(valid,invalid,clk,rst,h1,h2,h3,h4,typea,mrc,checksum,groupadd,resv,s,qrv,qqic,source,member_query,member_report,leave_group,sourceadd);
initial
begin
clk=0;
reset=1;

#30 reset=0;
end


initial 
begin 
ih1 <= 32'b01000101000000010000000000011000;
ih2 <= 32'b10101010110111010101101101011011;
ih3 <= 32'b10101010110000000000000010101101;
ih4 <= 32'b11010110110101110011101111110111;

#100000 $finish;
end 
 
always
begin
#20 clk=~clk;
end 


endmodule




