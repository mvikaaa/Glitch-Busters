//RTL VERILOG
module ram#(
    parameter ADDR_WIDTH = 4,        
    parameter DATA_WIDTH = 8,       
    parameter DEPTH = 16             
)(
    input  wire                  clk,   
    input  wire                  we,    
    input  wire [ADDR_WIDTH-1:0] addr,  
    input  wire [DATA_WIDTH-1:0] din,   
    output reg  [DATA_WIDTH-1:0] dout   
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;
        end else begin
            dout <= mem[addr];
        end
    end
endmodule
