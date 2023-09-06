module lfsr(seed, scalar, clk, bs);
inout reg [10:0] seed;
input reg [10:0] scalar;
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
		tap = ((seed[10] ^ seed[3]) ^ seed[1]) ^ seed[0];
		
		
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