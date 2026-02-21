Synthesizable RTL code.
module array_multiplier #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output [2*WIDTH-1:0] p
);

    // Partial products
    wire [WIDTH-1:0] pp [WIDTH-1:0];

    genvar i;

    generate
        for (i=0;i<WIDTH;i=i+1) begin : PP_GEN
            assign pp[i] = a & {WIDTH{b[i]}};
        end
    endgenerate


    // Accumulator chain (area-optimized)
    wire [2*WIDTH-1:0] sum [WIDTH:0];
    assign sum[0] = 0;

    generate
        for (i=0;i<WIDTH;i=i+1) begin : ADD_STAGE
            assign sum[i+1] = sum[i] + ({{WIDTH{1'b0}},pp[i]} << i);
        end
    endgenerate

    assign p = sum[WIDTH];

endmodule
