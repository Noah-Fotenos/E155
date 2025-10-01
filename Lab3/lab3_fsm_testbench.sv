// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 3 testbench for lab3 fsm module

`timescale 10ps/1ps

`define test(en, value1, num_out, value2) \
	assert(en !== value1) begin \
		$display("ASSERTION FAILED for keypressed in %m: expected: %b, actual is : %b", value1, en); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(num_out !== value2) begin \
		$display("ASSERTION FAILED for num in %m: expected: %b, actual is : %b", value2, num_out); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end 

module lab3_fsm_testbench();
    logic clk, reset, keypressed, en;
    logic [3:0] num, num_out;
	logic [1:0] stateout;

    //define clk
	always begin
		clk =1; #5; clk =0; #5;
	end
    lab3_fsm DUT(clk, reset, keypressed, num, en, num_out, stateout);
    initial begin
        reset = 0; num = 4'b0000; keypressed = 1'b0; #10;
        `test(en, 1'b0, num_out, 4'bxxxx); //TEST1  
        //TEST2
        reset = 1; num = 4'b1010; keypressed = 1'b1; #10;
        `test(en, 1'b1, num_out, 4'b1010); 
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; //wait
        `test(en, 1'b1, num_out, 4'b1010);
        reset = 1; num = 4'b1010; keypressed = 1'b0; #10;
        `test(en, 1'b0, num_out, 4'b1010); 
         #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; //wait
        `test(en, 1'b0, num_out, 4'b1010);
         //TEST2
        reset = 1; num = 4'b0111; keypressed = 1'b1; #10;
        `test(en, 1'b1, num_out, 4'b0111);
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; //wait
        `test(en, 1'b1, num_out, 4'b0111);
        reset = 1; num = 4'b0000; keypressed = 1'b0; #10;
        `test(en, 1'b0, num_out, 4'b0111); 
         #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; //wait
        `test(en, 1'b0, num_out, 4'b0111);
        //TEST3. check debounce works
        reset = 1; num = 4'b1111; keypressed = 1'b1; #10;
        `test(en, 1'b1, num_out, 4'b1111);
        #10; 
        `test(en, 1'b1, num_out, 4'b1111);
        reset = 1; num = 4'b1111; keypressed = 1'b0; #10;
        `test(en, 1'b1, num_out, 4'b1111); 
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10;
        `test(en, 1'b0, num_out, 4'b1111);
        #10; #10; #10;
        `test(en, 1'b0, num_out, 4'b1111);
        reset = 1; num = 4'b0000; keypressed = 1'b1; #10;
        `test(en, 1'b0, num_out, 4'b1111);
        reset = 1; num = 4'b0000; keypressed = 1'b0; #10;
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10;
        `test(en, 1'b0, num_out, 4'b1111);
        //TEST4 Check new key during dbounce (two down one release)
        reset = 1; num = 4'b1011; keypressed = 1'b1; #10;
        `test(en, 1'b1, num_out, 4'b1011);
        #10; 
        `test(en, 1'b1, num_out, 4'b1011);
        reset = 1; num = 4'b1011; keypressed = 1'b0; #10; 
        `test(en, 1'b1, num_out, 4'b1011);
        reset = 1; num = 4'b1011; keypressed = 1'b1; #10; 
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10;
        `test(en, 1'b1, num_out, 4'b1011);
        reset = 1; num = 4'b1101; keypressed = 1'b1; #10;
        `test(en, 1'b0, num_out, 4'b1011);
        #10; #10; #10; #10; #10; #10; #10; #10; #10; #10; #10;
        `test(en, 1'b1, num_out, 4'b1101);
        $finish;


    end

endmodule