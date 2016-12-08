// регистр сохраняет число
// по позитивному фронту reset немедленно число сбрасывается в 0
// если go на позитивном фронте clock'а, то к числу прибавляется единица
// выводить текущее число в out
module counter
  #(parameter Width = 32)
  ( input reset, clock, go,
    output [Width-1:0] out
  );
  
  wire [Width-1:0] rin;
  register r(.in(rin), .out(out), .load(go), .reset(reset), .clock(clock));
  adder incr(.in1(out), .in2(1), .out(rin));
endmodule
