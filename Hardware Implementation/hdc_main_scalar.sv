module hdc_main_scalar (sob, hog, clk, HV);
//input [15:0] sob [0:1023];
input [3:0] sob [0:63];
//input [15:0] hog;
input [3:0] hog [0:143];
input clk;
output [63:0] HV;
//inout reg [7:0] bundle [0:63];

//wire [15:0] unary_out;

//hv_generator hvgen(sob,hog,clk,HV);

//Unary_generator ug(clk,6'b000010,unary_out);
//wire [15:0] t [0:1023];
//wire [15:0] s [0:1023];
//wire [15:0] y [0:1023];
//wire [1023:0] temp;
//reg [15:0] hog_unary;
//reg [15:0] sob_unary [0:1023];

//reg [7:0] temp [0:1023];
/*
integer i,j;
always @(posedge clk) begin
	for (j=0; j<144; j++) begin
		for(i=0; i<64; i++) begin
	
			HV[i] = (sob[i] < hog[j]) ? 1'b0 : 1'b1;
	
		end
	end

end
*/
genvar i,j;
generate

	for (j=0; j<144; j++) begin
		for(i=0; i<64; i++) begin
			comparator cp(sob[i],hog[j],clk,HV[i]);
		end
	end

endgenerate


endmodule




module comparator (a, b, clk, gt);
  input wire [3:0] a;
  input wire [3:0] b;
  input clk;
  //output wire eq,
  output reg gt;
  //output wire lt


  //reg [5:0] a_xor_b;
  //reg [5:0] a_and_b;
  //reg [5:0] a_larger_b;
  
  // XOR the inputs to check for equality
always @(negedge clk) begin
//gt =1;

	if (a > b) begin
		gt = 1;

	end

	else begin
		gt = 0;
	end
	
end

endmodule
