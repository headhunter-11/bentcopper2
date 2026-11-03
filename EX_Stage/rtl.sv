module ex_stage(
    input  logic [31:0] rs1_data,
    input  logic [31:0] rs2_data,
    input  logic [31:0] imm_out,
    input  logic [31:0] address,
    input  logic        branch,
    input  logic        alu_src,
    input  logic        fn7_5,
    input  logic        mux_inp,
    input  logic [2:0]  fn3,
    input  logic [6:0]  imm11_5,
    input  logic [2:0]  aluop,
    input  logic [6:0]  opcode,
    output logic        and_out_ex,
    output logic [31:0] alu_out,
    output logic [31:0] pc_ex_out
);
    logic [31:0] alu_b;
    logic [4:0] alu_ctl;
    logic zero;

    assign alu_b = alu_src ? imm_out : rs2_data;

    alu_control ac(
        .alu_op(aluop), .fn3(fn3), .imm11_5(imm11_5),
        .fn7_5(fn7_5), .control_out(alu_ctl)
    );

    alu #(.DATA_WIDTH(32)) arithmetic(
        .alu_control(alu_ctl), .rs1_data(rs1_data),
        .rs2_data(alu_b), .alu_out(alu_out), .zero(zero)
    );

    always_comb begin
        if (mux_inp)
            pc_ex_out = {alu_out[31:1], 1'b0}; // JALR target
        else
            pc_ex_out = address + imm_out; // branch/JAL/AUIPC offset
        and_out_ex = (branch && zero) ||
                     (opcode == 7'b1101111) ||
                     (opcode == 7'b1100111);
    end
endmodule
