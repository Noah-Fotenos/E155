// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 2 counter to devide 48mhz clk speed to ~80hz

module lab2_counter(input logic clk, reset,
					output logic [27:0] counter);
					
	always_ff @(posedge clk, negedge reset) begin
		if(reset == 0) counter <= 0; 
		else counter <= counter + 28;
    end
endmodule
