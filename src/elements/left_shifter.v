module left_shifter #(parameter LogWidth = 5) (
  input[2**LogWidth-1:0] in,
  input[LogWidth-1:0] shamt,
  output[2**LogWidth-1:0] out
);
  assign out = in << shamt;
endmodule
