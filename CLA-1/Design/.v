//Code for apprximated CLA
module CLA(
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);
    wire [3:0] G, P, C;
    assign G = A & B;   
    assign P = A ^ B;      
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign cout = G[3] | (P[3] & C[3]);
    assign sum = P ^ C;
endmodule
