`timescale 1ns / 1ps

// importer le package ascon pour obtenir la définition de type_state
import ascon_pack::*;

module Pl_tb(
//partie déclarative vide
);

  //déclaration des signaux
  type_state Pl_in_s;
  type_state Pl_out_s;

  //DUT : instanciation des composants
  Pl DUT (
    .Pl_in_i(Pl_in_s),
    .Pl_out_o(Pl_out_s)
  );

  //génération des stimuli
  initial begin
    Pl_in_s[0] = 64'h25f7c341c45f9912;
    Pl_in_s[1] = 64'h23b794c540876856;
    Pl_in_s[2] = 64'hb85451593d679610;
    Pl_in_s[3] = 64'h4fafba264a9e49ba;
    Pl_in_s[4] = 64'h62b54d5d460aded4;

  end

endmodule : Pl_tb
