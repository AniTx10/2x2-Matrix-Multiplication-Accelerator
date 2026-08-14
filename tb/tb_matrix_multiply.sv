`timescale 1ns/1ps

module tb_matrix_multiply;
    logic clk, rst;
    logic [7:0] a, b, c, d, e, f, g, h;
    logic [16:0] m11, m12, m21, m22;

    // DUT
    matrix_multiply_2x2 dut (
        .clk(clk), .rst(rst), 
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .m11(m11), .m12(m12), .m21(m21), .m22(m22)
    );

    // 100 MHz Clock Generaiton (clock flips every 5 ns)
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform dump for GTKWave
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_matrix_multiply);
    end

    initial begin
        rst = 1;
        a = 0; b = 0; c = 0; d = 0;
        e = 0; f = 0; g = 0; h = 0;

        //reset released after 20 ns
        #20; 
        rst = 0;

        //test inputs on rising clock edge
        @(posedge clk);
        a = 8'd2; b = 8'd3; c = 8'd4; d = 8'd5;
        e = 8'd1; f = 8'd0; g = 8'd2; h = 8'd1;

        // Wait 2 clock cycles for 2 pipeline stages to fill
        repeat (2) @(posedge clk);
        #1;

        if(m11 == 17'd8 && m12 == 17'd3 && m21 == 17'd14 && m22 == 17'd5) begin
            $display("[PASS] Matrix output correct!");
        end else begin
            $error("[FAIL] Incorrect matrix output!");
        end

        $finish;
    end
endmodule

