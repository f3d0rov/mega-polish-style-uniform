                                                   
module tb_fulladder();                                
    logic a, b, carry_i, carry_o, sum;             
                                                   
    fulladder DUT(                                 
        .a_i (a),                                  
        .b_i (b),                                  
        .carry_i (carry_i),
        .carry_o (carry_o),
        .sum_o (sum)                         
    );                                             
                                                   
    initial begin                                  
        a = 1'b0; b = 1'b0; carry_i = 1'b0;        
        #10                                        
        a = 1'b0; b = 1'b0; carry_i = 1'b1;        
        #10                                        
        a = 1'b0; b = 1'b1; carry_i = 1'b0;        
        #10                                        
        a = 1'b0; b = 1'b1; carry_i = 1'b1;        
        #10                                        
        a = 1'b1; b = 1'b0; carry_i = 1'b0;        
        #10                                        
        a = 1'b1; b = 1'b0; carry_i = 1'b1;        
        #10                                        
        a = 1'b1; b = 1'b1; carry_i = 1'b0;        
        #10                                        
        a = 1'b1; b = 1'b1; carry_i = 1'b1;      
        #10                                        
        $finish;
    end                                            
endmodule          
                                