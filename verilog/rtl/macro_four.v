`default_nettype none

`ifdef FORMAL
    `define MPRJ_IO_PADS 38    
`endif

module macro_four  (
 `ifdef USE_POWER_PINS
     inout vdda1,    // User area 1 3.3V supply
     inout vdda2,    // User area 2 3.3V supply
     inout vssa1,    // User area 1 analog ground
     inout vssa2,    // User area 2 analog ground
     inout vccd1,    // User area 1 1.8V supply
     inout vccd2,    // User area 2 1.8v supply
     inout vssd1,    // User area 1 digital ground
     inout vssd2,    // User area 2 digital ground
 `endif		

	// Wishbone Slave ports (WB MI A)
		 input wb_clk_i,
		 input wb_rst_i,
		 input wbs_stb_i,
		 input wbs_cyc_i,
		 input wbs_we_i,
		 input [3:0] wbs_sel_i,
		 input [31:0] wbs_dat_i,
		 input [31:0] wbs_adr_i,
		 output wbs_ack_o,
		 output [31:0] wbs_dat_o,
		
		// // Logic Analyzer Signals
		 input  [127:0] la_data_in,
		 output [127:0] la_data_out,
		 input  [127:0] la_oenb,
		
		// // IOs
		 input  [`MPRJ_IO_PADS-1:0] io_in,
		 output [`MPRJ_IO_PADS-1:0] io_out,
		 output [`MPRJ_IO_PADS-1:0] io_oeb,
		
		// // Analog (direct connection to GPIO pad---use with
		// caution)
		// // Note that analog I/O is not available on the
		// 7 lowest-numbered
		// // GPIO pads, and so the analog_io indexing is offset from
		// the
		// // GPIO indexing by 7 (also upper 2 GPIOs do not have
		// analog_io).
		 inout [`MPRJ_IO_PADS-10:0] analog_io,
		
		// // Independent clock (on independent integer divider)
		 input   user_clock2,
		
		// // User maskable interrupt signals
		output [2:0] user_irq

//		input wire active
		 );
		//
		// /*--------------------------------------*/
		// /* User project is instantiated  here   */
		// /*--------------------------------------*/
		//
	reg [3:0] A0, B0, A1, B1;
	reg [1:0] ALU_Sel1, ALU_Sel2;
	reg [1:0] active;
	wire [3:0] ALU_Out1,ALU_Out2; // ALU 8-bit Output
	wire CarryOut1,CarryOut2; // Carry Out Flag
	wire [3:0] x;
	wire y;
	wire clk;
	
	
	wire [`MPRJ_IO_PADS-1:0]    buf_io_out;
	wire [`MPRJ_IO_PADS-1:0]    buf_io_oeb;
	//wire [37:0]io_oeb;
	//assign io_oeb[37:0]=1;
	//assign active = 2'b00;
//      assign io_out[37:0]=buf_io_out[37:0];
	assign buf_io_oeb = {`MPRJ_IO_PADS{1'b0}}; //enabling the outputs permanently
/*	assign io_oeb[37:0]=0;
        wire [37:0] dum2;
	assign dum2 = analog_io [37:0];
	wire clk1= user_clock2;
        assign user_irq = 3'b 000;
	wire dum3= wb_rst_i;
        wire dum4= wbs_stb_i;
	wire dum5= wbs_cyc_i;
	wire dum6= wbs_we_i;
	wire [3:0] dum7= wbs_sel_i [3:0];
	wire [31:0 ] dum8  = wbs_dat_i [31:0];
        wire [31:0] dum9 = wbs_adr_i [31:0];
        assign wbs_ack_o=0;
	assign wbs_dat_o [31:0]=0;
        wire [1:0] dum10 = io_in[37:36];   
	assign io_out [37:27] =0;
        wire [127: 0] la2_data_in, la2_data_out, la2_oenb;
        assign la2_data_in = la_data_in[127:0];
        assign la2_data_out = la_data_out[127:0];
        assign la2_oenb = la_oenb[127:0];

	

 wire [8:0] A0, B0, A1, B1;
 wire [1:0] ALU_Sel1, ALU_Sel2;
 wire [8:0] ALU_Out1,ALU_Out2; // ALU 8-bit Output
 wire CarryOut1,CarryOut2; // Carry Out Flag
 wire [8:0] x;
 wire y;
 wire clk;
 wire[7:0] A0 = io_in[7:0];
 wire[7:0] B0 = io_in[15:8];
 wire[7:0] A1 = io_in[23:16];
 wire[7:0] B1 = io_in[31:24]; 
 wire[1:0] ALU_Sel1 = io_in[33:32];
 wire[1:0] ALU_Sel2 = io_in[35:34];
 */

 `ifdef FORMAL
	 begin

//	 assign io_oeb       = (active==2'b00) ? buf_io_oeb       : {`MPRJ_IO_PADS{1'bz}};
	 assign io_out       = (active==2'b00) ? buf_io_out       : {`MPRJ_IO_PADS{1'bz}};
	 `include "properties.v"
 end
//	 $display("outputs and active is",io_out,active);
 `else
	 assign io_out       = (active==2'b00) ? buf_io_out       : {`MPRJ_IO_PADS{1'bz}};

	 //$display("outputs and active is",io_out,active);
 `endif

 /*assign io_out[7:0] = ALU_Out1; 
 assign io_out[15:8] = ALU_Out2;
 assign io_out[16] = CarryOut1;
 assign io_out[17] = CarryOut2;
 assign io_out[25:18] = x;
 assign io_out[26] = y;
*/
//#1000;
//$display("Outputs",io_out);

 alu_xor_4 u_alu_xor_4(
`ifdef USE_POWER_PINS
 .vccd1(vccd1),
 .vssd1(vssd1),
`endif
	.clk(wb_clk_i),
	.A0(io_in[18:15]),
	.B0(io_in[22:19]),
	.A1(io_in[26:23]),
	.B1(io_in[30:27]),
	.ALU_Sel1(io_in[32:31]),
	.ALU_Sel2(io_in[34:33]),
	.active(io_in[36:35]),
	.ALU_Out1(buf_io_out[3:0]),
	.ALU_Out2(buf_io_out[7:4]),
	.CarryOut1(buf_io_out[8]),
	.CarryOut2(buf_io_out[9]),
	.x(buf_io_out[13:10]),
	.y(buf_io_out[14])
);
 endmodule	// user_project_wrapper

 `default_nettype wire
