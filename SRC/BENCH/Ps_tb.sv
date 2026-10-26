`timescale 1ns / 1ps

//importer le package ascon pour obtenir la définition de type_state
import ascon_pack::*;

module Ps_tb(
//partie déclarative vide
);

//déclaration interne 
type_state Ps_in_s;
type_state Ps_out_s;

//DUT : instanciation composant 

Ps DUT(
	.Ps_in_i(Ps_in_s),
	.Ps_out_o(Ps_out_s)
);

//génération stimuli

initial begin 
	Ps_in_s[0] = 64'h00001000808c0001;
	Ps_in_s[1] = 64'h6cb10ad9ca912f80;
	Ps_in_s[2] = 64'h691aed630e8190ef;
	Ps_in_s[3] = 64'h0c4c36a20853217c;
	Ps_in_s[4] = 64'h46487b3e06d9d7a8;
end

endmodule : Ps_tb

