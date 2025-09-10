// Noah Fotenos
// nfotenos@g.hmc.edu
//8/28/2025
//E155 lab 2 top level testbench 

`timescale 10ps/1ps

`define test(anode1, value1, anode2, value2, seg, value3, led, value4) \
	assert(anode1 !== value1) begin \
		$display("ASSERTION FAILED for anode1 in %m: expected: %b, actual is : %b", value1, anode1); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(anode2 !== value2) begin \
		$display("ASSERTION FAILED for anode2 in %m: expected: %b, actual is : %b", value2, anode2); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(seg !== value3) begin \
		$display("ASSERTION FAILED for seg in %m: expected: %b, actual is : %b", value3, seg); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end \
	assert(led !== value4) begin \
		$display("ASSERTION FAILED for led in %m: expected: %b, actual is : %b", value1, led); \
			$finish; \
			end \
	else begin \
		$display("ASSERTION SUCCEDED"); \
	end 

module lab2_testbench();
	logic reset;
	logic [3:0] in1, in2;
	logic [6:0] seg;
	logic [4:0] led;
	logic anode1, anode2;
	lab2_nf DUT(reset,in1,in2,seg,led,anode1,anode2);
	
	initial begin // assertions
		//initialize inputs ocilator is 0 for a while so only in2 affects seg:
		in1 = 4'b0000; in2 = 4'b0000;
		reset =0; #22; reset =1; #10; //pulse reset
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b1000000, led, 5'b00000);
		in2 = 4'b0001; #10; 		
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b1111001, led, 5'b00001);
		in2 = 4'b0010; #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0100100, led, 5'b00010);
		in2 = 4'b0100;  #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0011001, led, 5'b00100);		
		in2 = 4'b1000;  #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0000000, led, 5'b01000);
		in2 = 4'b1111;  #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0001110, led, 5'b01111);
		in2 = 4'b1111; in1 = 4'b0001; #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0001110, led, 5'b10000);
		in2 = 4'b1001;  in1 = 4'b0110; #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b0010000, led, 5'b01111);
		in1 = 4'b1000;  in2 = 4'b0001; #10;
		`test(anode1, 1'b0, anode2, 1'b1, seg, 7'b1111001, led, 5'b01001);		
		#3125000000; // wait for counter to switch to check anode change
		in1 = 4'b0000; in2 = 4'b0000; #10
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b1000000, led, 5'b00000);
		in1 = 4'b0001; #10; 		
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b1111001, led, 5'b00001);
		in1 = 4'b0010; #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0100100, led, 5'b00010);
		in1 = 4'b0100;  #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0011001, led, 5'b00100);		
		in1 = 4'b1000;  #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0000000, led, 5'b01000);
		in1 = 4'b1111;  #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0001110, led, 5'b01111);
		in1 = 4'b1111; in2 = 4'b1111; #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0001110, led, 5'b11110);
		in1 = 4'b1001;  in2 = 4'b1001; #10;
		`test(anode1, 1'b1, anode2, 1'b0, seg, 7'b0010000, led, 5'b10010);	
		$finish;
	end
    endmodule
