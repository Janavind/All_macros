



`default_nettype none
/*
*  *-------------------------------------------------------------
*  *
*  * user_project_wrapper also incorporating an analog block
*  *
*  * This wrapper enumerates all of the pins available to
*    the
*  * user for the user project.
*  *
*  * An example user project is provided in
*    this wrapper.  The
*  * example should be removed and replaced
*    with the actual
*  * user project.
*  *
*  *-------------------------------------------------------------
*  *              */
`ifndef MPRJ_IO_PADS
	`define MPRJ_IO_PADS 38
`endif

module user_project_wrapper (
	`ifdef USE_POWER_PINS
		inout vdda1,	// User area 1 3.3V supply
		inout vdda2,	// User area 2 3.3V supply
		inout vssa1,	// User area 1 analog ground
		inout vssa2,	// User area 2 analog ground
		inout vccd1,	// User area 1 1.8V supply
		inout vccd2,	// User area 2 1.8v supply
		inout vssd1,	// User area 1 digital ground
		inout vssd2,	// User area 2 digital ground
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

// Logic Analyzer Signals
input  [127:0] la_data_in,
output [127:0] la_data_out,
input  [127:0] la_oenb,

// IOs
input  [`MPRJ_IO_PADS-1:0] io_in,
output [`MPRJ_IO_PADS-1:0] io_out,
output [`MPRJ_IO_PADS-1:0] io_oeb,

// Analog (direct connection to GPIO pad---use with caution)
// Note that analog I/O is not available on the 7 lowest-numbered
// GPIO pads, and so the analog_io indexing is offset from the
// GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
 inout [`MPRJ_IO_PADS-10:0] analog_io,

// Independent clock (on independent integer divider)
 input   user_clock2,

// User maskable interrupt signals
 output [2:0] user_irq
 );

 /*--------------------------------------*/
 /* User project is instantiated  here   */
 /*--------------------------------------*/


	wire [31: 0] active;
	assign active = la_data_in[31:0];

	// split remaining 96 logic analizer wires into 3 chunks
	 wire [31: 0] la1_data_in, la1_data_out, la1_oenb;
	 assign la1_data_in = la_data_in[63:32];
	 assign la1_data_out = la_data_out[63:32];
	 assign la1_oenb = la_oenb[63:32];
	
	 wire [31: 0] la2_data_in, la2_data_out, la2_oenb;
	 assign la2_data_in = la_data_in[95:64];
	 assign la2_data_out = la_data_out[95:64];
	 assign la2_oenb = la_oenb[95:64];
	
	 wire [31: 0] la3_data_in, la3_data_out, la3_oenb;
	 assign la3_data_in = la_data_in[127:96];
	 assign la3_data_out = la_data_out[127:96];
	 assign la3_oenb = la_oenb[127:96];

/*assign io_oeb[37:0]=0;
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
wire [127: 0] la2_data_in, la2_data_out, la2_oenb;
assign la2_data_in = la_data_in[127:0];
assign la2_data_out = la_data_out[127:0];
assign la_oenb[127:0]=0;
*/

/*sample u_sample (

	`ifdef USE_POWER_PINS
		.vccd1(vccd1),  
			.vssd1(vssd1),  
		`endif
	.wb_rst_i(wb_rst_i),
	.wbs_stb_i(wbs_stb_i),
.wbs_cyc_i(wbs_cyc_i),
.wbs_we_i(wbs_we_i),
.wbs_sel_i(wbs_sel_i),
.wbs_dat_i(wbs_dat_i),
.wbs_adr_i(wbs_adr_i),
.wbs_ack_o(wbs_ack_o),
.wbs_dat_o(wbs_dat_o),
.la_data_in(la_data_in),
.la_data_out(la_data_out),
.la_oenb(la_oenb),
.io_in(io_in),
.io_out(io_out),
.io_oeb(io_oeb),
.user_irq(user_irq),
.user_clock2(user_clock2),
.analog_io(analog_io)
	);

/*
*/
/*sample u_sample (
	 
	`ifdef USE_POWER_PINS
		.vccd1(vccd1),	// User area 1 1.8V supply
		.vssd1(vssd1),	// User area 1 digital ground
	 `endif
	 //        .clk(wb_clk_i),
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
	 //.la_data_in(la_data_in),
         //.la_data_out(la_data_out),
 );
*/
 /*
wire [5:0] active;
assign active = la_data_in[5:0];
*/
//wire [37:0] io_oeb;
//assign io_oeb =1;
 macro_la u_macro_la (

	 `ifdef USE_POWER_PINS
		 .vdda1(vdda1),  // User area 1 3.3V supply
			 .vdda2(vdda2),  // User area 2 3.3V supply
			 .vssa1(vssa1),  // User area 1 analog ground
			 .vssa2(vssa2),  // User area 2 analog ground
			 .vccd1(vccd1),  // User area 1 1.8V supply
			 .vccd2(vccd2),  // User area 2 1.8v supply
			 .vssd1(vssd1),  // User area 1 digital ground
  			 .vssd2(vssd2),  // User area 2 digital ground
		 `endif
 			 .wb_rst_i(wb_rst_i),
			 .wbs_stb_i(wbs_stb_i),
			 .wbs_cyc_i(wbs_cyc_i),
			 .wbs_we_i(wbs_we_i),
			 .wbs_sel_i(wbs_sel_i),
			 .wbs_dat_i(wbs_dat_i),
			 .wbs_adr_i(wbs_adr_i),
			 .wbs_ack_o(wbs_ack_o),
			 .wbs_dat_o(wbs_dat_o),
			 .la_data_in(la_data_in),
			 .la_data_out(la_data_out),
			 .la_oenb(la_oenb),
			 .active(active[1]),
			 .io_in(io_in[37:0]),
			 .io_out(io_out[37:0]),
			 .io_oeb(io_oeb[37:0]),
			 .user_irq(user_irq),
			 .user_clock2(user_clock2),
			 .analog_io(analog_io)
			 
		 );
/*
macro_10 u_macro_10 (

`ifdef USE_POWER_PINS
//.vdda1(vdda1),  // User area 1 3.3V supply
//.vdda2(vdda2),  // User area 2 3.3V supply
//.vssa1(vssa1),  // User area 1 analog ground
//.vssa2(vssa2),  // User area 2 analog ground
.vccd1(vccd1),  // User area 1 1.8V supply
//.vccd2(vccd2),  // User area 2 1.8v supply
.vssd1(vssd1),  // User area 1 digital ground
//.vssd2(vssd2),  // User area 2 digital ground
`endif
 .wb_rst_i(wb_rst_i),
	.wbs_stb_i(wbs_stb_i),
	.wbs_cyc_i(wbs_cyc_i),
	.wbs_we_i(wbs_we_i),
	.wbs_sel_i(wbs_sel_i),
	.wbs_dat_i(wbs_dat_i),
	.wbs_adr_i(wbs_adr_i),
	.wbs_ack_o(wbs_ack_o),
	.wbs_dat_o(wbs_dat_o),
	.la_data_in(la_data_in),
	.la_data_out(la_data_out),
	.la_oenb(la_oenb),

	.io_in(io_in),
	.io_out(io_out),
	.io_oeb(io_oeb),
	.user_irq(user_irq),
	.user_clock2(user_clock2),
	.analog_io(analog_io)
	
);
*/
 endmodule	// user_project_wrapper

 `default_nettype wire
