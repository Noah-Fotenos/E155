// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 decode button press module

module lab3_holdstate(input logic clk, reset, en,
                    input logic [3:0] num_in, 
                    output logic [3:0] num_out,
                    output logic [1:0] anodes);
		logic [3:0] in1, in2;
		logic temp;  
        always_ff @(posedge clk,  negedge reset) begin
            if(reset == 0) begin
				in1 <= 4'b0000;
				in2 <= 4'b0000;
				temp <= 1;
				end
            else  begin 
					if (en&temp) begin
						in1 <= num_in;
						in2 <= in1;
						temp <= 0; 
						end
                     else if (~en)begin
						 temp <= 1; 
						 end
				end
        end

    // 7-segment decoder instantiation
	always_comb begin
		if(clk) num_out = in2;  //alternate signal decoding
		else num_out = in1; 
		end	

    // alternate led power supply
    assign anodes[0] = clk;
    assign anodes[1] = ~clk;
endmodule
