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
my $numero_jogadores; #quantidade jogadores
my @jogador;#lista armazena nome dos jogadores;
my @letras;
my $tamanho_palavra;
my $contotal = 0;
my $i = 0;
my $palpite;
my $tamanho_palpite;
my $log_palpites = "";
my $indice;
my $relatorio;
my $vencedor;
my $flag = 0;

$numero_jogadores = &setNumeroDeJogadores;
@jogador = &iniciaJogadores($numero_jogadores);
$numero_de_palavras = &contaPalavras($arquivo);
$palavra_numero = int rand($numero_de_palavras) + 1;
$palavra_sorteada = &pegaPalavra($arquivo, $palavra_numero);
$tamanho_palavra = length $palavra_sorteada;
@letras = split("", $palavra_sorteada);

$relatorio = &imprimeSaida($tamanho_palavra);
print "A PALAVRA TEM ".$tamanho_palavra. " LETRAS\n";
print "\t\t\t\t".$relatorio."\n";

do{

  print "QUAL SEU PALPITE, ".$jogador[$i]."?"."\n";
  $palpite = uc(<STDIN>);
  chomp($palpite);
  $tamanho_palpite = length $palpite;

  if ($tamanho_palpite == $tamanho_palavra)
  {
    if($palpite eq $palavra_sorteada)
    {
      $vencedor = $jogador[$i];
      $flag = 1;
    }
  }elsif($tamanho_palpite == 1)
  {
    $indice = index($log_palpites, $palpite);
    $log_palpites .= $palpite;

      if($indice == -1)
        {
            $relatorio = &insereLetraPalavra($palpite, $palavra_sorteada, $relatorio);
              if($relatorio eq $palavra_sorteada){
                  $vencedor = $jogador[$i];
                  $flag = 1;
              }
        }else{print RED, "LETRA JA ESCOLHIDA\n", RESET;}

   }else {print RED, "APENAS UMA LETRA OU PALAVRA\n", RESET;}

  if ($flag == 0) {
    print "\t\t\t\t".$relatorio."\n\n";
  }

  $contotal++;
  $i = $contotal % $numero_jogadores;

}while($flag == 0);

print BLUE, $vencedor . " VENCEU!\n", RESET;
print BLUE, "A PALAVRA É ".$palavra_sorteada."\n", RESET;
sub insereLetraPalavra {
  my $letra = $_[0]; #palpite de uma letra
  my $sorte = $_[1]; #palavra sorteada
  my $aux = $_[2];
  my @lista_sorte = split("", $sorte);
  my @lista_aux = split("", $aux);
  my $saida = "";

  for (my $q = 0; $q < length $sorte; $q++) {
    if($letra eq $lista_sorte[$q])
    {
        $lista_aux[$q] = $letra;
    }
    $saida .= $lista_aux[$q];
  }

  return $saida;

}

sub imprimeSaida {
  my $num = $_[0];
  my $out;
  for (my $q = 0; $q < $num; $q++) {
    $out .= "#";
  }
  return $out;

}

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
