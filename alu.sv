
module alu (
  input  logic [31:0]  a_i,
  input  logic [31:0]  b_i,
  input  logic [4:0]   alu_op_i,
  output logic         flag_o,
  output logic [31:0]  result_o
);

import alu_opcodes_pkg::*;    // импорт параметров, содержащих
                              // коды операций для АЛУ
logic cmp, mod;
logic[2:0] opcode ;

assign cmp = alu_op_i [4];
logic [31:0] adder_sum;

fulladder32 adder ( // Adder for the sum operation
    .a_i (a_i),
    .b_i (b_i),
    .carry_i (1'b0),
    .sum_o (adder_sum)
);

always_comb begin
    if (cmp) begin // COMPARISON OPERATIONS
        result_o = 0;
        case (alu_op_i)
            ALU_LTS:
                flag_o = $signed(a_i) < $signed(b_i);
            ALU_LTU:
                flag_o = a_i < b_i;
            ALU_GES:
                flag_o = $signed(a_i) >= $signed(b_i);
            ALU_GEU:
                flag_o = a_i >= b_i;
            ALU_EQ:
                flag_o = a_i == b_i;
            ALU_NE:
                flag_o = a_i != b_i;
            default:
                flag_o = 0;
        endcase
    end else begin // CALCULATION OPERATIONS
        flag_o = 0;
        case (alu_op_i)
            ALU_ADD:
                result_o = adder_sum;
            ALU_SUB:
                result_o = a_i - b_i;
            ALU_XOR:
                result_o = a_i ^ b_i;
            ALU_OR:
                result_o = a_i | b_i;
            ALU_AND:
                result_o = a_i & b_i;
            ALU_SRA:
                result_o = $signed(a_i) >>> b_i [4:0];
            ALU_SRL:
                result_o = a_i >> b_i [4:0];
            ALU_SLL:
                result_o = a_i << b_i [4:0];
            ALU_SLTS:  // Set Less Than Signed
                result_o = $signed(a_i) < $signed(b_i);
            ALU_SLTU: // Set Less Than Unsigned    
                result_o = a_i < b_i;
            default:
                result_o = 0;
        endcase
    end
end

endmodule

