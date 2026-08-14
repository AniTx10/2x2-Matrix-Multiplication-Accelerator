module mm_output_register (
  input logic clk,
  input logic rst,
  input logic [16:0] c11, c12, c21, c22,
  output logic [16:0] m11, m12, m21, m22
);

  always_ff @ (posedge clk, posedge rst) begin
    if (rst == 1'b1) begin
      {m11, m12, m21, m22} <= 68'b0;
    end else begin
      {m11, m12, m21, m22} <= {c11, c12, c21, c22};
    end
  end
endmodule

