module baseline_hdc (input_reg_rf, seed_lfsr, scalar_lfsr, clk, rst, en, bundled_bl);
input [4095:0] input_reg_rf; //This is equivalent to intensity vector full of ones vector.
input reg [9:0] seed_lfsr;	//Initial value of seed = 10'b0011100001
input reg [11:0] scalar_lfsr;	//The scalar value for D=1k in LFSR is D/2 which is 512 or scalar = 12'h200
input clk;
input rst;
input en;  //Determines the new arrival input
output reg [7:0] bundled_bl[0:4095];	//The result of bundling operation of P and L hypervectors.
//);

reg [4095:0] lfsr_out;	//This is the equivalent P hypervector.
reg [4095:0] rf_out;	//This is the equivalent L hypervector.
reg [4095:0] xored;
reg [7:0] temp [4095:0];
integer i,n;

lfsr ulfsr(seed_lfsr, scalar_lfsr, clk, lfsr_out);

random_flip urf(input_reg_rf, clk, rf_out);

//always @(rst) begin
  // for (n = 0; n < 4096; n = n+1)begin
	//	  bundled_bl[n] <= 0;
   //end 
   
//end


//always @(posedge clk & !rst) begin
always @(en) begin
    //if (rst) begin
	   
	//end else begin
	   temp = bundled_bl;
	   for (i=0; i<4096; i=i+1)begin
		  xored[i] = lfsr_out[i] ^ rf_out[i];
		  //bundled_bl[i] = bundled_bl[i] + xored[i];
	   end
	   for (i=0; i<4096; i=i+1)begin
		  //xored[i] = lfsr_out[i] ^ rf_out[i];
		  //temp[i] = bundled_bl[i];
		  temp[i] = temp[i] + xored[i];
	   end
	//end
		//bundled_bl = temp;
end
assign bundled_bl = temp;

endmodule




module lfsr(seed, scalar, clk, bs);
inout reg [9:0] seed;
input reg [11:0] scalar;
input clk;
output reg [4095:0] bs;

reg tap;

//initial begin
//bs[0] <= (scalar > seed) ? 1 : 0;
//end

always @(clk) begin
	integer i;
	bs[0] <= (scalar > seed) ? 1 : 0;
	for (i = 0; i < 4095; i = i+1) begin
		tap = ((seed[9] ^ seed[5]) ^ seed[2]) ^ seed[1];
		
		
		//$display("xxxxxx %d", scalar);
		seed[9] = seed[8];
		seed[8] = seed[7];
		seed[7] = seed[6];
		seed[6] = seed[5];
		seed[5] = seed[4];
		seed[4] = seed[3];
		seed[3] = seed[2];
		seed[2] = seed[1];
		seed[1] = seed[0];
		seed[0] = tap;
		
		bs[i+1] <= (scalar > seed)?1'b1:1'b0;
	
	end

end

endmodule



module random_flip(
  input [4095:0] input_reg,
  input clk,
  output reg [4095:0] output_reg
);

reg [63:0] lfsr_state;
  //initial begin
	//lfsr_state = 64'hACE1_35F2_4BD7_A912;
  //end
  //reg [63:0] lfsr_state = 32'hACE1_35F2;
  //reg [63:0] flip_mask;

  always @(posedge clk) begin
    output_reg = input_reg;

    for (int i = 0; i < 64; i++) begin
      if (lfsr_state[13]) begin
        output_reg[lfsr_state%4096] = ~input_reg[lfsr_state%4096];
      end
      
      //lfsr_state[i] <= lfsr_state[0] ^ lfsr_state[1] ^ lfsr_state[2] ^ lfsr_state[31];
      lfsr_state = {lfsr_state[62:0], lfsr_state[0] ^ lfsr_state[63]};
      //lfsr_state = {lfsr_state[30:0], flip_mask[i]};
    end
  end

endmodule