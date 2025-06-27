module ALU ( input clock, input reset, input enable,
             input [7:0] operand_1,
             input [7:0] operand_2,
             input [1:0] alu_select,
				 input [2:0] core_state,
				 output reg [7:0] alu_out,
				 output reg [2:0] alu_nzp 
				 );
 reg signed [8:0] rs_minus_rt;

always @(posedge clock) begin
 if (reset) begin
 alu_out <= 8'b00000000;
 alu_nzp <= 3'b000;
 end
 else if (enable) begin
 if (core_state == 3'b101) begin
rs_minus_rt = $signed(operand_1) - $signed(operand_2);
            alu_nzp[2] = (rs_minus_rt > 0);  
            alu_nzp[1] = (rs_minus_rt == 0); 
            alu_nzp[0] = (rs_minus_rt < 0);  
            case (alu_select)
                2'b00: alu_out <= operand_1 + operand_2;
                2'b01: alu_out <= operand_1 - operand_2;
                2'b10: alu_out <= operand_1 & operand_2;
                2'b11: alu_out <= (operand_2 != 0) ? (operand_1 ^ operand_2) : 8'b00000000;
                default: alu_out <= 8'b00000000;
endcase
end
end
end
endmodule