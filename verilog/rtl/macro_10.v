`default_nettype none

`ifdef FORMAL
    `define MPRJ_IO_PADS 38    
`endif

module macro_10  (
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
		output [2:0] user_irq,

		input wire active
		 );
		//
		// /*--------------------------------------*/
		// /* User project is instantiated  here   */
		// /*--------------------------------------*/
		//

  wire [`MPRJ_IO_PADS-1:0]    buf_io_out;
  wire [1:0] ALU_Sel1, ALU_Sel2;
  wire [7:0] ALU_Out1,ALU_Out2; // ALU 8-bit Output
  wire CarryOut1,CarryOut2; // Carry Out Flag
  wire [7:0] x;
  wire y;
  wire clk;
 
//Using tri-state buffer GPIO output ports for multiple macros, thus
//essentially activating the outputs of this macro only.

 `ifdef FORMAL
	 assign io_out       = active ? buf_io_out       : {`MPRJ_IO_PADS{1'b0}}; //outputs are set to '0' when active is low
	 `include "properties.v"
 `else
	 assign io_out       = active ? buf_io_out       : {`MPRJ_IO_PADS{1'bz}}; //outputs are set to 'z' when active is high
 `endif

 my_alu_xor u_my_alu_xor(
`ifdef USE_POWER_PINS
 .vccd1(vccd1),
 .vssd1(vssd1),
`endif
 .clk(wb_clk_i),
 .A0(io_in[7:0]),
 .B0(io_in[15:8]),
 .A1(io_in[23:16]),
 .B1(io_in[31:24]),
 .ALU_Sel1(io_in[33:32]),
 .ALU_Sel2(io_in[35:34]),
 .ALU_Out1(buf_io_out[15:8]),
 .ALU_Out2(buf_io_out[23:16]),
 .CarryOut1(buf_io_out[24]),
 .CarryOut2(buf_io_out[25]),
 .x(buf_io_out[33:26]),
 .y(buf_io_out[34])
 );

 endmodule	// user_project_wrapper

 `default_nettype wire
