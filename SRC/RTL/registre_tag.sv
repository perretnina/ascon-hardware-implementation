// Import ascon package
import ascon_pack::*;

module registre_tag

(
	input  logic clock_i,
	input  logic resetb_i,
	input  logic enable_tag_i, //write enable
	input  type_state registre_i, //entrée = état courant
	input logic [127:0] memoire_tag_i, //mémoire de registre tag

	output logic[127:0] tag_o //sortie
);

always_ff @(posedge clock_i or negedge resetb_i) begin
        if (!resetb_i)
            tag_o <= {128'h0};
        else if (enable_tag_i)
            tag_o <= {registre_i[4],registre_i[3]}; //lignes 4 et 3 de l'état courant
	else
		tag_o <= memoire_tag_i; //mémoire 
    end
    
endmodule : registre_tag
