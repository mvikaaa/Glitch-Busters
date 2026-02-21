//test bench for approximated CLA
module CLA_tb;
        reg [3:0] A;
        reg [3:0] B;
        reg cin;
        wire [3:0] sum;
        wire cout;
        CLA uut (
            .A(A), 
            .B(B), 
            .cin(cin), 
            .sum(sum), 
            .cout(cout)
        );
    
        initial begin
            A = 0; B = 0; cin = 0;
            #10 A = 4'b0010; B = 4'b0001; cin = 0;
            #10 A = 4'b0101; B = 4'b0101; cin = 0; 
            #10 A = 4'b1010; B = 4'b0110; cin = 0;
            #10 A = 4'b1111; B = 4'b1111; cin = 0; 
            #10 A = 4'b1111; B = 4'b0000; cin = 1; 
            #10 A = 4'b1000; B = 4'b1000; cin = 0; 
            #10 A = 4'b0111; B = 4'b0001; cin = 0; 
            
            #20;
            $display("Simulation Finished");
            $finish;
        end
        initial begin
            $monitor("%0t\t %b \t %b \t %b \t %b \t %b", $time, A, B, cin, sum, cout);
        end
        initial begin
            $dumpfile("cla_waveform.vcd");
            $dumpvars(0, CLA_tb);
        end
endmodule

