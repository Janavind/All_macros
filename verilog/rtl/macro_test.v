`default_nettype none

`ifndef MPRJ_IO_PADS
	`define MPRJ_IO_PADS 38
`endif

module macro_test  (
 `ifdef USE_POWER_PINS
    /* inout vdda1,    // User area 1 3.3V supply
     inout vdda2,    // User area 2 3.3V supply
     inout vssa1,    // User area 1 analog ground
     inout vssa2,    // User area 2 analog ground
    */ inout vccd1,    // User area 1 1.8V supply
    // inout vccd2,    // User area 2 1.8v supply
     inout vssd1,    // User area 1 digital ground
    // inout vssd2,    // User area 2 digital ground
 `endif		

	// Wishbone Slave ports (WB MI A)
	/*	 input wb_clk_i,
		 input wb_rst_i,
		 input wbs_stb_i,
		 input wbs_cyc_i,
		 input wbs_we_i,
		 input [3:0] wbs_sel_i,
		 input [31:0] wbs_dat_i,
		 input [31:0] wbs_adr_i,
		 output wbs_ack_o,
		 output [31:0] wbs_dat_o,
	*/	
		// // Logic Analyzer Signals
		 input  [127:0] la_data_in,
		 output [127:0] la_data_out,
//		 input  [127:0] la_oenb,
	/*	
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
*/	
       		);
		//
		// /*--------------------------------------*/
		// /* User project is instantiated  here   */
		// /*--------------------------------------*/
	assign io_oeb[37:0]=0;
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
        wire [1:0] dum10 = io_in[37:0];   
	assign io_out [37:27] =0;
//        wire [127: 0] la2_data_in, la2_data_out, la2_oenb;
//        assign la2_data_in = la_data_in[127:0];
//        assign la2_data_out = la_data_out[127:0];
        assign la_oenb[127:0]=0;
 /*wire [7:0] ALU_Out11,ALU_Out21; // ALU 8-bit Output
 wire CarryOut11,CarryOut21; // Carry Out Flag
 wire [7:0] x;
 wire y;
 wire clk  = wb_clk_i;
 wire[7:0] A0 = io_in[7:0];
 wire[7:0] B0 = io_in[15:8];
 wire[7:0] A1 = io_in[23:16];
 wire[7:0] B1 = io_in[31:24]; 
 wire[1:0] ALU_Sel1 = io_in[33:32];
 wire[1:0] ALU_Sel2 = io_in[35:34];
 assign io_out[7:0] = ALU_Out1; 
 assign io_out[15:8] = ALU_Out2;
 assign io_out[16] = CarryOut1;
 assign io_out[17] = CarryOut2;
 assign io_out[25:18] = x;
 assign io_out[26] = y;
 
*/
 my_alu_xor my_alu_xor_test(
`ifdef USE_POWER_PINS
 .vccd1(vccd1),
 .vssd1(vssd1),
`endif
 .clk(wb_clk_i),
 .A0(la_data_in[7:0]),
 .B0(la_data_in[15:8]),
 .A1(la_data_in[23:16]),
 .B1(la_data_in[31:24]),
 .ALU_Sel1(la_data_in[33:32]),
 .ALU_Sel2(la_data_in[35:34]),
 .ALU_Out1(la_data_out[7:0]),
 .ALU_Out2(la_data_out[15:8]),
 .CarryOut1(la_data_out[16]),
 .CarryOut2(la_data_out[17]),
 .x(la_data_out[25:18]),
 .y(la_data_out[26])
 );
 

 endmodule	// user_project_wrapper

 `default_nettype wire
