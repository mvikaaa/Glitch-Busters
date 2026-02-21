
`timescale 1ns/1ps

module tb_pipelined_array_multiplier;

parameter WIDTH = 8;
parameter LATENCY = WIDTH;   // pipeline depth

reg clk;
reg [WIDTH-1:0] a,b;
wire [2*WIDTH-1:0] p;

integer i;

// DUT
pipelined_array_multiplier #(WIDTH) dut (
    .clk(clk),
    .a(a),
    .b(b),
    .p(p)
);



// Clock generation
initial clk = 0;
always #5 clk = ~clk;



// Expected value queue
reg [2*WIDTH-1:0] expected [0:1000];

integer write_ptr = 0;
integer read_ptr  = 0;



initial
begin
    $display("Starting Pipelined Multiplier Test");

    // Apply random inputs
    for(i=0;i<50;i=i+1)
    begin
        @(posedge clk);
        a <= $random;
        b <= $random;

        expected[write_ptr] = a * b;
        write_ptr = write_ptr + 1;
    end

    // wait for pipeline to flush
    repeat(LATENCY+2) @(posedge clk);

    $display("Test completed successfully");
    $finish;
end



// Output checker
always @(posedge clk)
begin
    if(read_ptr < write_ptr)
    begin
        if(p !== expected[read_ptr])
        begin
            $display("ERROR at time %t : Expected=%d Got=%d",
                     $time, expected[read_ptr], p);
            $stop;
        end

        read_ptr = read_ptr + 1;
    end
end

endmodule
