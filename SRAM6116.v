module SRAM6116 (
	input		CS_b, WE_b, OE_b,
	input  [3:0]	data_in, address,
	output [3:0]	data_out
);
	
	reg [3:0]	RAM[0:15];

	assign data_out = (	CS_b==1'b1 ||
				WE_b==1'b1 ||
				OE_b==1'b1 ) ?
				4'bzzzz :
				RAM[address] ;
	
	always @ (negedge WE_b) begin
		if (CS_b==1'b0)
			RAM[address] <= data_in;
	end

endmodule

module tb_SRAM6116;
	reg		CS_b, WE_b, OE_b;
	reg  [3:0]	data_in, address;
	wire [3:0]	data_out;

	SRAM6116 ram(
		.CS_b(CS_b),
		.WE_b(WE_b),
		.OE_b(OE_b),
		.data_in(data_in),
		.address(address),
		.data_out(data_out)
	);

	integer i;

	initial begin
		CS_b=1'b1; WE_b=1'b1; OE_b=1'b1;
		data_in	= 4'b0000;
		address = 4'b0000;


		// Writing data
	#10;	CS_b=1'b0; WE_b=1'b0; OE_b=1'b1;

		data_in	= 4'b1100;
		address	= 4'b0000;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b0011;
		address = 4'b0001;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b1111;
		address = 4'b0010;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b1001;
		address = 4'b0011;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b1010;
		address = 4'b1111;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b0101;
		address = 4'b1110;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b0000;
		address = 4'b1101;
	#10;	WE_b=1'b1;

	#10;	WE_b=1'b0;
		data_in = 4'b0110;
		address = 4'b1100;


	#50;
	
		// Reading data
	#10;	CS_b=1'b0; WE_b=1'b0; OE_b=1'b0;

		for (i=0 ; i<16 ; i=i+1) begin
	#10;		address	= i;
		end


	#50;	

		// Disable RAM
	#10;	CS_b=1'b1; WE_b=1'b0; OE_b=1'b0;

		for (i=0 ; i<16 ; i=i+1) begin
	#10;		address = i;
		end


	#50;	$finish;

	end

endmodule

