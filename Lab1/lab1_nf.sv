// Noah Fotenos
// nfotenos@g.hmc.edu
//8_28_2025
// E155 lab_1
module lab1_nf(
			input logic [3:0]s,
			output logic [2:0]led,
			output logic [6:0]seg);
	
   logic [33:0] counter;    // Counter

   	// Internal high-speed oscillator
   	logic int_osc;
	HSOSC #(.CLKHF_DIV(2'b00)) 
    hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
   always_ff @(posedge int_osc) begin
		counter <= counter + 859;
   end
   // Assign LED output
   assign led[2] = counter[33];
   assign led[1] = s[3] & s[2];
   assign led[0] = s[1] ^ s[0];
   
   nf_seven_seg_disp disp(s,seg); 
endmodule 
		   
		   