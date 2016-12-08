module op_aut (
    input clock, reset,
    input rd_mux_s,
    input write,
    input op2_mux_s,
    output[5:0] opcode,
    output[5:0] funct,
    output zero
  );

  wire[31:0] pc_out, pc_adder_out,
             instruction;
  wire[4:0] rs, rt, rd, rd_mux_out;
  wire[15:0] imm;
  wire[25:0] j_imm;

  wire[31:0] rdata1, rdata2, imm_data, alu_result;

  register pc(.in(pc_adder_out), .out(pc_out), .load(1'b1), .clock(clock), .reset(reset));
  adder pc_adder(.in1(pc_out), .in2(32'h04), .out(pc_adder_out));
  instruction_memory ins_mem(.sel(pc_out), .out(instruction));

  assign opcode = instruction[31:26];
  assign funct = instruction[5:0];

  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd = instruction[15:11];

  assign imm = instruction[15:0];
  assign j_imm = instruction[25:0];

  mux2 #(.Width(5)) rd_mx(.i0(rt), .i1(rd), .s(rd_mux_s), .o(rd_mux_out));

  register_file regs(.raddr1(rs), .raddr2(rt), .waddr(rd_mux_out), .wdata(alu_result),
                     .write(write), .clock(clock), .reset(reset),
                     .rdata1(rdata1), .rdata2(rdata2));


endmodule

