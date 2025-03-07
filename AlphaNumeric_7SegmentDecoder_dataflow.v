module numeric(n, num_out);
	input  [3:0]	n;
	output [6:0]	num_out;

	assign num_out[0] =	n==4'b0000 || n==4'b0010 || n==4'b0011 || n==4'b0101 ||
				n==4'b0110 || n==4'b0111 || n==4'b1000 || n==4'b1001 ||
				n==4'b1010 || n==4'b1110 
				? 1'b1 : 1'b0;

	assign num_out[1] =	n==4'b0000 || n==4'b0001 || n==4'b0010 || n==4'b0011 ||
				n==4'b0100 || n==4'b0111 || n==4'b1000 || n==4'b1001 ||
				n==4'b1010 || n==4'b1101 || n==4'b1110 
				? 1'b1 : 1'b0;

	assign num_out[2] =	n==4'b0000 || n==4'b0001 || n==4'b0010 || n==4'b0011 ||
				n==4'b0100 || n==4'b0101 || n==4'b0110 || n==4'b0111 ||
				n==4'b1000 || n==4'b1001 || n==4'b1010 || n==4'b1011 ||
				n==4'b1101
				? 1'b1 : 1'b0;

	assign num_out[3] =	n==4'b0000 || n==4'b0010 || n==4'b0011 || n==4'b0101 ||
				n==4'b0110 || n==4'b1000 || n==4'b1010 || n==4'b1011 ||
				n==4'b1100 || n==4'b1101 || n==4'b1101 || n==4'b1111
				? 1'b1 : 1'b0;

	assign num_out[4] =	n==4'b0000 || n==4'b0001 || n==4'b0010 || n==4'b0011 ||
				n==4'b0110 || n==4'b1000 || n==4'b1010 || n==4'b1011 ||
				n==4'b1100 || n==4'b1101 || n==4'b1101 || n==4'b1111
				? 1'b1 : 1'b0;

	assign num_out[5] =	n==4'b0000 || n==4'b0100 || n==4'b0101 || n==4'b0110 ||
				n==4'b1000 || n==4'b1001 || n==4'b1011 || n==4'b1100 || 
				n==4'b1101 || n==4'b1110
				? 1'b1 : 1'b0;

	assign num_out[6] =	n==4'b0010 || n==4'b0011 || n==4'b0100 || n==4'b0101 ||
				n==4'b0110 || n==4'b1000 || n==4'b1001 || n==4'b1010 ||
				n==4'b1011 || n==4'b1100 || n==4'b1101 || n==4'b1111
				? 1'b1 : 1'b0;
endmodule

module alpha(a, alp_out);
	input  [3:0]	a;
	output [6:0]	alp_out;
	
	assign alp_out[0] =	a==4'b0000 || a==4'b0010 || a==4'b0100 || a==4'b0101 || 
				a==4'b0110 || a==4'b1011 || a==4'b1100 || a==4'b1101 || 
				a==4'b1111
				? 1'b1 : 1'b0;

	assign alp_out[1] =	a==4'b0000 || a==4'b0011 || a==4'b0111 || a==4'b1000 || 
				a==4'b1001 || a==4'b1011 || a==4'b1100 || a==4'b1110 || 
				a==4'b1111
				? 1'b1 : 1'b0;

	assign alp_out[2] =	a==4'b0000 || a==4'b0001 || a==4'b0011 || a==4'b0110 || 
				a==4'b0111 || a==4'b1000 || a==4'b1001 || a==4'b1011 ||
				a==4'b1101 || a==4'b1110
				? 1'b1 : 1'b0;

	assign alp_out[3] =	a==4'b0010 || a==4'b0011 || a==4'b0100 || a==4'b0110 || 
				a==4'b0111 || a==4'b1001 || a==4'b1010 || a==4'b1011 ||
				a==4'b1101 || a==4'b1110
				? 1'b1 : 1'b0;

	assign alp_out[4] =	a==4'b0000 || a==4'b0001 || a==4'b0010 || a==4'b0011 ||
				a==4'b0100 || a==4'b0101 || a==4'b0110 || a==4'b0111 ||
				a==4'b1010 || a==4'b1011 || a==4'b1100 || a==4'b1110 || 
				a==4'b1111
				? 1'b1 : 1'b0;

	assign alp_out[5] =	a==4'b0000 || a==4'b0001 || a==4'b0010 || a==4'b0100 || 
				a==4'b0101 || a==4'b0110 || a==4'b0111 || a==4'b1010 || 
				a==4'b1011 || a==4'b1100 || a==4'b1101 || a==4'b1110
				? 1'b1 : 1'b0;

	assign alp_out[6] =	a==4'b0000 || a==4'b0001 || a==4'b0011 || a==4'b0100 || 
				a==4'b0101 || a==4'b0111 || a==4'b1100 || a==4'b1101 || 
				a==4'b1111
				? 1'b1 : 1'b0;
		
endmodule

module alphaNum7SegDec(mode, in, out);
	input  [1:0]	mode;
	input  [3:0]	in;
	output [6:0]	out;

	wire	[6:0]	out_a, out_n;

	alpha	mode_a(in, out_a);
	numeric	mode_n(in, out_n);

	assign 	out =	mode==2'b00 ? 0 :
			mode==2'b01 ? out_a :
			mode==2'b10 ? out_n :
			mode==2'b11 ? 1 : 0;

endmodule



module tb_alphaNum7SegDec;
	reg  [1:0]	mode;
	reg  [3:0]	in;
	wire [6:0]	out;

	alphaNum7SegDec	an7sd(mode, in, out);

	initial begin
		$display(" m1  m0  |  i3  i2  i1  i0  |  o6  o5  o4  o3  o2  o1  o0 ");
		$monitor("  %b   %b  |   %b   %b   %b   %b  |   %b   %b   %b   %b   %b   %b   %b ",
			mode[1], mode[0], in[3], in[2], in[1], in[0], out[6], out[5], out[4], out[3], out[2], out[1], out[0]);

		mode 	= 2'b00;	
		in 	= 4'b0000;

		$display("\n	Off mode\n");

	#10	in = 4'b0000;
	#10	in = 4'b0001;
	#10	in = 4'b0010;
	#10	in = 4'b0011;
	#10	in = 4'b0100;
	#10	in = 4'b0101;
	#10	in = 4'b0110;
	#10	in = 4'b0111;
	#10	in = 4'b1000;
	#10	in = 4'b1001;
	#10	in = 4'b1010;
	#10	in = 4'b1011;
	#10	in = 4'b1100;
	#10	in = 4'b1101;
	#10	in = 4'b1110;
	#10	in = 4'b1111;

	#10	mode 	= 2'b01;
		in	= 4'b0000;

		$display("\n	Alpha mode\n");

	#10	in = 4'b0000;
	#10	in = 4'b0001;
	#10	in = 4'b0010;
	#10	in = 4'b0011;
	#10	in = 4'b0100;
	#10	in = 4'b0101;
	#10	in = 4'b0110;
	#10	in = 4'b0111;
	#10	in = 4'b1000;
	#10	in = 4'b1001;
	#10	in = 4'b1010;
	#10	in = 4'b1011;
	#10	in = 4'b1100;
	#10	in = 4'b1101;
	#10	in = 4'b1110;
	#10	in = 4'b1111;

	#10	mode 	= 2'b10;
		in	= 4'b0000;

		$display("\n	Numeric mode\n");

	#10	in = 4'b0000;
	#10	in = 4'b0001;
	#10	in = 4'b0010;
	#10	in = 4'b0011;
	#10	in = 4'b0100;
	#10	in = 4'b0101;
	#10	in = 4'b0110;
	#10	in = 4'b0111;
	#10	in = 4'b1000;
	#10	in = 4'b1001;
	#10	in = 4'b1010;
	#10	in = 4'b1011;
	#10	in = 4'b1100;
	#10	in = 4'b1101;
	#10	in = 4'b1110;
	#10	in = 4'b1111;

	#10	mode 	= 2'b11;
		in	= 4'b0000;

		$display("\n	Light test mode\n");

	#10	in = 4'b0000;
	#10	in = 4'b0001;
	#10	in = 4'b0010;
	#10	in = 4'b0011;
	#10	in = 4'b0100;
	#10	in = 4'b0101;
	#10	in = 4'b0110;
	#10	in = 4'b0111;
	#10	in = 4'b1000;
	#10	in = 4'b1001;
	#10	in = 4'b1010;
	#10	in = 4'b1011;
	#10	in = 4'b1100;
	#10	in = 4'b1101;
	#10	in = 4'b1110;
	#10	in = 4'b1111;

	#20	mode	= 2'b00;
		in	= 4'b0000;

		$display("\nEnd");
		$finish;
	end	

endmodule
