module hdc_main (sob, hog, clk, HV, bundle);
//input [15:0] sob [0:1023];
input [3:0] sob [0:63];
//input [15:0] hog;
input [3:0] hog;
input clk;
output [63:0] HV;
inout reg [7:0] bundle [0:63];

//wire [15:0] unary_out;

//hv_generator hvgen(sob,hog,clk,HV);

//Unary_generator ug(clk,6'b000010,unary_out);
//wire [15:0] t [0:1023];
//wire [15:0] s [0:1023];
//wire [15:0] y [0:1023];
//wire [1023:0] temp;
reg [15:0] hog_unary;
reg [15:0] sob_unary [0:63];

//reg [7:0] temp [0:63];


genvar ii,jj;

Unary_generator ugenhog(clk,hog,hog_unary);

//assign temp = bundle;


generate

    //for (ii=0; ii<2; ii=ii+1)
		  for (jj=0; jj<64; jj=jj+1) begin
			 Unary_generator ugensob(clk,sob[jj],sob_unary[jj]);
			 hv_generator hvgen(sob_unary[jj],hog_unary,clk,HV[jj]);
			 
			 
			 //assign temp[jj] = temp[jj] + HV[jj];
			 //bundle[jj] = temp[jj][6] & temp[jj][3];
		  end
		  //assign bundle = temp;

endgenerate
/*
integer m,n;
always @(posedge clk) begin

	//for (n = 0; n < 1024; n = n+1)begin
		//bundle[n] = 0;
	//end
	//for (m = 0; m < 2; m = m+1)begin
		for (n = 0; n < 1024; n = n+1)begin
			bundle[n] = bundle[n] + HV[n];
		end
	//end
end
*/
endmodule


module hv_generator (a,b,clk,HVb);
input [15:0] a, b; // a,b are two unary bitstreams
input clk;
output HVb;

wire [15:0] t,s;
wire [15:0] y;
//wire eq,gt,lt;
wire temp;


not n1(t[0],a[0]);
not n2(t[1],a[1]);
not n3(t[2],a[2]);
not n4(t[3],a[3]);
not n5(t[4],a[4]);
not n6(t[5],a[5]);
not n7(t[6],a[6]);
not n8(t[7],a[7]);
not n9(t[8],a[8]);
not n10(t[9],a[9]);
not n11(t[10],a[10]);
not n12(t[11],a[11]);
not n13(t[12],a[12]);
not n14(t[13],a[13]);
not n15(t[14],a[14]);
not n16(t[15],a[15]);


and a1(s[0],a[0],b[0]);
and a2(s[1],a[1],b[1]);
and a3(s[2],a[2],b[2]);
and a4(s[3],a[3],b[3]);
and a5(s[4],a[4],b[4]);
and a6(s[5],a[5],b[5]);
and a7(s[6],a[6],b[6]);
and a8(s[7],a[7],b[7]);
and a9(s[8],a[8],b[8]);
and a10(s[9],a[9],b[9]);
and a11(s[10],a[10],b[10]);
and a12(s[11],a[11],b[11]);
and a13(s[12],a[12],b[12]);
and a14(s[13],a[13],b[13]);
and a15(s[14],a[14],b[14]);
and a16(s[15],a[15],b[15]);

or o1(y[0],t[0],s[0]);
or o2(y[1],t[1],s[1]);
or o3(y[2],t[2],s[2]);
or o4(y[3],t[3],s[3]);
or o5(y[4],t[4],s[4]);
or o6(y[5],t[5],s[5]);
or o7(y[6],t[6],s[6]);
or o8(y[7],t[7],s[7]);
or o9(y[8],t[8],s[8]);
or o10(y[9],t[9],s[9]);
or o11(y[10],t[10],s[10]);
or o12(y[11],t[11],s[11]);
or o13(y[12],t[12],s[12]);
or o14(y[13],t[13],s[13]);
or o15(y[14],t[14],s[14]);
or o16(y[15],t[15],s[15]);


assign temp = &(y);
assign HVb = ~temp;


//comparator_16bit cmp16(y,16'hffff,clk,gt);
//always @(gt)
//    HVb = gt ? 1'b1 : 1'b0;

endmodule


module Unary_generator (clk,ref_no,unary_out);
input clk;
input [3:0] ref_no;
output reg [15:0] unary_out = 0 ;

//reg [5:0] cnt_out = 0;
wire gt;

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

/*
module DFF(D,clk,rst,Q);
input D; // Data input 
input clk; // clock input 
input rst; // asynchronous reset high level
output reg Q; // output Q 
always @(posedge clk or posedge async_reset) 
begin
 if(rst==1'b1)
  Q <= 1'b0; 
 else 
  Q <= D; 
end 
endmodule 
*/

/*
module comparator_16bit(
  input [15:0] a,
  input [15:0] b,
  input clk,
  //output reg eq,
  output reg gt
  //output reg lt
);

always @(posedge clk)begin

    if (a > b)
        gt = 1;
    else
        gt = 0;

end
  /*reg [15:0] a_xnor_b;
  reg [15:0] a_and_b;
  reg [15:0] a_larger_b;
  
 always @(negedge clk)begin
  // XOR the inputs to check for equality
    assign a_xnor_b = a ~^ b;
  //assign eq = &a_xor_b;
    //assign eq = a_xnor_b;
  
  // AND the inputs to check if both are 1s
    assign a_and_b = a & b;
  
  // Compare the most significant bits to determine if a is larger than b
    assign a_larger_b = (a[15] == b[15]) ? (a_and_b[15] ? a_larger_b[14:0] : 16'b0) : (a[15] ? 1 : 0);
    assign gt = a_larger_b[15];
  
  // Invert the output of the previous comparison to determine if a is less than b
    //assign lt = ~a_larger_b[15];
  
 end
  
endmodule
*/

/*
			 assign t[jj][0] = ~sob[jj][0];
			 assign t[jj][1] = ~sob[jj][1];
			 assign t[jj][2] = ~sob[jj][2];
			 assign t[jj][3] = ~sob[jj][3];
			 assign t[jj][4] = ~sob[jj][4];
			 assign t[jj][5] = ~sob[jj][5];
			 assign t[jj][6] = ~sob[jj][6];
			 assign t[jj][7] = ~sob[jj][7];
			 assign t[jj][8] = ~sob[jj][8];
			 assign t[jj][9] = ~sob[jj][9];
			 assign t[jj][10] = ~sob[jj][10];
			 assign t[jj][11] = ~sob[jj][11];
			 assign t[jj][12] = ~sob[jj][12];
			 assign t[jj][13] = ~sob[jj][13];
			 assign t[jj][14] = ~sob[jj][14];
			 assign t[jj][15] = ~sob[jj][15];
			 
			 assign s[jj][0] = sob[jj][0] & hog[0];
			 assign s[jj][1] = sob[jj][1] & hog[1];
			 assign s[jj][2] = sob[jj][2] & hog[2];
			 assign s[jj][3] = sob[jj][3] & hog[3];
			 assign s[jj][4] = sob[jj][4] & hog[4];
			 assign s[jj][5] = sob[jj][5] & hog[5];
			 assign s[jj][6] = sob[jj][6] & hog[6];
			 assign s[jj][7] = sob[jj][7] & hog[7];
			 assign s[jj][8] = sob[jj][8] & hog[8];
			 assign s[jj][9] = sob[jj][9] & hog[9];
			 assign s[jj][10] = sob[jj][10] & hog[10];
			 assign s[jj][11] = sob[jj][11] & hog[11];
			 assign s[jj][12] = sob[jj][12] & hog[12];
			 assign s[jj][13] = sob[jj][13] & hog[13];
			 assign s[jj][14] = sob[jj][14] & hog[14];
			 assign s[jj][15] = sob[jj][15] & hog[15];
			 
			 			 
			 assign y[jj][0] = t[jj][0] | s[jj][0];
			 assign y[jj][1] = t[jj][1] | s[jj][1];
			 assign y[jj][2] = t[jj][2] | s[jj][2];
			 assign y[jj][3] = t[jj][3] | s[jj][3];
			 assign y[jj][4] = t[jj][4] | s[jj][4];
			 assign y[jj][5] = t[jj][5] | s[jj][5];
			 assign y[jj][6] = t[jj][6] | s[jj][6];
			 assign y[jj][7] = t[jj][7] | s[jj][7];
			 assign y[jj][8] = t[jj][8] | s[jj][8];
			 assign y[jj][9] = t[jj][9] | s[jj][9];
			 assign y[jj][10] = t[jj][10] | s[jj][10];
			 assign y[jj][11] = t[jj][11] | s[jj][11];
			 assign y[jj][12] = t[jj][12] | s[jj][12];
			 assign y[jj][13] = t[jj][13] | s[jj][13];
			 assign y[jj][14] = t[jj][14] | s[jj][14];
			 assign y[jj][15] = t[jj][15] | s[jj][15];
			 
			 assign temp[jj] = &(y[jj]);
			 assign HV[jj] = ~temp[jj];
			*/