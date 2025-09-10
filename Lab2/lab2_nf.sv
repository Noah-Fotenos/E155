// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 2 top module for 2 7segment display of 2 4bit input switches

module lab2_nf(input reset,
				input logic [3:0] in1, in2,
                output logic [6:0] seg,
                output logic [4:0] led,
                output logic anode1, anode2);

   	// Internal high-speed oscillator
	logic[23:0] counter;    // Counter
   	logic int_osc;
	
	HSOSC #(.CLKHF_DIV(2'b00)) 
    hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	lab2_counter count_module(int_osc, reset, counter);
	
	// alternate led power suply
    assign anode1 = counter[23];
    assign anode2 = ~counter[23];

    // 7-segment decoder instantiation
	logic [3:0] in;
	always_comb begin
		if(counter[23]) in = in1;  //alternate signal decoding
		else in = in2; 
		end	
    nf_seven_seg_disp seg1_decoder(in, seg);

    // Assign LED output
    assign led = in1 + in2;

endmodule