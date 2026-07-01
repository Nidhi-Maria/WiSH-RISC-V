
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_branch_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [12:0] imm,
    output logic [2:0] branch_control
);

// Edit the code here begin ---------------------------------------------------

    logic [2:0] funct3;
    assign funct3 = instruction_code[14:12];

    assign rs1 = instruction_code[19:15];
    assign rs2 = instruction_code[24:20];
    assign {imm[12], imm[10:5], imm[4:1], imm[11]} = {instruction_code[31:25], instruction_code[11:7]};
    assign imm[0] = 1'b0;

    always @(*) begin
        if (funct3 == 3'h0) branch_control = `BEQ;
        else if (funct3 == 3'h1) branch_control = `BNE;
        else if (funct3 == 3'h4) branch_control = `BLT;
        else if (funct3 == 3'h5) branch_control = `BGE;
        else if (funct3 == 3'h6) branch_control = `BLTU;
        else if (funct3 == 3'h7) branch_control = `BGEU;
        else branch_control = `BR_NOP;
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_branch_inst.vcd");
        $dumpvars(0, decode_branch_inst);
    end
`endif

endmodule
