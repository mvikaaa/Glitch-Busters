//Code for approximated CLA
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

//RTL scehmatic of the approximated CLA
<img width="1435" height="473" alt="Screenshot 2026-02-21 114927" src="https://github.com/user-attachments/assets/8f65f9ce-54f6-46e9-b8db-ee27627a28c6" />

//Simulation waveform of approximated CLA
<img width="1154" height="176" alt="image" src="https://github.com/user-attachments/assets/08f7fac3-7676-454c-a0d1-1f097b739d9f" />

//Explanation of wroking
Unlike a regular CLA waiting for the carry, the code provided predicts it instead by splitting a a full adder where only the xor logic remians intact. We are replacing a slow serial process with a fast parallel process.

//Comparison with a Traditional CLA
The approximated CLA takes significantly lesser area and is faster. Unlike the traditional CLA, the approximated one uses a shorter critical path, therefore has lesser gate delays (image for comparison)
<img width="1433" height="668" alt="image" src="https://github.com/user-attachments/assets/253d472e-c59a-4268-8758-e9bc90cd3e01" />

