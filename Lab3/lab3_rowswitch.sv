// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 decode button press module
 
module lab3_rowswitch(input logic clk, reset, en,
                    output logic [3:0] rows);
					
		logic [3:0] rowtemp; 
		
        always_ff @(posedge (clk), negedge reset) begin
            if(reset == 0) begin
				rowtemp <= 4'b0001; 
				end
            else begin
					rowtemp <= {rowtemp[2:0], rowtemp[3]}; //rotate left
            end
        end
		assign rows = rowtemp; 
endmodule