module random_flip(
  input [255:0] input_reg,
  input clk,
  output reg [255:0] output_reg
);

//reg [127:0] lfsr_state;
reg [5:0] seed;
reg tap;
  //initial begin
	//lfsr_state = 64'hACE1_35F2_4BD7_A912;
  //end
  //reg [63:0] lfsr_state = 32'hACE1_35F2;
  //reg [63:0] flip_mask;

  always @(posedge clk) begin
    output_reg = input_reg;

    for (int i = 0; i < 64; i++) begin
	  /*
      if (lfsr_state[13]) begin
        output_reg[lfsr_state%255] = ~input_reg[lfsr_state%255];
      end
      
      //lfsr_state[i] <= lfsr_state[0] ^ lfsr_state[1] ^ lfsr_state[2] ^ lfsr_state[31];
      lfsr_state = {lfsr_state[126:0], lfsr_state[0] ^ lfsr_state[127]};
      //lfsr_state = {lfsr_state[30:0], flip_mask[i]};
	  */
		tap = seed[5] ^ seed[2];
	  
		//seed[6] = seed[5];
		seed[5] = seed[4];
		seed[4] = seed[3];
		seed[3] = seed[2];
		seed[2] = seed[1];
		seed[1] = seed[0];
		seed[0] = tap;
		
		output_reg[seed] = ~output_reg[seed];
    end
  end

endmodule