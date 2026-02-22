module halfadder_tb;
    reg a,b;
    wire s,c;

    half_Adder h1(s,c,a,b);

    initial begin
        $display("time\tA B | s c");
        $monitor("%g\t%b %b | %b %b", $time, a, b, s, c);
        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=1; #10;
        a=1; b=0; #10;
    $finish;
    end

    initial begin
        $dumpfile("halfadder1.vcd");
        $dumpvars(0,halfadder_tb);
    end

    endmodule
