
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);

    logic [6:0] funct7;
    logic [2:0] funct3;
    assign funct7 = instruction_code[31:25];
    assign funct3 = instruction_code[14:12];

// Edit the code here begin ---------------------------------------------------

    assign rs1 = instruction_code[19:15];
    assign rs2 = instruction_code[24:20];
    assign rd = instruction_code[11:7];

    always @(*) begin
        if (funct3 == 3'h0) begin
            if (funct7 == 7'h0) alu_control = `ADD;
            else if (funct7 == 7'h20) alu_control = `SUB;
            else alu_control = `ALU_NOP;
        end
        else if (funct3 == 3'h4) alu_control = (funct7 == 7'h0) ? `XOR : `ALU_NOP;
        else if (funct3 == 3'h6) alu_control = (funct7 == 7'h0) ? `OR : `ALU_NOP;
        else if (funct3 == 3'h7) alu_control = (funct7 == 7'h0) ? `AND : `ALU_NOP;
        else if (funct3 == 3'h1) alu_control = (funct7 == 7'h0) ? `SLL : `ALU_NOP;
        else if (funct3 == 3'h5) begin
            if (funct7 == 7'h0) alu_control = `SRL;
            else if (funct7 == 7'h20) alu_control = `SRA;
            else alu_control = `ALU_NOP;
        end
        else if (funct3 == 3'h2) alu_control = (funct7 == 7'h0) ? `SLT : `ALU_NOP;
        else if (funct3 == 3'h3) alu_control = (funct7 == 7'h0) ? `SLTU : `ALU_NOP;
        else alu_control = `ALU_NOP;
    end

    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_reg_inst.vcd");
        $dumpvars(0, decode_reg_inst);
    end
`endif

endmodule
