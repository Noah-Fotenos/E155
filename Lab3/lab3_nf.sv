// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 top module

module lab3_nf(input logic reset,
                input logic [3:0] col,
                output logic [3:0] rows,
                output logic [6:0] seg,
                output logic [1:0] anode,
				output logic en,
				output [1:0] state);

   	// Internal high-speed oscillator
	logic[27:0] counter;    // Counter
    logic [6:0] num_final;
	logic en;//, keypressed; 
    logic [3:0] num_out, num; //num_out is fsm output, num is buttonpress output
   	logic int_osc; 
   
	
	HSOSC #(.CLKHF_DIV(2'b00)) 
    hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	lab2_counter count_module(int_osc, reset, counter);
	//assign clk = int_osc;
    assign clk = counter[22]; //clk at 160Hz

    //Synchronizer for button press
    logic [3:0] sync_int, sync_out; 
    always_ff @(posedge clk, negedge reset) begin
        if(reset == 0) begin 
            sync_int <= 0;
            sync_out <= 0; 
        end
        else begin sync_int <= col;
            sync_out <= sync_int; end
    end

    lab3_rowswitch row_module(clk, reset, en, rows); //cycle rows

    lab3_buttonpress press_module(clk, reset, sync_out, rows, {num_out}, keypressed, num); //decode input 

    lab3_fsm fsm_module(clk, reset, keypressed, num, rows, sync_out, en, num_out, state); //fsm to hold state
	

    lab3_holdstate switch_module(clk, reset, en, num_out, num_final, anode); //hold 7seg state

    nf_seven_seg_disp seg1_decoder(num_final, seg); //7seg decoder

endmodule
