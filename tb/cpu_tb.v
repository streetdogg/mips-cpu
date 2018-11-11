/*
 * Test bench to test the cPU implementation
 */

module cpu_tb();

    reg clk, reset;

    cpu TU(.clk(clk),
           .rst(reset));

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        #10
        reset = 1'b0;
        #10
        reset = 1'b1;
        #500
        $finish;
    end

    always #10 clk = ~clk;

endmodule