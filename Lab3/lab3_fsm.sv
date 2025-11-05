// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 decode button press module

module lab3_fsm(input logic clk, reset, keypressed,
                input logic [3:0] num, rows, cols,
                output logic en,
                output logic [3:0] num_out, 
				output logic [1:0] stateout);
	logic b1,b2;
	logic [3:0] saverow, savecol, temp;
    logic [5:0] waitcount;
    typedef enum logic [1:0] {IDLE, WAIT1, RELEASE, WAIT2} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk, negedge reset) begin
        if(reset == 0)begin
			current_state <= IDLE;
			//en = 0;
			//num_out = 4'b0000;
			end
        else begin
			current_state <= next_state;
			if (current_state == IDLE | current_state == RELEASE) begin
			waitcount <= 0;
			end
			if(current_state == WAIT1 | current_state == WAIT2) begin
			waitcount <= waitcount + 6'd1; 
			end
			else waitcount <= waitcount; 
			if(current_state == IDLE & keypressed) begin
				saverow <= rows; 
				savecol <= cols;
				num_out <= num;
			end
			if(current_state == RELEASE) begin
				stateout <=  {(saverow == rows),(savecol&cols)==4'b0000};
			end
			else stateout <= 0;
			
			end
    end
    // 2. Next-state logic
    always_comb begin
        next_state = current_state;  // default stay in same state
		en         = 0;        
		//stateout   = 2'b01;     // default output
        case (current_state)
            IDLE: begin  
					en = 0; //key released
					//stateout = 2'b01;
					if (keypressed) begin next_state = WAIT1;
                     //waitcount = 0;
                     en = 0; //key pressed
                    end
					else begin
						en = 0;
						next_state = current_state; 
						end
                end
            WAIT1: begin
					//stateout = 2'b00;
                    //waitcount = waitcount + 1; //wait to debounce
                    if (waitcount == 10) next_state = RELEASE; //wait ~60 miliseconds
					else begin
						next_state = current_state; 
						en = 0;
						end
              end
            RELEASE: begin  
					en = 1;
					//stateout = 2'b10;
					//& num_out !== num 
					
					if ((saverow == rows  & ((savecol&cols)==4'b0000))) begin next_state = WAIT2;
					//if (!((saverow == 4'b0001)  & ((cols)==4'b0000))) begin next_state = WAIT2;
						 //stateout = {(saverow == rows),(savecol&cols)==4'b0000};
                         //waitcount = 0;
                         en = 0; //key released
                        end
					else next_state = current_state; 
                end
            WAIT2: begin
					//stateout = 2'b11;
                    //waitcount = waitcount + 1;  //count to debounce
                    if (waitcount == 10) begin //wait ~60 miliseconds
                        next_state = IDLE; 
						en = 0;
                    end
					else next_state = current_state; 
                end
            default:  next_state = IDLE;
        endcase
    end
endmodule