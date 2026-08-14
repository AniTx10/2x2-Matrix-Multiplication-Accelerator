module mm_addition (
  input  logic [15:0] p11_1, p11_2, p12_1, p12_2,
  input  logic [15:0] p21_1, p21_2, p22_1, p22_2,
  output logic [16:0] c11, c12, c21, c22
);

  always_comb begin
    c11 = p11_1 + p11_2;
    c12 = p12_1 + p12_2;
    c21 = p21_1 + p21_2;
    c22 = p22_1 + p22_2;
  end
endmodule

