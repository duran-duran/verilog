module op_aut (
    input clock, reset, write
  );

  wire[31:0] pc_out, pc_adder_out;

  register pc(.in(pc_adder_out), .out(pc_out), .load(1'b1), .clock(clock), .reset(reset));
  adder pc_adder(.in1(pc_out), .in2(32'h04), .out(pc_adder_out));

endmodule

