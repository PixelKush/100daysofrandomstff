module full_subtractor(a,b,bin,diff,borrow);
    input a,b,bin;
    output diff,borrow;
    wire x,y,z;

    half subtractor h1(.a(a),.b(b),.bin(bin),.d(x),.b1(y));
    half subtractor h2(.a(x),.b(0),.bin(0),.d(diff),.b1(z));
    or o1(borrow,y,z);          
endmodule

reg [:]  [:];
