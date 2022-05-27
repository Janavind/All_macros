always @(*) begin
	if(active) begin
		_io_out_buf_  : assert(io_out       == buf_io_out);
	end

	if(!active) begin
		_io_out_z_    : assert(io_out       == `MPRJ_IO_PADS'b0);
	end
end

