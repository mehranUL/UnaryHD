module flip_bits(
    input reg [1023:0] input_reg,
    output reg [1023:0] output_reg
);

integer i;
reg [63:0] bits_to_flip;

initial begin
    bits_to_flip = 64'b0; // initialize to all zeros
end

always @(*) begin
    for (i = 0; i < 64; i = i + 1) begin
        bits_to_flip[i] = $random % 2; // randomly set each bit to 0 or 1
    end
    output_reg = input_reg ^ {64{bits_to_flip}}; // flip the selected bits
end

endmodule


/*
module random_flip(
  input clk,
  input reset,
  input enable,
  input [1023:0] reg_in,
  output reg [1023:0] reg_out
);

  // Random number generator
  reg [5:0] rng_seed = 6'h5; // Seed value
  always @(posedge clk) begin
    if (reset) begin
      rng_seed <= 6'h5;
    end else if (enable) begin
      rng_seed <= {rng_seed[4:0], rng_seed[5] ^ rng_seed[3]};
    end
  end

  // Flip 64 randomly selected bits
  always @(posedge clk) begin
    if (reset) begin
      reg_out <= 0;
    end else if (enable) begin
      reg_out <= reg_in ^ ({64{rng_seed[5:0]}} & {1024{enable}});
    end
  end

endmodule
*/