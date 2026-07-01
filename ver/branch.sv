
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module branch(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] pc_prev,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [2:0] branch_control,
    output logic pc_update_control,
    output logic [31:0] pc_update_val,
    output logic ignore_curr_inst
);

// Edit the code here begin ---------------------------------------------------

    logic flag;
    logic cor_flag;

    always @(*) begin
        case (branch_control)
            `BEQ : if (rs1_val == rs2_val)  cor_flag = 1;
                   else cor_flag = 0;
            `BNE : if (rs1_val != rs2_val)  cor_flag = 1;
                   else cor_flag = 0;
            `BLT : if ($signed(rs1_val) < $signed(rs2_val))  cor_flag = 1;
                   else cor_flag = 0;
            `BGE : if ($signed(rs1_val) >= $signed(rs2_val))  cor_flag = 1;
                   else cor_flag = 0;
            `BLTU : if (rs1_val < rs2_val)  cor_flag = 1;
                    else cor_flag = 0;
            `BGEU : if (rs1_val >= rs2_val)  cor_flag = 1;
                    else cor_flag = 0;
            default: cor_flag = 0;
        endcase
    end

    always @(posedge i_clk or negedge i_rst) begin
        if (~i_rst) begin
            flag <= 0;
        end
        else begin
            flag <= cor_flag;
        end
    end

    always @(*) begin
        if (flag) begin
            pc_update_control = 0;
            pc_update_val = 0;
            ignore_curr_inst = 1;
        end
        else if (cor_flag) begin
            pc_update_control = 1'b1;
            pc_update_val = pc_prev + imm;
            ignore_curr_inst = 0;
        end
        else begin
            pc_update_control = 0;
            pc_update_val = 0;
            ignore_curr_inst = 0;
        end
    end

    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/branch.vcd");
        $dumpvars(0, branch);
    end
`endif

endmodule
