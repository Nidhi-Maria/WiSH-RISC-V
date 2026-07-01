
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_jump_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [31:0] imm,
    output logic [1:0] jump_control
);

// Edit the code here begin ---------------------------------------------------

    logic [2:0] funct3;
    logic [6:0] opcode;
    assign funct3 = instruction_code[14:12];
    assign opcode = instruction_code[6:0];

    assign rd = instruction_code[11:7];

    always @(*) begin
        if (opcode == 7'b110_1111) begin
            {imm[20], imm[10:1], imm[11], imm[19:12]} = instruction_code[31:12];
            imm[31:21] = {11{instruction_code[31]}};
            imm[0] = 0;
            rs1 = 5'b0;
            jump_control = `JAL;
        end
        else if (opcode == 7'b110_0111) begin
            if (funct3 == 3'h0) begin
                imm[11:0] = instruction_code[31:20];
                imm[31:12] = {20{instruction_code[31]}};
                rs1 = instruction_code[19:15];
                jump_control = `JALR;
            end
            else begin
                imm = 32'b0;
                rs1 = 5'b0;
                jump_control = `JMP_NOP;
            end
        end
        else begin
            imm = 32'b0;
            rs1 = 5'b0;
            jump_control = `JMP_NOP;
        end
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_jump_inst.vcd");
        $dumpvars(0, decode_jump_inst);
    end
`endif

endmodule
