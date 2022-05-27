module my_alu_xor_tb;
		   reg clk;
           reg [7:0] A0,B0,A1,B1;  // ALU 8-bit Inputs                 
           reg [1:0] ALU_Sel1,ALU_Sel2;// ALU Selection
           wire [7:0] ALU_Out1,ALU_Out2; // ALU 8-bit Output
           wire CarryOut1,CarryOut2; // Carry Out Flag
		   wire [7:0] x;
		   wire y;

integer i;

my_alu_xor UUT (.clk(clk), .A0(A0), .B0(B0), .A1(A1), .B1(B1), .ALU_Sel1(ALU_Sel1), .ALU_Sel2(ALU_Sel2), .ALU_Out1(ALU_Out1), .ALU_Out2(ALU_Out2), .CarryOut1(CarryOut1), .CarryOut2(CarryOut2), .x(x), .y(y));



initial
begin

clk = 1'b1;
ALU_Sel1 = 2'b00;
ALU_Sel2 = 2'b00;
A0=8'b00000000;
B0=8'b00000000;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Add - ALU1 != ALU2");
else
$display("Add - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Add - Carry1 != Carry2");
else
$display("Add - Carry1 = Carry2");
#10;

ALU_Sel1 =  2'b01;
ALU_Sel2 =  2'b01;
A0=8'b10000000;
B0=8'b00000000;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Sub - ALU1 != ALU2");
else
$display("Sub - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Sub - Carry1 != Carry2");
else
$display("Sub - Carry1 = Carry2");
#10;

ALU_Sel1 =  2'b10;
ALU_Sel2 =  2'b10;
A0=8'b00000000;
B0=8'b00000000;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("And - ALU1 != ALU2");
else
$display("And - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("And - Carry1 != Carry2");
else
$display("And - Carry1 = Carry2");
#10;

ALU_Sel1 =  2'b11;
ALU_Sel2 =  2'b11;
A0=8'b00000000;
B0=8'b00000000;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Or - ALU1 != ALU2");
else
$display("Or - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Or - Carry1 != Carry2");
else
$display("Or - Carry1 = Carry2");
#10;



ALU_Sel1 = 2'b00;
ALU_Sel2 = 2'b00;
A0=8'b10000001;
B0=8'b10000001;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Add - ALU1 != ALU2");
else
$display("Add - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Add - Carry1 != Carry2");
else
$display("Add - Carry1 = Carry2");
#10;


ALU_Sel1 = 2'b01;
ALU_Sel2 = 2'b01;
A0=8'b10000001;
B0=8'b10000001;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Sub - ALU1 != ALU2");
else
$display("Sub - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Sub - Carry1 != Carry2");
else
$display("Sub - Carry1 = Carry2");
#10;


ALU_Sel1 = 2'b10;
ALU_Sel2 = 2'b10;
A0=8'b10000001;
B0=8'b10000001;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("And - ALU1 != ALU2");
else
$display("And - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("And - Carry1 != Carry2");
else
$display("And - Carry1 = Carry2");
#10;
 
 
ALU_Sel1 = 2'b11;
ALU_Sel2 = 2'b11;
A0=8'b10000001;
B0=8'b10000001;
A1=8'b00000000;
B1=8'b00000000;
#10;
if(ALU_Out1 != ALU_Out2)
$display("Or - ALU1 != ALU2");
else
$display("Or - ALU1 = ALU2");
#10;
if(CarryOut1 != CarryOut2)
$display("Or - Carry1 != Carry2");
else
$display("Or - Carry1 = Carry2");
#10;
end
endmodule
