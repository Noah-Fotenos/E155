// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 decode button press module

module lab3_fsm(input logic clk, reset, keypressed,
                input logic [3:0] num, rows, cols,
                output logic en,
                output logic [3:0] num_out, 
				output logic [1:0] stateout);
				
	logic [3:0] saverow, savecol;
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
			if (next_state == WAIT1 | next_state == WAIT2) begin
			waitcount <= 0;
			end
			if(current_state == WAIT1 | current_state == WAIT2) begin
			waitcount <= waitcount +1; 
			end
			
			end
    end
    // 2. Next-state logic
    always_comb begin
        next_state = current_state;  // default stay in same state
        case (current_state)
            IDLE: begin  
					stateout = 2'b01;
					if (keypressed) begin next_state = WAIT1;
					 saverow = rows;
					 savecol = cols;
                     num_out = num; 
                     //waitcount = 0;
                     en = 1; //key pressed
                    end
					else en = 0;
                end
            WAIT1: begin
					stateout = 2'b00;
                    //waitcount = waitcount + 1; //wait to debounce
                    if (waitcount == 10) next_state = RELEASE; //wait ~60 miliseconds
              end
            RELEASE: begin  
					stateout = 2'b10;
					if ((saverow == rows & num_out !== num & savecol !== cols)) begin next_state = WAIT2;
                         //waitcount = 0;
                         en = 0; //key released
                        end
                end
            WAIT2: begin
					stateout = 2'b11;
                    //waitcount = waitcount + 1;  //count to debounce
                    if (waitcount == 10) begin //wait ~60 miliseconds
                        next_state = IDLE; 
                        //assign en = 0; //key released
                    end
                end
            default:  next_state = IDLE;
        endcase
    end
endmodule