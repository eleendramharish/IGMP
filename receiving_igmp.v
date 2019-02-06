`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2019 05:26:52 PM
// Design Name: 
// Module Name: receiving_igmp
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
//////////////////////////////////////////////////////////////////////////////////


module receiving_igmp(valid,invalid,clk,rst,h1,h2,h3,h4,typea,mrc,checksum,groupadd,resv,s,qrv,qqic,source,member_query,member_report,leave_group,sourceadd);
input [31:0]h1,h2,h3;

parameter N=31;
input [N:0]h4;
input clk;
input rst;

output reg valid,invalid,s;
output reg [2:0] qrv;
output reg [7:0] typea,mrc,qqic;
output reg [15:0] checksum,source;
output reg [31:0] groupadd;
output reg [3:0] resv;
output reg member_query;
output reg member_report;
output reg leave_group;
output reg [31:0] sourceadd;


always@( posedge clk)
     if(rst)
            begin
            valid = 0;
            invalid = 0;
            s = 0;
            qrv = 3'b0;
            typea = 8'b0;
            mrc = 8'b0;
            qqic = 8'b0;
            checksum = 16'b0;
            source = 16'b0;
            groupadd = 32'b0;
            member_query = 1'b0;
            member_report = 1'b0;
            leave_group =1'b0;
            sourceadd = 32'b0;
            end
     else
            begin
            typea [7:0] <= h1[31:24];
            mrc [7:0] = h1[23:16];
            checksum [15:0] = h1[15:0];
            groupadd [31:0] = h2[31:0];
            s = h3[27:27];
            qrv [2:0] = h3[26:23];
            qqic [7:0] = h3[23:16];
            source [7:0] = h3[15:0];
            sourceadd [N:0] = h4[N:0];
            end 

parameter p0=0;
parameter p1=1;
parameter p2=2;
parameter p3=3;
parameter p4=4;
parameter p5=5;
parameter p6=6;
parameter p7=7;
parameter p8=8;
parameter p9=9;
parameter p10=10;
parameter p11=11;


reg [4:0] state;

always@(posedge clk)
     if(rst)
            begin
                valid=0;
            end    
     else
            begin
            case(state)
            p0: begin
                 if(typea === 8'b0)
                     begin
                        member_query = 1; 
                        state = p1;
                     end
                 if(typea === 8'b1)     
                     begin
                        member_report = 1; 
                        state = p1;
                     end
                 if(typea === 8'b10)     
                     begin
                        leave_group = 1; 
                        state = p1;
                     end
                 else
                     begin 
                        state = p9;
                     end 
                 end
            p1: begin
                 if(mrc === 8'b1010)
                     begin
                        state = p2;
                     end
                 else
                     begin
                        state = p9;
                     end           
                 end
            p2: begin
                      if(checksum === 16'b1011010111001110)
                          begin
                             state = p3;
                          end
                      else
                          begin
                             state = p9;
                          end           
                      end
            p3: begin
                      if(groupadd === 32'b10101010110111010101101101011011)
                           begin
                              state = p4;
                           end
                      else
                           begin
                              state = p9;
                           end           
                      end                 
                              
            p4: begin
                      if(s === 1)
                           begin
                              state = p5;
                           end
                      else
                           begin
                              state = p9;
                           end           
                      end                       
                                             
            p5: begin
                      if(qrv === 3'b101)
                            begin
                                state = p6;
                            end
                      else
                            begin
                                state = p9;
                            end           
                      end
            p6: begin
                      if(qqic === 8'b10000000)
                            begin
                                 state = p7;
                            end
                      else
                            begin
                                 state = p9;
                            end           
                      end
            p7: begin
                      if(source === 16'b1010101110101101)
                             begin
                                  state = p8;
                             end
                      else
                             begin
                                  state = p9;
                             end           
                      end
            p8: begin
                      if(sourceadd === 32'b11010110110101110011101111110111)
                            begin
                                  valid = 1;  
                            end
                      else
                            begin
                                  state = p9;
                            end
                 end                       
            p9: begin
                      invalid = 1;  
                 end  
                 default:state=p0;                    
            endcase
            end          
                          
endmodule
