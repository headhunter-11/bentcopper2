module register_file(
    input  logic        clk,
    input  logic        reset,
    input  logic        reg_write,
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,
    input  logic [31:0] wb_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);
    logic [31:0] regs [0:31];
    integer i;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'd0;
        end else if (reg_write && (rd != 5'd0)) begin
            regs[rd] <= wb_data;
        end
    end

    always_comb begin
        rs1_data = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
        rs2_data = (rs2 == 5'd0) ? 32'd0 : regs[rs2];
    end
endmodule
