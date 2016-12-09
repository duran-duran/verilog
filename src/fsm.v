module fsm (
  input clock, reset,
  input [5:0] opcode,
  input [5:0] funct,
  input zero,
  output reg pc_load,
  output reg write,
  output reg [5:0] alu_funct,
  output reg rd_mux_s, op2_mux_s, branch_mux_s, j_mux_s
);
  reg[2:0] state;
  parameter IF = 3'd0;
  parameter ID = 3'd1;
  parameter EX = 3'd2;
  parameter MA = 3'd3;
  parameter WB = 3'd4;

  parameter OP_R = 6'b000000;
  parameter OP_ADDI = 6'b001000;
  parameter OP_BEQ = 6'b000100;
  parameter OP_J = 6'b000010;

  parameter OPR_ADD = 6'b100000;
  parameter OPR_SUB = 6'b100010;

  always @(posedge clock, posedge reset)
  begin
    if (reset)
      state <= IF;
    else
    begin
      case (state)
      IF:
      begin
        pc_load <= 0;
        write <= 0;
        alu_funct <= 0;
        rd_mux_s <= 1;
        op2_mux_s <= 0;
        branch_mux_s <= 0;
        j_mux_s <= 0;

        state <= ID;
      end
      ID:
      begin
        case (opcode)
        OP_R:
        begin
          alu_funct <= funct;

          state <= EX;
        end
        OP_ADDI:
        begin
          alu_funct <= OPR_ADD;
          rd_mux_s <= 0;
          op2_mux_s <= 1;

          state <= EX;
        end
        OP_BEQ:
        begin
          alu_funct <= OPR_SUB;
          rd_mux_s <= 1;
          branch_mux_s <= zero;

          state <= EX;
        end
        OP_J:
        begin
          j_mux_s <= 1;
          pc_load <= 1;

          state <= IF;
        end
        endcase
      end
      EX:
      begin
        case (opcode)
        OP_R, OP_ADDI: state <= WB;
        OP_BEQ:
        begin
          pc_load <= 1;

          state <= IF;
        end
        endcase
      end
      MA:;
      WB:
      begin
        write <= 1;
        pc_load <= 1;

        state <= IF;
      end
      default: state <= IF;
      endcase
    end
  end
endmodule
