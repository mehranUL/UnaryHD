module Unary_generator (clk,ref_no,unary_out,cnt_out,gt);
input clk;
input [5:0] ref_no;
output reg [15:0] unary_out = 0 ;

output reg [5:0] cnt_out = 6'b0;
output gt;

//always @(posedge clk) begin
	Counter2 cnt(clk,cnt_out);
//end
//always @(posedge clk) begin
	comparator cmp(ref_no,cnt_out,clk,gt);
//end
always @(posedge clk) begin
      if (cnt_out == 17)
            unary_out = 16'b0;
      else
	       unary_out = {unary_out[14:0] ,gt}; 
end
/*
always @(negedge clk) begin
    if (cnt_out == 17)
            unary_out = 16'b0;
end
*/
endmodule



 
 

