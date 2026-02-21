//Main Prog
module cla_h(
input  wire [3:0] A, B,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       gg, 
    output wire       pg,
    output wire       cout
);
    wire [3:0] G = A & B;
    wire [3:0] P = A ^ B;
    wire [3:1] C;

    assign C[1] = G[0] | (P[0] & cin);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
    assign pg = &P; 
    assign gg = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

    assign sum  = P ^ {C, cin};
    assign cout = gg | (pg & cin);
endmodule


