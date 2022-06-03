always @(*) begin
	if (active) begin				//If active, the buffered outputs are passed to the actual io_pins
	`ifdef USE_LA
		_la1_data_buf_: assert(la1_data_out == buf_la1_data_out);
	`endif
	`ifdef USE_IO
		_io_out_buf_  : assert(io_out       == buf_io_out);
	        _io_oeb_buf_  : assert(io_oeb       == buf_io_oeb);
	`endif
	end
else
	if (!active) begin
	`ifdef USE_LA
		_la1_data_z_  : assert(la1_data_out == 32'b0);
	`endif
	`ifdef USE_IO
	        _io_out_z_    : assert(io_out       == `MPRJ_IO_PADS'b0);
	        _io_oeb_z_    : assert(io_oeb       == `MPRJ_IO_PADS'b0);
	`endif
	end
end

