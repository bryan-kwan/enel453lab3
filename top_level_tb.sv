
`timescale 1ns/1ps
module top_level_tb();
	logic clk=0;
	logic reset_n, button;
	logic [9:0] SW, LEDR;
	logic [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	int digit0, digit1, digit2, digit3;
	logic write_enable;
	logic [12:0] voltage, distance, avg_out;
	logic [5:0] DP, Blank;

	logic [7:0] switch_value;

	parameter CLOCK_PERIOD = 20;
	parameter delay = 6*CLOCK_PERIOD;
	parameter debouncer_stable_time = 5000000*CLOCK_PERIOD;
	// Instantiate UUTs
	//(input  logic       clk,
	//  input  logic       reset_n,
	//  input  logic [9:0] SW,
	//  output logic [9:0] LEDR,
	//  output logic [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

	top_level UUT(.clk(clk),.reset_n(reset_n), 
	.SW(SW),.LEDR(LEDR), .button(button),
	.HEX0(HEX0),.HEX1(HEX1),
	.HEX2(HEX2),.HEX3(HEX3),
	.HEX4(HEX4),.HEX5(HEX5));

	// Function to check correct seven segment value for a given number
	// Returns 1 if segment is correct, else returns 0
	function int segment_is_correct(int digit, logic[6:0] display);
		segment_is_correct=1;
		case(digit)
				0: assert(display[6:0]===~7'b0_11_11_11) else segment_is_correct=0;
				1: assert(display[6:0]===~7'b0_00_01_10) else segment_is_correct=0;
				2: assert(display[6:0]===~7'b1_01_10_11) else segment_is_correct=0;
				3: assert(display[6:0]===~7'b1_00_11_11) else segment_is_correct=0;
				4: assert(display[6:0]===~7'b1_10_01_10) else segment_is_correct=0;
				5: assert(display[6:0]===~7'b1_10_11_01) else segment_is_correct=0;
				6: assert(display[6:0]===~7'b1_11_11_01) else segment_is_correct=0;
				7: assert(display[6:0]===~7'b0_00_01_11) else segment_is_correct=0;
				8: assert(display[6:0]===~7'b1_11_11_11) else segment_is_correct=0;
				9: assert(display[6:0]===~7'b1_10_01_11) else segment_is_correct=0;
				10: assert(display[6:0]===~7'b1_11_01_11) else segment_is_correct=0;
				11: assert(display[6:0]===~7'b1_11_11_00) else segment_is_correct=0;
				12: assert(display[6:0]===~7'b0_11_10_01) else segment_is_correct=0;
				13: assert(display[6:0]===~7'b1_01_11_10) else segment_is_correct=0;
				14: assert(display[6:0]===~7'b1_11_10_01) else segment_is_correct=0;
				15: assert(display[6:0]===~7'b1_11_00_01) else segment_is_correct=0;
		endcase
	endfunction
	// Apply stimulus
	always #(CLOCK_PERIOD/2) clk = ~clk; // run clock forever with period CLOCK_PERIOD ns 
	
	assign write_enable = UUT.register_ins.write_enable; // Probes for viewing signals
	assign voltage = UUT.MUX_binary_output_ins.in2;
	assign distance = UUT.MUX_binary_output_ins.in1;
	assign avg_out = UUT.MUX_hexadecimal_output_ins.in2;
	assign DP=UUT.DP_in;
	assign Blank=UUT.Blank;
	
	initial begin 
		$display("---  Testbench started  ---");
		
		#(0.25*CLOCK_PERIOD); // Offset the stimulus by 0.25 Period

		// Reset tests
		SW[9:8]=2'b00; // Set to decimal mode
		reset_n = 1; #(delay);
		reset_n = 0;#(delay); // Reset is active low
		reset_n = 1; #(delay);
		
		SW[9:8]=2'b01; // Set to voltage mode
		reset_n = 1; #(delay);
		reset_n = 0; #(delay); // Reset is active low
		reset_n = 1; #(delay);
		
		SW[9:8]=2'b10; // Set to distance value mode
		reset_n = 1; #(delay);
		reset_n = 0; #(delay); // Reset is active low
		reset_n = 1; #(delay);
		
		SW[9:8]=2'b11; // Set to average mode
		reset_n = 1; #(delay);
		reset_n = 0; #(delay); // Reset is active low
		reset_n = 1; #(delay);
		
		// Display value tests
		button=0; #(delay);
		button=1; #(debouncer_stable_time); // Enable on

		SW[9:8]=2'b00; #(delay) // Set to hexadecimal mode
		assert(DP===6'b00_0000) else $error("Hexadecimal mode: Expected DP=6'b00_0000 (received %b)",DP);
		assert(Blank===6'b11_0000) else $error("Hexadecimal mode: Expected Blank=6'b11_0000 (received %b)",Blank);
		for (int i = 0; i < 256; i++) begin
			SW[7:0]=i; #5000;
			digit0 = i / 16 ** (1 - 1) % 16; // First digit of i in base 16
			digit1= i / 16 **(2 - 1) % 16; // Second digit
			digit2= i / 16 ** (3 - 1) % 16; // Third digit
			digit3= i / 16 ** (4 - 1) % 16; // Fourth digit
			if(segment_is_correct(digit0, HEX0)===0) $error("Hexadecimal mode failed for value %d in HEX0, Num_Hex0=%d",i, UUT.Num_Hex0);
			if(segment_is_correct(digit1, HEX1)===0) $error("Hexadecimal mode failed for value %d in HEX1, Num_Hex1=%d",i, UUT.Num_Hex1);
			if(segment_is_correct(digit2, HEX2)===0) $error("Hexadecimal mode failed for value %d in HEX2, Num_Hex2=%d",i, UUT.Num_Hex2);
		end
		$display("End of hexadecimal mode test");

		// Average mode tests
		SW[9:8]=2'b01; #(delay); // Set to average mode
		assert(DP===6'b00_0000) else $error("Average mode: Expected DP=6'b00_0000 (received %b)",DP);
		$display("End of average mode test");

		// Distance mode tests
		SW[9:8]=2'b10; #(delay); // Set to distance mode
		assert(DP===6'b00_0100) else $error("Distance mode: Expected DP=6'b00_0100 (received %b)",DP);	
		$display("End of distance mode test");
		
		// Voltage mode tests
		SW[9:8]=2'b11; #(delay); // Set to voltage mode
		assert(DP===6'b00_1000) else $error("Voltage mode: Expected DP=6'b00_1000 (received %b)",DP);
		assert(Blank===6'b11_0000) else $error("Voltage mode: Expected Blank=6'b11_0000 (received %b)",Blank);
		$display("End of voltage mode test");

		// Freeze button tests
		SW[9:8]=2'b00; #(delay);
		SW[7:0]='1;
		switch_value=SW[7:0];
		button=0; #(debouncer_stable_time); // Enable off
		SW[7:0]='0; #(delay);
		assert(reg_out===switch_value) else $error("Freeze button failed: Expected reg_out=%b (received %b)",switch_value,reg_out);

		$display("\n===  Testbench ended  ===");
		$stop; // this stops simulation, needed because clk runs forever
	end
	
endmodule