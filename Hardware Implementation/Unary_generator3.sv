module Unary_generator (clk,ref_no,unary_out);
input clk;
input [3:0] ref_no;
output reg [15:0] unary_out;

//reg [5:0] cnt_out = 0;
//wire gt;

//reg [5:0] temp1;

reg [15:0] unary_table [0:15];

initial begin

unary_table[0] = 16'b0000000000000000;
unary_table[1] = 16'b1000000000000000;
unary_table[2] = 16'b1100000000000000;
unary_table[3] = 16'b1110000000000000;
unary_table[4] = 16'b1111000000000000;
unary_table[5] = 16'b1111100000000000;
unary_table[6] = 16'b1111110000000000;
unary_table[7] = 16'b1111111000000000;
unary_table[8] = 16'b1111111100000000;
unary_table[9] = 16'b1111111110000000;
unary_table[10] = 16'b1111111111000000;
unary_table[11] = 16'b1111111111100000;
unary_table[12] = 16'b1111111111110000;
unary_table[13] = 16'b1111111111111000;
unary_table[14] = 16'b1111111111111100;
unary_table[15] = 16'b1111111111111110;   

end

always @(posedge clk) begin
 unary_out = unary_table[ref_no];
end

endmodule


 

