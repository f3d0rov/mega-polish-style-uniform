
module fulladder32(
    input  logic [31:0] a_i,
    input  logic [31:0] b_i,
    input  logic        carry_i,
    output logic [31:0] sum_o,
    output logic        carry_o
);

logic carries[8:0];
assign carries[0] = carry_i;
assign carry_o = carries[8];

fulladder4 adders[7:0] (
    .a_i (a_i),
    .b_i (b_i),
    .sum_o (sum_o),
    .carry_i (carries[7:0]),
    .carry_o (carries[8:1])
);

endmodule
