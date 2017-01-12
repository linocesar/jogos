#!/usr/bin/env perl

#jogo da forca

use strict;
use warnings;

my $arquivo = 'palavras.txt'; #$ARGV[0];
my $numero_de_palavras;
my $palavra_numero;
my $palavra_sorteada;


$numero_de_palavras = &contaPalavras($arquivo);
print $numero_de_palavras."\n";
$palavra_numero = int rand($numero_de_palavras) + 1;
$palavra_sorteada = &pegaPalavra($arquivo, $palavra_numero);
print $palavra_numero."\n";
print $palavra_sorteada."\n";


sub contaPalavras {

  my $arq = $_[0];
  my $cont = 0;

  open(my $fh, '<:encoding(UTF-8)', $arq) or die "Nao foi possivel abrir o arquivo '$arq' $!";

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
