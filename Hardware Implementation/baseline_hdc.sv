module baseline_hdc (input_reg_rf, seed_lfsr, scalar_lfsr, clk, rst, en, bundled_bl);
input [2047:0] input_reg_rf; //This is equivalent to intensity vector full of ones vector.
input reg [10:0] seed_lfsr;	//Initial value of seed = 10'b0011100001
input reg [12:0] scalar_lfsr;	//The scalar value for D=1k in LFSR is D/2 which is 512 or scalar = 12'h200
input clk;
input rst;
input en;  //Determines the new arrival input
output reg [2047:0] bundled_bl;	//The result of bundling operation of P and L hypervectors.
//);

reg [2047:0] lfsr_out;	//This is the equivalent P hypervector.
reg [2047:0] rf_out;	//This is the equivalent L hypervector.
reg [2047:0] xored;
reg [7:0] temp [2047:0];
integer i,n,j;
//integer threshold = 72;

//genvar t,s;
//generate
	//for (t=0; t<143; t++) begin
		//lfsr ulfsr(seed_lfsr, scalar_lfsr, clk, lfsr_out[t]);
	//end
//endgenerate

/*
generate
	for (s=0; s<16; s++)begin
		random_flip urf(input_reg_rf, clk, rf_out[s]);
	end
	for (t=0; t<143; t++) begin
		lfsr ulfsr(seed_lfsr, scalar_lfsr, clk, lfsr_out[t]);
	end
endgenerate
*/
random_flip urf(input_reg_rf, clk, rf_out);
lfsr ulfsr(seed_lfsr, scalar_lfsr, clk, lfsr_out);


//always @(rst) begin
  // for (n = 0; n < 2048; n = n+1)begin
	//	  bundled_bl[n] <= 0;
   //end 
   
//end


//always @(posedge clk & !rst) begin
always @(en) begin
    //if (rst) begin
	   
	//end else begin
	   //temp = bundled_bl;
	   
	    for (i=0; i<2048; i++)begin
				xored[i] = lfsr_out[i] ^ rf_out[i];
		  //bundled_bl[i] = bundled_bl[i] + xored[i];
		end
	   
	   //**for (i=0; i<1024; i++)begin
		   //for (j=0; j<143; j++)begin
		  //xored[i] = lfsr_out[i] ^ rf_out[i];
		  //temp[i] = bundled_bl[i];
				//**temp[i] = temp[i] + xored[i];
				//**bundled_bl[i] = ((temp[i] - 72) >= 0)? 1'b1 : 1'b0;
		   //end
		  
	   //**end
	//end
		//bundled_bl = temp;
end
//assign bundled_bl = temp;

endmodule




module lfsr(seed, scalar, clk, bs);
inout reg [10:0] seed;
input reg [12:0] scalar;
input clk;
output reg [2047:0] bs;

reg tap;

//initial begin
//bs[0] <= (scalar > seed) ? 1 : 0;
//end

always @(clk) begin
	integer i;
	bs[0] <= (scalar > seed) ? 1 : 0;
	for (i = 0; i < 2048; i = i+1) begin
		tap = ((seed[11] ^ seed[5]) ^ seed[3]) ^ seed[1];
		
		
		//$display("xxxxxx %d", scalar);
		seed[10] = seed[9];
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
  input [2047:0] input_reg,
  input clk,
  output reg [2047:0] output_reg
);


reg [127:0] lfsr_state;
  //initial begin
	//lfsr_state = 64'hACE1_35F2_4BD7_A912;
  //end
  //reg [63:0] lfsr_state = 32'hACE1_35F2;
  //reg [63:0] flip_mask;

  always @(posedge clk) begin
    output_reg = input_reg;

    for (int i = 0; i < 128; i++) begin
      if (lfsr_state[13]) begin
        output_reg[lfsr_state%2048] = ~input_reg[lfsr_state%2048];
      end
      
      //lfsr_state[i] <= lfsr_state[0] ^ lfsr_state[1] ^ lfsr_state[2] ^ lfsr_state[31];
      lfsr_state = {lfsr_state[126:0], lfsr_state[0] ^ lfsr_state[127]};
      //lfsr_state = {lfsr_state[30:0], flip_mask[i]};
    end
  end

endmodule