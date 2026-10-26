`timescale 1ns / 1ps

//importer le package ascon pour obtenir la définition de type_state
import ascon_pack::*;

module Pc_tb(
//partie déclarative vide
);

//déclaration interne des signaux

type_state Pc_in_s;
logic [3:0] round_s;
type_state Pc_out_s;


//DUT : instanciation composant 

Pc DUT(
	.Pc_in_i(Pc_in_s),
	.round_i(round_s),
	.Pc_out_o(Pc_out_s)
	);

//génération stimuli

initial begin 
	Pc_in_s[0] = 64'h00001000808C0001;
	Pc_in_s[1] = 64'h6CB10AD9CA912F80;
	Pc_in_s[2] = 64'h691AED630E81901F;
	Pc_in_s[3] = 64'h0C4C36A20853217C;
	Pc_in_s[4] = 64'h46487B3E06D9D7A8;
	round_s = 0;
	
end

endmodule : Pc_tb
