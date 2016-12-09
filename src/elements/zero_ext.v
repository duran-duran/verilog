module zero_ext #(parameter src = 16, dest = 32)
(
    input [src-1:0] in,
    output [dest-1:0] out
);
    assign out = { {(dest-src){1'b0}}, in};
endmodule

