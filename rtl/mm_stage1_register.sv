module mm_stage1_register (
  input  logic clk,
  input  logic rst,
  input  logic [15:0] ae, bg, af, bh, ce, dg, cf, dh,
  output logic [15:0] reg_ae, reg_bg, reg_af, reg_bh,
  output logic [15:0] reg_ce, reg_dg, reg_cf, reg_dh
);

  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      {reg_ae, reg_bg, reg_af, reg_bh, reg_ce, reg_dg, reg_cf, reg_dh} <= 128'b0;
    end else begin
      {reg_ae, reg_bg, reg_af, reg_bh, reg_ce, reg_dg, reg_cf, reg_dh} <= {ae, bg, af, bh, ce, dg, cf, dh};
    end
  end
endmodule

