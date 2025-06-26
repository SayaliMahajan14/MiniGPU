module multiplexer_tb;
reg a,b,sel;
wire out;

multiplexer instance1 ( .a(a), .b(b), .sel(sel), .out(out));

initial begin 
a=0; b=0; sel=0;

#10 a=1; b=0; sel=0;
#10 a=1; b=1; sel=0;
#10 a=1; b=1; sel=1;
#10 a=0; b=1; sel=1;
#10 a=0; b=0; sel=1;
#10 a=1; b=0; sel=0;
#10 a=1; b=0; sel=1;
#10 a=1; b=1; sel=0;

end
endmodule
