module adder(a, b, c, d, cout, a1, a0);
	input	a, b, c, d;
	output	cout, a1, a0;

	wire	ac0, abd, bcd;

	and	AA0(ac0, a, c);
	and	AA1(abd, a, b, d);
	and	AA2(bcd, b, c, d);
	or	AO0(cout, ac0, abd, bcd);	// cout

	wire	bd, ac1;

	and	AA3(bd, b, d);
	xor	AX0(ac1, a, c);
	xor	AX1(a1, bd, ac1);		// a1

	xor	AX2(a0, b, d);			// a0
endmodule



module subtractor(a, b, c, d, borrow, s1, s0);
	input	a, b, c, d;
	output	borrow, s1, s0;

	wire	na, nb;
	
	not	SN0(na, a);
	not	SN1(nb, b);

	wire	na_c, nb_cd, na_nb_d;

	and	SA0(na_c, na, c);
	and	SA1(nb_cd, nb, c, d);
	and	SA2(na_nb_d, na, nb, d);
	or	SO0(borrow, na_c, nb_cd, na_nb_d);	// borrow
	
	wire 	s1w0, s1w1;

	and	SA3(s1w0, nb, d);
	xor	SX0(s1w1, a, c);
	xor	SX1(s1, s1w0, s1w1);			// s1

	xor	SX2(s0, b, d);				// s0
endmodule



module multiplier(a, b, c, d, m3, m2, m1, m0);
	input	a, b, c, d;
	output	m3, m2, m1, m0;

	and	MA0(m3, a, b, c, d);		// m3

	wire	nbd;

	nand	MNA0(nbd, b, d);
	and	MA1(m2, nbd, a, c);		// m2

	wire	ad, bc;

	and	MA2(ad, a, d);
	and	MA3(bc, b, c);
	xor	MX0(m1, ad, bc);		// m1

	nand	MNA1(m0, nbd, nbd);		// m0
endmodule



module ALU_gatelevel(sel1, sel0, x1, x0, y1, y0, o3, o2, o1, o0);
	input	sel1, sel0, x1, x0, y1, y0;
	output	o3, o2, o1, o0;

	wire	ac, a1, a0, sb, s1, s0, m3, m2, m1, m0;

	adder		add(x1, x0, y1, y0, ac, a1, a0);
	subtractor	sub(x1, x0, y1, y0, sb, s1, s0);
	multiplier	mul(x1, x0, y1, y0, m3, m2, m1, m0);

	wire	nsel1, nsel0, eadd, esub, emul;

	not	NOT0(nsel1, sel1);
	not	NOT1(nsel0, sel0);
	and	AND0(eadd, nsel1, sel0);
	and	AND1(esub, sel1, nsel0);
	and	AND2(emul, sel1, sel0);

	wire	oac, oa1, oa0, osb, os1, os0, om3, om2, om1, om0ss;

	and	AND3(oac, eadd, ac);
	and	AND4(oa1, eadd, a1);
	and	AND5(oa0, eadd, a0);

	and	AND6(osb, esub, sb);
	and	AND7(os1, esub, s1);
	and	AND8(os0, esub, s0);

	and	AND9(om2, emul, m2);
	and	ANDA(om1, emul, m1);
	and	ANDB(om0, emul, m0);

	and	ANDC(o3, emul, m3);
	or	OR0(o2, oac, osb, om2);
	or	OR1(o1, oa1, os1, om1);
	or	OR2(o0, oa0, os0, om0);

endmodule



module tb_ALU_gatelevel;
	reg	sel1, sel0, x1, x0, y1, y0;
	wire	o3, o2, o1, o0;

	ALU_gatelevel	alu(sel1, sel0, x1, x0, y1, y0, o3, o2, o1, o0);

	initial begin
		$display(" sel1  sel0  |   x1  x0  y1  y0   |  o3  o2  o1  o0");
		$monitor("   %b     %b   |    %b   %b   %b   %b   |   %b   %b   %b   %b   ", 
			sel1, sel0, x1, x0, y1, y0, o3, o2, o1, o0);

		sel1 = 1'b0; sel0 = 1'b0;
		x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	
		$display("\n   No operation.\n");

	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;

	#20	sel1 = 1'b0; sel0 = 1'b1;
		x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;

		$display("\n   Add operation\n");

	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;

	#20	sel1 = 1'b1; sel0 = 1'b0;
		x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;

		$display("\n   Sub operation\n");

	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;

	#20	sel1 = 1'b1; sel0 = 1'b1;
		x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;

		$display("\n   Mul operation\n");

	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b0; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b0; y1 = 1'b1; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b0; y0 = 1'b1;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b0;
	#10	x1 = 1'b1; x0 = 1'b1; y1 = 1'b1; y0 = 1'b1;

	#20	sel1 = 1'b0; sel0 = 1'b0;
		x1 = 1'b0; x0 = 1'b0; y1 = 1'b0; y0 = 1'b0;

		$display("\nEnd");
		$finish;

	end
endmodule
