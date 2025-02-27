
module fulladder4(
  input  logic [3:0] a_i,
  input  logic [3:0] b_i,
  input  logic       carry_i,
  output logic [3:0] sum_o,
  output logic       carry_o
);

    logic carry_to [3:1];

    fulladder fd0 (
        .a_i (a_i[0]),
        .b_i (b_i[0]),
        .carry_i (carry_i),
        .sum_o (sum_o [0]),
        .carry_o (carry_to [1])
    );
    
    fulladder fd1 (
        .a_i (a_i[1]),
        .b_i (b_i[1]),
        .carry_i (carry_to [1]),
        .sum_o (sum_o [1]),
        .carry_o (carry_to [2])
    );
    
    fulladder fd2 (
        .a_i (a_i[2]),
        .b_i (b_i[2]),
        .carry_i (carry_to [2]),
        .sum_o (sum_o [2]),
        .carry_o (carry_to [3])
    );
    
    fulladder fd3 (
        .a_i (a_i[3]),
        .b_i (b_i[3]),
        .carry_i (carry_to [3]),
        .sum_o (sum_o [3]),
        .carry_o (carry_o)
    );
endmodule
