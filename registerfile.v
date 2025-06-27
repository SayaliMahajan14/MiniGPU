module registerfile( input clock, input reset, input enable,
                     input [2:0] core_state,
							input reg_write_enable,
							input [7:0] alu_out,
							input [7:0] lsu_out,
							input [7:0] immediate,
							input [1:0]  reg_input_mux,
							input [3:0] rs_address,
							input [3:0] rt_address,
							input [3:0] rd_address,
							input [7:0] block_id,
							output reg [7:0] rs_data,
							output reg [7:0] rt_data);
integer i;
reg [7:0] registers [15:0] ;
always @(posedge clock) begin
if (reset) begin
  rs_data <= 0;
  rt_data <= 0;
  for (i=0; i<13;i=i+1) begin
   registers[i] <= 8'b00000000;
	end
  registers[13] <= 8'b00000000;
  registers[14] <= 8'b00000100;
  registers[15] <= 8'b00000000;
end
else if (enable) begin
  if (reg_write_enable) begin
  registers[13] <= block_id;
  if (core_state == 3'b011) begin
  rs_data <= registers[rs_address];
  rt_data <= registers[rt_address];
  end
  if (core_state == 3'b110) begin
  if (rd_address <13) begin
case(reg_input_mux)
2'b00:registers[rd_address] <= alu_out;
2'b01:registers[rd_address] <= lsu_out;
2'b10:registers[rd_address] <= immediate;
endcase
end
end
end
end
end
endmodule


