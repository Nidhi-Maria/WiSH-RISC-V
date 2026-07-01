
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr
);

// Edit the code here begin ---------------------------------------------------

    assign mem_rw_mode = 1;

    logic flaglw;
    logic flaglh;
    logic flaglb;
    logic flaglhu;
    logic flaglbu;
    logic [4:0] rd_val;
    logic [32:0] mem_addr_flag;

    always @(posedge i_clk or negedge i_rst) begin
        if (~i_rst) begin
            flaglw <= 0;
            flaglh <= 0;
            flaglb <= 0;
            flaglhu <= 0;
            flaglbu <= 0;
        end
        else begin
            flaglw <= (load_control == `LW);
            flaglh <= (load_control == `LH);
            flaglb <= (load_control == `LB);
            flaglhu <= (load_control == `LHU);
            flaglbu <= (load_control == `LBU);
        end
    end

    always @(*) begin
        if (flaglw) begin
            stall_pc = 0;
            mem_addr = 0;
            rd_write_control = 1;
            rd_write_val = mem_data;
            rd_out = rd_val;
            ignore_curr_inst = 1;
        end
        else if (flaglh) begin
            stall_pc = 0;
            mem_addr = 0;
            rd_write_control = 1;
            if ((mem_addr_flag[1:0] == 2'b00) || (mem_addr_flag[1:0] == 2'b01))
                rd_write_val = {{16{mem_data[15]}}, mem_data[15:0]};
            else
                rd_write_val = {{16{mem_data[31]}}, mem_data[31:16]};
            rd_out = rd_val;
            ignore_curr_inst = 1;
        end
        else if (flaglb) begin
            stall_pc = 0;
            mem_addr = 0;
            rd_write_control = 1;
            if (mem_addr_flag[1:0] == 2'b00)
                rd_write_val = {{24{mem_data[7]}}, mem_data[7:0]};
            else if (mem_addr_flag[1:0] == 2'b01)
                rd_write_val = {{24{mem_data[15]}}, mem_data[15:8]};
            else if (mem_addr_flag[1:0] == 2'b10)
                rd_write_val = {{24{mem_data[23]}}, mem_data[23:16]};
            else
                rd_write_val = {{24{mem_data[31]}}, mem_data[31:24]};
            rd_out = rd_val;
            ignore_curr_inst = 1;
        end
        else if (flaglhu) begin
            stall_pc = 0;
            mem_addr = 0;
            rd_write_control = 1;
            if ((mem_addr_flag[1:0] == 2'b00) || (mem_addr_flag[1:0] == 2'b01))
                rd_write_val = {16'b0, mem_data[15:0]};
            else
                rd_write_val = {16'b0, mem_data[31:16]};
            rd_out = rd_val;
            ignore_curr_inst = 1;
        end
        else if (flaglbu) begin
            stall_pc = 0;
            mem_addr = 0;
            rd_write_control = 1;
            if (mem_addr_flag[1:0] == 2'b00)
                rd_write_val = {24'b0, mem_data[7:0]};
            else if (mem_addr_flag[1:0] == 2'b01)
                rd_write_val = {24'b0, mem_data[15:8]};
            else if (mem_addr_flag[1:0] == 2'b10)
                rd_write_val = {24'b0, mem_data[23:16]};
            else
                rd_write_val = {24'b0, mem_data[31:24]};
            rd_out = rd_val;
            ignore_curr_inst = 1;
        end
        else if ((load_control == `LW) || (load_control == `LH) || (load_control == `LB) || (load_control == `LBU) || (load_control == `LHU)) begin
            stall_pc = 1'b1;
            mem_addr = rs1_val + imm;
            mem_addr_flag = mem_addr;
            rd_write_control = 0;
            rd_write_val = 0;
            rd_out = 0;
            ignore_curr_inst = 0;
            rd_val = rd_in;
        end
        else begin
            stall_pc = 0;
            mem_addr = 0;
            mem_addr_flag = 0;
            rd_write_control = 0;
            rd_write_val = 0;
            rd_out = 0;
            ignore_curr_inst = 0;
            rd_val = 0;
        end
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/load.vcd");
        $dumpvars(0, load);
    end
`endif

endmodule
