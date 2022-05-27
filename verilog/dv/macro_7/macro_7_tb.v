// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
	//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

module macro_7_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;

	reg clk;
	reg[7:0] A0;
	reg[7:0] B0;
	reg[7:0] A1;
	reg[7:0] B1;
	reg[1:0] ALU_Sel1;
	reg[1:0] ALU_Sel2;
	wire [26:0] mprj_io_out;
	wire [37:0] mprj_io_in;
	reg enable;

assign mprj_io_out = mprj_io[34:8];
assign mprj_io_in[37:0] = {B1,A1,B0,A0,ALU_Sel2,ALU_Sel1,clk};
assign mprj_io[37:0] = mprj_io_in[37:0];
assign mprj_io[37:0] = (enable==1) ? mprj_io_in[37:0] : 37'bz;
//assign mprj_io[37:0] = (enable) ? mprj_io_in[37:0] : 37'bz;
//assign mprj_io[37:0] = (enable==1) ? mprj_io_in[26:0] : 37'bz;
//assign mprj_io[3]=1;
//assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;

/*
assign mprj_io_in[13:6]<=A0;
assign mprj_io_in[21:14]<=B0;
assign mprj_io_in[29:22]<=A1;
assign mprj_io_in[37:30]<=B1;
assign mprj_io_in[1:0]<=ALU_Sel1;
assign mprj_io_in[5:4]<=ALU_Sel2;
assign mprj_io_in[2]<=clk;

//assign mprj_io_in[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;

wire [7:0] ALU_Out1;
assign ALU_Out1= mprj_io_out[7:0];
wire [7:0] ALU_Out2;
assign ALU_Out2= mprj_io_out[15:8]; // ALU 8-bit Output
wire CarryOut1;
assign CarryOut1= mprj_io_out[16];
wire CarryOut2;
assign CarryOut2= mprj_io_out[17]; // Carry Out Flag
wire [7:0] x;
assign x= mprj_io_out[25:18];
wire y;
assign y= mprj_io_out[26]; 
*/
	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock=0;
	end

	initial begin
		$dumpfile("macro_7.vcd");
		$dumpvars(0, macro_7_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Timeout, Test Mega-Project IO Ports (GL) Failed");
		`else
			$display ("Timeout, Test Mega-Project IO Ports (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

//assign mprj_io[37:0] = (enable==1) ? mprj_io_in[37:0] : 37'bz;
//assign mprj_io[27:0] = (enable==0) ? mprj_io_out[27:0] : 27'bz;

initial begin

enable=0;
 //clk = 1'b1;
 A0<=8'b10000001;
 B0<=8'b10000001;
 A1<=8'b00000000;
 B1<=8'b00000000;
 ALU_Sel1<=2'b00;
 ALU_Sel2<=2'b00;
 #1000
enable=1;
wait (mprj_io_out==27'b100000010010000000000000010);


/* ALU_Out1<=8'b00000010;
 ALU_Out2<=8'b00000010;
 CarryOut1<=1'b1;
 CarryOut2<=1'b0;
  */
/*
if(ALU_Out1 != ALU_Out2)
	$display("Add - ALU1 != ALU2");
else
	$display("Add - ALU1 = ALU2");
#10;
if(CarryOut1 !=CarryOut2)
	$display("Add - Carry1 != Carry2");
else
	$display("Add - Carry1 = Carry2");
*/
$display("%c[1;25m",27);
	`ifdef GL
	    	$display("Test 1 Mega-Project IO (GL) Passed");
		`else
		    $display("Test 1 Mega-Project IO (RTL) Passed");
		`endif
		$display("%c[1;25m",27);
	    $finish;

end
	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#300000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

/*
	always @(mprj_io) begin
		
		#1 $display("MPRJ-IO state = %b ", mprj_io[37:0]);
	end
*/

//always @(mprj_io) begin
//	#1 $display("MPRJ-IO state = %b ", mprj_io[7:0]);
//end

// Observe changes in mprj_io_out (27 bit)
//initial begin 
//	enable = 0;
always @(mprj_io) begin
	 
 #1000 $display("MPRJ-IO-IN = %b ", mprj_io_in[37:0]);
 end 
//
// // Observe changes in mprj_io_in (37 bit)
 //always @(mprj_io_out[26:0]) begin
 
//	 enable <= 1'b1;
	 always @(mprj_io) begin
#1000 $display("MPRJ-IO-OUT = %b ", mprj_io_out[26:0]);
 
 end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("macro_7.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
