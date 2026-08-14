`default_nettype none
// Empty top module

module matrix_multiply_2x2 (
  // I/O ports
  input  logic clk, rst,

  //Matrix A Inputs [2x2]: [a, b; c, d]
  input logic [7:0] a, b, c, d,

  //Matrix B Inputs [2x2]: [e, f; g, h]
  input logic [7:0] e, f, g, h,

  //Matrix C Outputs [2x2]: [m11, m12; m21, m22]
  output logic [16:0] m11, m12, m21, m22
);

    // Intermediate Wires
    // Stage 1 Combinational Products (16-bit)
    logic [15:0] ae, bg, af, bh, ce, dg, cf, dh;

    // Stage 1 Registered Products (16-bit)
    logic [15:0] reg_ae, reg_bg, reg_af, reg_bh;
    logic [15:0] reg_ce, reg_dg, reg_cf, reg_dh;

    // Stage 2 Combinational Additions (17-bit)
    logic [16:0] c11, c12, c21, c22;
  
    //Sub-module instantiations

    // 1. Stage 1 Multipliers
    mm_multiplication mult_stage (
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .ae(ae), .bg(bg), .af(af), .bh(bh),
        .ce(ce), .dg(dg), .cf(cf), .dh(dh)
    );

    // 2. Stage 1 Pipeline Registers (Saves intermediate products on clk)
    mm_stage1_register stage1_reg (
        .clk(clk),
        .rst(rst),
        .ae(ae), .bg(bg), .af(af), .bh(bh),
        .ce(ce), .dg(dg), .cf(cf), .dh(dh),
        .reg_ae(reg_ae), .reg_bg(reg_bg), .reg_af(reg_af), .reg_bh(reg_bh),
        .reg_ce(reg_ce), .reg_dg(reg_dg), .reg_cf(reg_cf), .reg_dh(reg_dh)
    );

    // 3. Stage 2 Adders
    mm_addition adder_stage (
        .p11_1(reg_ae), .p11_2(reg_bg),
        .p12_1(reg_af), .p12_2(reg_bh),
        .p21_1(reg_ce), .p21_2(reg_dg),
        .p22_1(reg_cf), .p22_2(reg_dh),
        .c11(c11), .c12(c12), .c21(c21), .c22(c22)
    );

    // 4. Stage 2 Output Registers (Saves additions to final output)
    mm_output_register output_reg (
        .clk(clk),
        .rst(rst),
        .c11(c11), .c12(c12), .c21(c21), .c22(c22),
        .m11(m11), .m12(m12), .m21(m21), .m22(m22)
    );   
  
  
endmodule




