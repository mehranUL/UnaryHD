module bundling(xored, clk, bin_HV);

//input [63:0] xored [0:143];
input xored [0:143];
input clk;
//output reg [63:0] bin_HV;
output reg bin_HV;

//reg [7:0] temp [0:63];
reg [7:0] temp;

integer i,j;
always @(posedge clk) begin

	//for(i=0; i<64; i++) begin
		for (j=0; j<144; j++) begin
			//temp[i] = temp[i] + xored[j][i]; 
			temp = temp + xored[j];
		end
		//bin_HV[i] = (temp[i] >= 72) ? 1'b1 : 1'b0;
		bin_HV = (temp >= 72) ? 1'b1 : 1'b0;
	//end

end



endmodule