module my_alu_xor(
`ifdef USE_POWER_PINS
	inout vccd1,    // User area 1 1.8V supply
	inout vssd1,    // User area 1 digital ground
`endif
input clk,
input [7:0] A0,B0,A1,B1,  // ALU 8-bit Inputs
input [1:0] ALU_Sel1,ALU_Sel2,// ALU Selection
output [7:0] ALU_Out1,ALU_Out2, // ALU 8-bit Output
output CarryOut1,CarryOut2, // Carry Out Flag
output [7:0] x,
output y
);

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
