testing parameterized array multiplier
module tb_array_multiplier;

    parameter WIDTH = 8;

    reg  [WIDTH-1:0] a, b;
    wire [2*WIDTH-1:0] p;

    integer i;

    // Instantiate DUT
    array_multiplier #(WIDTH) dut (
        .a(a),
        .b(b),
        .p(p)
    );


    // Test procedure
    initial begin
        $display("---- Array Multiplier Test ----");

        // Edge cases
        test_case(0,0);
        test_case(0,5);
        test_case(5,0);
        test_case({WIDTH{1'b1}},1);
        test_case({WIDTH{1'b1}},{WIDTH{1'b1}});

        // Random tests
        for (i=0;i<100;i=i+1) begin
            a = $random;
            b = $random;
            #1;
            check_result(a,b);
        end

        $display("All tests passed!");
        $finish;
    end


    // ---------- TASKS ----------

    task test_case(input [WIDTH-1:0] ta,
                   input [WIDTH-1:0] tb);
    begin
        a = ta;
        b = tb;
        #1;
        check_result(ta,tb);
    end
    endtask


    task check_result(input [WIDTH-1:0] ta,
                      input [WIDTH-1:0] tb);
    reg [2*WIDTH-1:0] expected;
    begin
        expected = ta * tb;

        if (p !== expected) begin
            $display("ERROR: %d * %d = %d (Expected %d)", ta, tb, p, expected);
            $stop;
        end
    end
