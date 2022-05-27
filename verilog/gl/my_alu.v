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