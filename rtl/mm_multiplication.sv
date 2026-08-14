module mm_multiplication (
  input logic [7:0] a, b, c, d, e, f, g, h,
  output logic [15:0] ae, bg, af, bh, ce, dg, cf, dh
);

  always_comb begin
    ae = a * e;
    bg = b * g;
    af = a * f;
    bh = b * h;
    ce = c * e;
    dg = d * g;
    cf = c * f;
    dh = d  * h;
  end
  
endmodule

