module fsm (
  input [5:0] opcode,
  input [5:0] funct,
  input zero,
  output reg write,
  output reg [5:0] alu_funct,
  output reg rd_mux_s, op2_mux_s, branch_mux_s
);

  parameter OP_R = 6'b000000;
  parameter OP_ADDI = 6'b001000;
  parameter OP_BEQ = 6'b000100;

  parameter OPR_ADD = 6'b100000;
  parameter OPR_SUB = 6'b100010;

  always @(opcode, funct, zero)
  begin
    case (opcode)
    OP_R:
      begin
        write = 1;
        alu_funct = funct; 
        rd_mux_s = 1; 
        op2_mux_s = 0; 
        branch_mux_s = 0;
      end
    OP_ADDI:
      begin
        write = 1; 
        alu_funct = OPR_ADD; 
        rd_mux_s = 0; 
        op2_mux_s = 1; 
        branch_mux_s = 0;
      end
    OP_BEQ: 
      begin
        write = 0;
        alu_funct = OPR_SUB; 
        rd_mux_s = 1; 
        op2_mux_s = 0; 
        branch_mux_s = zero;
      end
    endcase
  end
endmodule
