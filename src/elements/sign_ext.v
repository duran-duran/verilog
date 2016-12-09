module sign_ext #(parameter src = 16, dest = 32)
(
    input [src-1:0] in,
    output [dest-1:0] out
);
    assign out = { {(dest-src){in[src-1]}}, in};
endmodule

