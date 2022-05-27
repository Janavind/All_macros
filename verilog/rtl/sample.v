module sample(

	`ifdef USE_POWER_PINS
		 inout vccd1,    // User area 1 1.8V supply
		 inout vssd1,    // User area 2 digital ground
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
		//
		// // Logic Analyzer Signals
		 input  [127:0] la_data_in,
		 output [127:0] la_data_out,
		 input  [127:0] la_oenb,
		//
		// // IOs
	         input  [`MPRJ_IO_PADS-1:0] io_in,
		 output [`MPRJ_IO_PADS-1:0] io_out,
		 output [`MPRJ_IO_PADS-1:0] io_oeb,
		//
		 inout [`MPRJ_IO_PADS-10:0] analog_io,
		//
		// // Independent clock (on independent integer divider)
		 input   user_clock2,
		//
		//
		// // User maskable interrupt signals
		 output [2:0] user_irq,
		 
		//
input [7:0] A0,B0,A1,B1,  // ALU 8-bit Inputs
input [1:0] ALU_Sel1,ALU_Sel2,// ALU Selection
output [7:0] ALU_Out1,ALU_Out2, // ALU 8-bit Output
output CarryOut1,CarryOut2, // Carry Out Flag
output [7:0] x,
output y,
input clk
);

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
wire [1:0] dum10 = io_in[37:36];
assign io_out [37:27] =0;
wire [127: 0] la2_data_in, la2_data_out, la2_oenb;
assign la2_data_in = la_data_in[127:0];
assign la2_data_out = la_data_out[127:0];
assign la2_oenb = la_oenb[127:0];
wire [7:0] ALU_Out1,ALU_Out2; // ALU 8-bit Output
wire CarryOut1,CarryOut2; // Carry Out Flag
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

my_alu alu_1(
.A (A0),
.B (B0),
.ALU_Sel (ALU_Sel1),
.ALU_Out (ALU_Out1),
.CarryOut (CarryOut1)
);

my_alu alu_2(
.A (A1),
.B (B1),
.ALU_Sel (ALU_Sel2),
.ALU_Out (ALU_Out2),
.CarryOut (CarryOut2)
);


assign x[7:0] = ALU_Out1[7:0] ^ ALU_Out2[7:0];
assign y = CarryOut1 ^ CarryOut2;
always @(*)
begin
if (x!=0)
$display ("Faulty ALU");
else
$display ("ALU is right");
if (y!=0)
$display ("Faulty Carry");
else
$display ("Carry is right");
end


endmodule

module my_alu(
input [7:0] A,B,  // ALU 8-bit Inputs                 
input [1:0] ALU_Sel,// ALU Selection
output [7:0] ALU_Out, // ALU 8-bit Output
output CarryOut // Carry Out Flag
);
reg [8:0] ALU_Result;

assign ALU_Out = ALU_Result[7:0]; // ALU out
assign CarryOut = ALU_Result[8]; 

always @(*)
begin
case(ALU_Sel)
2'b00: // Addition
ALU_Result = A + B ; 
2'b01: // Subtraction
ALU_Result = A - B ;
2'b10: // and
ALU_Result = A & B;
2'b11: // or
ALU_Result = A | B;

default: ALU_Result = A + B ; 
endcase
end

endmodule
