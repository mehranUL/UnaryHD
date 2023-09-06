//		Counter Module

module Counter2 (clk, out_count);
	
    input clk;
	//input enable;
	//input rst;
    output reg [5:0] out_count;

    always @(posedge clk)
	    //if (enable)
	    
		if (out_count == 16)
			//out_count <= 0;
			out_count <= 0;
	    else
	    
			out_count <= out_count + 1;
			
		
endmodule