// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 decode button press module

module lab3_buttonpress(input logic clk, reset,
                        input logic [3:0] cols, rows,
                        output logic keypressed,
                    output logic[3:0] num);

	logic [4:0] en_numpressed;
	//logic [3:0] real_rows;
	//logic [7:0] into_comb;
	//logic [6:0] count;
	

    always_comb begin
       //en_numpressed = 5'b00000;
	   //real_rows = {rows[1], rows[0], rows[3], rows[2]};
	   case({cols, rows}) 
		   8'b0001_0001: en_numpressed = 5'b11010;
		   8'b0010_0001: en_numpressed = 5'b10000;
		   8'b0100_0001: en_numpressed = 5'b11011;
		   8'b1000_0001: en_numpressed = 5'b11111;
		   8'b0001_0010: en_numpressed = 5'b10111;
		   8'b0010_0010: en_numpressed = 5'b11000;
		   8'b0100_0010: en_numpressed = 5'b11001;
		   8'b1000_0010: en_numpressed = 5'b11110;
		   8'b0001_0100: en_numpressed = 5'b10100;
		   8'b0010_0100: en_numpressed = 5'b10101;
		   8'b0100_0100: en_numpressed = 5'b10110;
		   8'b1000_0100: en_numpressed = 5'b11101;
		   8'b0001_1000: en_numpressed = 5'b10001;
		   8'b0010_1000: en_numpressed = 5'b10010;
		   8'b0100_1000: en_numpressed = 5'b10011;
		   8'b1000_1000: en_numpressed = 5'b11100;
           default: en_numpressed = 5'b00000; //no key pressed
		    //8'b0000_xxxx
		  // default: en_numpressed = {1'b0, lastnum}; //hold last number when multiple keys pressed
		endcase
        keypressed = en_numpressed[4];
        num = en_numpressed[3:0];
		end
endmodule

