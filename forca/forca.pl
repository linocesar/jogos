#!/usr/bin/env perl

#jogo da forca

use strict;
use warnings;
use Switch;
use Term::ANSIColor qw(:constants);

my $arquivo = 'palavras.txt'; #$ARGV[0];
my $numero_de_palavras; #numero_de_palavras no arquivo.txt
my $palavra_numero; #numero da linha onde se encontra a palavra.
my $palavra_sorteada; #palavra
my $numero_jogadores;
my @jogador;




$numero_jogadores = &setNumeroDeJogadores;
@jogador = &iniciaJogadores($numero_jogadores);



sub setNumeroDeJogadores {
  my $numero;

  do{

    print "QUANTOS JOGADORES?: APENAS NÚMEROS\n";
    $numero = <STDIN>;
    chomp($numero);

    if ("'$numero'" =~/'[a-zA-Z]'/) {
      print RED "APENAS NUMEROS!!\n", RESET;
    }


  }while("'$numero'" =~/'[a-zA-Z]'/);

  return $numero;

}





$numero_de_palavras = &contaPalavras($arquivo);
$palavra_numero = int rand($numero_de_palavras) + 1;
$palavra_sorteada = &pegaPalavra($arquivo, $palavra_numero);
#print $numero_de_palavras."\n";
#print $palavra_numero."\n";
#print $palavra_sorteada."\n";
































sub contaPalavras {

  my $arq = $_[0];
  my $cont = 0;

  open(my $fh, '<', $arq) or die "Nao foi possivel abrir o arquivo '$arq' $!";

  while (my $linha = <$fh>) {
    chomp($linha);
    $cont++;
  }
  close($arq);
return $cont;

}

sub pegaPalavra {

  my $arq = $_[0];
  my $indice = $_[1];
  my $aux = 1;
  my $saida;

  open(my $fh, '<', $arquivo) or die "Nao foi possivel abrir o arquivo '$arquivo' $!";
    while (my $linha = <$fh>)
    {
      chomp($linha);
      if ($indice == $aux++)
      {
        $saida = $linha;
      }

    }
      close($arq);
    return $saida;

}

sub iniciaJogadores {
  my $nome;
  my $numero = $_[0];
  my @aux;
  for (my $cont = 0; $cont < $numero; $cont++) {

    print MAGENTA BOLD "JOGADOR ".($cont+1).", DIGITE SEU NOME:\n", RESET;
    chomp($nome = <STDIN>);
    $aux[$cont] = uc $nome;
  }

  return @aux;
}
