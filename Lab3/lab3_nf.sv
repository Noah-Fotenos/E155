// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 top module

module lab3_nf(input logic reset,
                input logic [3:0] col,
                output logic [3:0] invert_row,
                output logic [6:0] seg,
                output logic [1:0] anode,
				output logic en,
				output [1:0] state);

   	// Internal high-speed oscillator
	logic[27:0] counter;    // Counter
	//logic en;//, keypressed; 
    logic [3:0] real_rows, num_out, num, num_final, rows; //num_out is fsm output, num is buttonpress output
   	logic int_osc; 
	logic clk; 
	
	assign invert_row = ~rows;
	
	HSOSC #(.CLKHF_DIV(2'b00)) 
    hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	lab2_counter count_module(int_osc, reset, counter);
	//assign clk = int_osc;
    assign clk = counter[20]; //clk at 160Hz (22)

    //Synchronizer for button press
    logic [3:0] sync_col_int, sync_col_out, sync_row_int, sync_row_out; 
    always_ff @(posedge clk, negedge reset) begin
        if(reset == 0) begin 
            sync_col_int <= 0;
            sync_col_out <= 0; 
			sync_row_int <= 0;
            sync_row_out <= 0; 
        end
        else begin 
			sync_col_int <= col;
            sync_col_out <= sync_col_int; 
			sync_row_int <= rows;
            sync_row_out <= sync_row_int; end
    end


    lab3_rowswitch row_module(clk, reset, rows); //cycle rows

    lab3_buttonpress press_module(clk, reset, sync_col_out, sync_row_out, keypressed, num); //decode input 

    lab3_fsm fsm_module(clk, reset, keypressed, num, sync_row_out, sync_col_out, en, num_out, state); //fsm to hold state
	
    lab3_holdstate switch_module(clk, reset, en, num_out, num_final, anode); //hold 7seg state

    nf_seven_seg_disp seg1_decoder(num_final, seg); //7seg decoder

endmodule
