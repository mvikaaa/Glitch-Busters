module pipelined_array_multiplier #(
    parameter WIDTH = 8
)(
    input clk,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [2*WIDTH-1:0] p
);

    wire [WIDTH-1:0] pp [WIDTH-1:0];

    // Partial products
    genvar i;
    generate
        for(i=0;i<WIDTH;i=i+1) begin : PP
            assign pp[i] = a & {WIDTH{b[i]}};
        end
    endgenerate


    // Pipeline registers
    reg [2*WIDTH-1:0] stage [WIDTH:0];

    integer k;

    always @(posedge clk)
    begin
        stage[0] <= 0;

        for(k=0;k<WIDTH;k=k+1)
            stage[k+1] <= stage[k] + ({{WIDTH{1'b0}},pp[k]} << k);

        p <= stage[WIDTH];
    end

endmodule
