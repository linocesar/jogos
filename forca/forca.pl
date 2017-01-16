#!/usr/bin/env perl

#jogo da forca

use strict;
use warnings;
use Term::ANSIColor qw(:constants);

my $arquivo = 'palavras.txt'; #$ARGV[0];
my $numero_de_palavras; #numero_de_palavras no arquivo.txt
my $palavra_numero; #numero da linha onde se encontra a palavra.
my $palavra_sorteada; #palavra
my $numero_jogadores; #quantidade jogadores
my @jogador;#lista armazena nome dos jogadores;
my $tamanho_palavra;
my $palpite;
my $tamanho_palpite;
my $indice;
my $relatorio;
my %vencedores;
my $vencedor;
my $saindo;
my @lista_vencedores;
my $log_palpites;
my $flag;
my $contotal;
my $i;
my $numero_partidas = 0;


print YELLOW BOLD, "OLA! BEM-VINDO AO JOGO DA FORCA!\n", RESET;
sleep(1);
print YELLOW BOLD, "VAMOS COMECAR!\n\n", RESET;
sleep(1);

$numero_jogadores = &setNumeroDeJogadores;
@jogador = &iniciaJogadores($numero_jogadores);
$numero_de_palavras = &contaPalavras($arquivo);

foreach my $x (@jogador) {
  $vencedores{$x} = 0;
}

# Controla fluxo geral do jogo
do{

$log_palpites = "";
$saindo = "S";
$flag = 0;
$contotal = 0;
$i = 0;
$numero_partidas++;

print "\nESCOLHENDO PALAVRA...\n";
sleep(1);
print "PALAVRA ESCOLHIDA!\n\n\n";
sleep(1);

$palavra_numero = int rand($numero_de_palavras) + 1;
$palavra_sorteada = &pegaPalavra($arquivo, $palavra_numero);
$tamanho_palavra = length $palavra_sorteada;
$relatorio = &imprimeSaida($tamanho_palavra);

print "A PALAVRA TEM ".$tamanho_palavra. " LETRAS\n";
print YELLOW BOLD, "\t\t\t\t".$relatorio."\n", RESET;
sleep(1);

# Controla a lógica central do jogo.
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
        }else{print RED BOLD, "LETRA JA ESCOLHIDA\n", RESET;}

   }else {print RED BOLD, "APENAS UMA LETRA OU PALAVRA\n", RESET;}

  if ($flag == 0) {
    print YELLOW BOLD, "\t\t\t\t".$relatorio."\n\n", RESET;
  }

  $contotal++;
  $i = $contotal % $numero_jogadores;

}while($flag == 0);

$vencedores{$vencedor}++;

print YELLOW BOLD,"\n\n". $vencedor . " VENCEU!\n", RESET;
print YELLOW BOLD, "\t\t\t\t".$palavra_sorteada."\n", RESET;
sleep(1);

print "DESEJA CONTINUAR? S OU N\n";
$saindo = uc(<STDIN>);
chomp($saindo);

}while($saindo eq "S");

#ordenacao dos jogadores por numero de vitorias.
@lista_vencedores = sort {$vencedores{$b} <=> $vencedores{$a}} keys %vencedores;

print "\n";
foreach my $x (@lista_vencedores) {
  print "JOGADOR: ".$x."\tVENCEU ".$vencedores{$x}."\n";
}

print "\nTOTAL DE PARTIDAS: ".$numero_partidas."\n";

# Função
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

# Função
sub imprimeSaida {
  my $num = $_[0];
  my $out;
  for (my $q = 0; $q < $num; $q++) {
    $out .= "#";
  }
  return $out;

}

# Função
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

# Função
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

# Função
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

# Função
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
