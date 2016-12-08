module ext16to32 (
    input [15:0] in,
    output [31:0] out
);
    assign out = { {14{in[15]}}, in, 2'b00 };
endmodule

