`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2025 19:06:46
// Design Name: 
// Module Name: CYBERcobra
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CYBERcobra (
  input  logic         clk_i,
  input  logic         rst_i,
  input  logic [15:0]  sw_i,
  output logic [31:0]  out_o
);

logic[31:0] pc = 32'b0;
logic[31:0] instruction;

// Instruction
logic       B;
logic[2:0]  WS;
logic[4:0]  ALUop;
logic[4:0]  RA1;
logic[4:0]  RA2;
logic[4:0]  WA;
logic[22:0] RF_const;
logic[7:0]  offset_const;

assign J =            instruction[31];
assign B =            instruction[30];
assign WS =           instruction[29:28];
assign ALUop =        instruction[27:23];
assign RA1 =          instruction[22:18];
assign RA2 =          instruction[17:13];
assign WA =           instruction[4:0];
assign RF_const =     instruction[27:5];
assign offset_const = instruction[12:5];


// Logic

logic[31:0] operand1;
logic[31:0] operand2;
logic[31:0] ALUresult;
logic       ALUflag;


logic[31:0] write_source;

alu aluUnit (
    .a_i (operand1),
    .b_i (operand2),
    .result_o (ALUresult),
    .alu_op_i (ALUop),
    .flag_o (ALUflag)
);


register_file regFile (
    .clk_i (clk_i),
    .write_enable_i (!(B | J)),
    
    .write_addr_i (WA),
    .read_addr1_i (RA1),
    .read_addr2_i (RA2),
    
    .write_data_i (write_source),
    .read_data1_o (operand1),
    .read_data2_o (operand2)
);

assign out_o = operand1;

// Memory


instr_mem memory (
    .read_addr_i (pc),
    .read_data_o (instruction)
);


// Workflow

//always_ff @(posedge rst_i) begin
//    pc <= 0;
//end

always_comb begin
    if (!B & !J) begin // Data
        if (WS == 0) begin // Constant
            write_source = {{9{RF_const[22]}}, RF_const};
        end else if (WS == 1) begin // Calculations
            write_source = ALUresult;
        end else if (WS == 2) begin
            write_source = {{16{sw_i[15]}}, sw_i}; // External source
        end else begin
            write_source = 32'b0;
        end
    end 
end

logic[31:0] pcChange = 32'b0;

always_comb begin
    if (B) begin
        if (ALUflag) begin
            pcChange = 4 * {{24{offset_const[7]}}, offset_const};
        end else begin
            pcChange = 4;
        end
    end else if (J) begin
        pcChange = 4 * {{24{offset_const[7]}}, offset_const};
    end else begin
        pcChange = 4;
    end
end

always_ff @(posedge clk_i) begin
    if (!rst_i) begin
        pc <= pc + pcChange;
    end else begin
        pc <= 0;
    end
end

endmodule