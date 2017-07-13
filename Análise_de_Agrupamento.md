Análise de Agrupamento
================

A análise de agrupamento pretende classificar objetos com base em descritores. Aqui o termo objeto não ser refere aos objetos do R e sim o que você pretende classificar.

Podemos, por exemplo, querer classificar sítios distintos de acordo com a composição de espécies. Assim, as espécies em uma parcela descrevem como é a parcela e, portanto, parcelas com espécies semelhantes são mais parecidas e podem ser colocadas dentro de um mesmo grupo.

Para analisarmos dados com o objetivo de classificar/agrupar necessitamos de uma matrix de dados onde as linhas são os objetos a serem classificados e as colunas os descritores desses objetos.

Basicamente, o agrupamento consiste em analisar quais objetos são mais parecidos com quais, baseado em alguma medida de distância entre os objetos. Para isso, criamos uma matriz de distâncias par a par entre os objetos. É sobre essa matrix que faremos o agrupamento dos objetos.

Existem muitos métodos para realizar esse tipo de analise que podem ser agrupadas em hierárquicas e não-hierarquicas. Aqui focaremos na contrução de dendrogramas a partir de métodos hierárquicos de agrupamento.

A análise então seguirá alguns passos:

1 - Criar uma matrix de distãncias 2 - Realizar o agrupamento por diferentes métodos 3 - Escolher o melhor método de agrupamento 4 - Definir a linha de corte do dendrograma 5 - Gerar um gráfico (dendrograma) que mostre os grupos identificados pela análise

Pacotes necessários
-------------------

Nesta seção utilizaremos funções dos pacotes `vegan` e `cluster`, carregue essas bibliotecas. Caso alguma delas não esteja instalada utilize a função `install.packages`

``` r
# Pacotes
library(vegan)
```

    ## Loading required package: permute

    ## Loading required package: lattice

    ## This is vegan 2.4-3

``` r
library(cluster)
```

Passo 1 - Criar uma matrix de distâncias
----------------------------------------

Neste exemplo iremos utilizar os dados de `dune` representando a vegetação de dunas holandesas com 30 espécies descrevendo 20 sítios.

Para calcular a matriz de distâncias entre os sítios utilizamos a função `vegdist` do pacote vegan.

``` r
data("dune")
spe <- dune

spe.euc <- vegdist(spe, method = "euclidean")
```

Passo 2 - Realizar o agrupamento por diferentes métodos
-------------------------------------------------------

Há diferentes métodos propostos na literatura para realizar uma analise de agrupamento e cada método tende a apresentar um resultado diferente.

``` r
# Single linkage
spe.euc.single <- hclust(spe.euc , method="single")
# Complete-linkage agglomerative clustering
spe.euc.complete <- hclust(spe.euc , method="complete")
# UPGMA agglomerative clustering
spe.euc.UPGMA <- hclust(spe.euc , method="average")
# Compute WPGMA 
spe.euc.WPGMA <- hclust(spe.euc , method="mcquitty")
# Compute WPGMC 
spe.euc.WPGMC <- hclust(spe.euc , method="median")
# Ward's minimum variance clustering
spe.euc.ward <- hclust(spe.euc, method="ward.D")

op <- par()

par(mfrow = c(2,3))

plot(spe.euc.single, hang = -1, cex = 0.9)
plot(spe.euc.complete, hang = -1, cex = 0.9)
plot(spe.euc.UPGMA, hang = -1, cex = 0.9)
plot(spe.euc.WPGMA, hang = -1, cex = 0.9)
plot(spe.euc.WPGMC, hang = -1, cex = 0.9)
plot(spe.euc.ward, hang = -1, cex = 0.9)
```

![](Análise_de_Agrupamento_files/figure-markdown_github/unnamed-chunk-3-1.png)
