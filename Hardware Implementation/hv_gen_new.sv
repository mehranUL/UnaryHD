module hv_generator (a,b,clk,HVb);
input [15:0] a, b; // a,b are two unary bitstreams
input clk;
output HVb;

wire [15:0] t,s;
wire [15:0] y;
//wire eq,gt,lt;
wire temp;


not n1(t[0],a[0]);
not n2(t[1],a[1]);
not n3(t[2],a[2]);
not n4(t[3],a[3]);
not n5(t[4],a[4]);
not n6(t[5],a[5]);
not n7(t[6],a[6]);
not n8(t[7],a[7]);
not n9(t[8],a[8]);
not n10(t[9],a[9]);
not n11(t[10],a[10]);
not n12(t[11],a[11]);
not n13(t[12],a[12]);
not n14(t[13],a[13]);
not n15(t[14],a[14]);
not n16(t[15],a[15]);


and a1(s[0],a[0],b[0]);
and a2(s[1],a[1],b[1]);
and a3(s[2],a[2],b[2]);
and a4(s[3],a[3],b[3]);
and a5(s[4],a[4],b[4]);
and a6(s[5],a[5],b[5]);
and a7(s[6],a[6],b[6]);
and a8(s[7],a[7],b[7]);
and a9(s[8],a[8],b[8]);
and a10(s[9],a[9],b[9]);
and a11(s[10],a[10],b[10]);
and a12(s[11],a[11],b[11]);
and a13(s[12],a[12],b[12]);
and a14(s[13],a[13],b[13]);
and a15(s[14],a[14],b[14]);
and a16(s[15],a[15],b[15]);

or o1(y[0],t[0],s[0]);
or o2(y[1],t[1],s[1]);
or o3(y[2],t[2],s[2]);
or o4(y[3],t[3],s[3]);
or o5(y[4],t[4],s[4]);
or o6(y[5],t[5],s[5]);
or o7(y[6],t[6],s[6]);
or o8(y[7],t[7],s[7]);
or o9(y[8],t[8],s[8]);
or o10(y[9],t[9],s[9]);
or o11(y[10],t[10],s[10]);
or o12(y[11],t[11],s[11]);
or o13(y[12],t[12],s[12]);
or o14(y[13],t[13],s[13]);
or o15(y[14],t[14],s[14]);
or o16(y[15],t[15],s[15]);


assign temp = &(y);
assign HVb = ~temp;

endmodule