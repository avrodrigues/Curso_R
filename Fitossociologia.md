Fitossociologia
================

### Os dados

Para abordar as análises mais comuns em fitossociologia vamos utilizar os dados de ocorrência de espécies da Floresta do Seu Nico em 2001 e em 2010 que resultaram do [Desafio da Aula 2](Desafio_2.md).

Para isso nomeie os resultados como `seu.nico.2001` e `seu.nico.2010`.

Ou baixe os dois arquivos (Aqui: [2001](Seu_nico_2001.csv) e [2010](Seu_nico_2010.csv)) e carregue com o código abaixo:

``` r
seu.nico.2001 <- read.csv2("Seu_nico_2001.csv")
seu.nico.2010 <- read.csv2("Seu_nico_2010.csv")

str(seu.nico.2001)
```

    ## 'data.frame':    2482 obs. of  4 variables:
    ##  $ X   : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ spp : Factor w/ 215 levels "","Alchornea glandulosa",..: 79 211 205 79 87 24 8 191 188 188 ...
    ##  $ parc: Factor w/ 100 levels "FSN_Plot_001",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ dap : num  0.2722 0.0891 0.0477 0.0462 0.2626 ...

``` r
str(seu.nico.2010)
```

    ## 'data.frame':    2529 obs. of  4 variables:
    ##  $ X   : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ spp : Factor w/ 213 levels "","Alchornea glandulosa",..: 80 209 202 80 87 24 8 189 186 113 ...
    ##  $ parc: Factor w/ 100 levels "FSN_Plot_001",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ dap : num  0.2885 0.0608 0.0503 0.0541 0.2723 ...

### O que faremos?

Primeiro vamos analizar o contexto geral das amostragens, verificando se há sulficiência amostral e estimando a riqueza total da área.

Num segundo momento, iremos dividir as comunidades de 2001 e 2010 em dois componentes: a regeneração e os adultos. Com base nesses conjuntos de dados construiremos a tabela fitossociológica, exploraremos a diversidade e similaridade taxonômica entre os componentes e os momentos no tempo.
