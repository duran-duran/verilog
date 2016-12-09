module testbench;

  reg clock, load, reset;

  wire write;
  wire[5:0] opcode, funct, alu_funct;
  wire rd_mux_s, op2_mux_s, branch_mux_s, j_mux_s;
  wire zero;

  op_aut op_aut_inst(.clock(clock), .load(load), .reset(reset),
                     .rd_mux_s(rd_mux_s), .write(write), .op2_mux_s(op2_mux_s),
                     .alu_funct(alu_funct), .branch_mux_s(branch_mux_s), .j_mux_s(j_mux_s),
                     .opcode(opcode), .funct(funct), .zero(zero));

  fsm fsm_inst(.opcode(opcode), .funct(funct), .zero(zero),
               .write(write), .alu_funct(alu_funct),
               .rd_mux_s(rd_mux_s), .op2_mux_s(op2_mux_s), .branch_mux_s(branch_mux_s), .j_mux_s(j_mux_s));

  initial clock = 0;
  always #1 clock = ~clock;

  initial
  begin
    $dumpfile("out.vcd");
    $dumpvars(0, testbench);
  end

  initial
  begin
    #1
    reset = 1;
    #1
    reset = 0;
    #1
    load = 1;
    #10
    load = 0;
    #1
    $finish; // закончить симуляцию
  end

endmodule
