//program calling the main program
module cla_h_1(
    input  wire [15:0] A, B,
    input  wire        cin,
    output wire [15:0] sum,
    output wire        cout
);
    wire [3:0] gg, pg;
    wire [3:1] C_group;
    assign C_group[1] = gg[0] | (pg[0] & cin);
    assign C_group[2] = gg[1] | (pg[1] & gg[0]) | (pg[1] & pg[0] & cin);
    assign C_group[3] = gg[2] | (pg[2] & gg[1]) | (pg[2] & pg[1] & gg[0]) | (pg[2] & pg[1] & pg[0] & cin);
    cla_h b0 (A[3:0],   B[3:0],   cin,        sum[3:0],   gg[0], pg[0]);
    cla_h b1 (A[7:4],   B[7:4],   C_group[1], sum[7:4],   gg[1], pg[1]);
    cla_h b2 (A[11:8],  B[11:8],  C_group[2], sum[11:8],  gg[2], pg[2]);
    cla_h b3 (A[15:12], B[15:12], C_group[3], sum[15:12], gg[3], pg[3]);
    assign cout = gg[3] | (pg[3] & C_group[3]);
endmodule
