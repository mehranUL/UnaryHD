module baseline_hdc (lfsr_out,rf_out,clk,xored);

input [1023:0] lfsr_out;	//This is the equivalent P hypervector.
input [1023:0] rf_out;	//This is the equivalent L hypervector.
input clk;
output reg [1023:0] xored;
//reg [7:0] temp [2047:0];
integer i;
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
//random_flip urf(input_reg_rf, clk, rf_out);
//lfsr ulfsr(seed_lfsr, scalar_lfsr, clk, lfsr_out);


//always @(rst) begin
  // for (n = 0; n < 2048; n = n+1)begin
	//	  bundled_bl[n] <= 0;
   //end 
   
//end


//always @(posedge clk & !rst) begin
always @(posedge clk) begin
    //if (rst) begin
	   
	//end else begin
	   //temp = bundled_bl;
	   
	    for (i=0; i<1024; i++)begin
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




