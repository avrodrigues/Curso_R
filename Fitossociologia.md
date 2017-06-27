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

Sulficiência amostral
---------------------

Muitas das funções usadas em análises ecológicas estão disponíveis no pacote `vegan`, inclusive as que utilizaremos nesta seção.

Carregue o pacote `vegan`. Caso não tenha ele instalado no computador, instale e depois carregue o pacote.

    install.packages('vegan')

``` r
library(vegan)
```

    ## Loading required package: permute

    ## Loading required package: lattice

    ## This is vegan 2.4-2

Para atestar se a comunidade foi bem amostrada quanto ao número de espécies podemos gera um gráfico de curva de acúmulo de espécies (ou curva do coletor). No `vegan`, isso é implementado com a função `specaccum`.

``` r
str(specaccum)
```

    ## function (comm, method = "exact", permutations = 100, conditioned = TRUE, 
    ##     gamma = "jack1", w = NULL, subset, ...)

Focaremos nos dois primeiros argumentos desta função (veja a ajuda da função para mais detalhes - `?specaccum`):

-   `comm`: é uma matriz da comunidade com parcelas nas linhas e espécies nas colunas
-   `method`: possui cinco métodos `"collector"`, `"random"`, `"exact"`, `"coleman"`, `"rarefaction"`, `"exact"` encontra a riqueza de espécies esperada (média), `"coleman"` encontra a riqueza esperada de acordo com Coleman et al. 1982, e `"rarefaction"` que encontra a média acumuladada baseada no número de indivíduos ao invés de sítios.

Para criar uma matriz de espécies por parcelas utilizamos a função `table`.

``` r
floresta.2001 <- table(seu.nico.2001$parc, seu.nico.2001$spp)
floresta.2010 <- table(seu.nico.2010$parc, seu.nico.2010$spp)
```

Vamos gerar a curva de coletor para os dois anos

``` r
plot(specaccum(floresta.2001, "collector"), main = "2001")
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
plot(specaccum(floresta.2010, "collector"), main = "2010")
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-5-2.png)

Há um problema em usar este tipo de curva, é que dependendo da ordem em que você adicionas as parcelas no gráfico você pode induzir que a curva fique estável.

Uma solução para este problema é criar uma curva que aleatorize a ordem de inclusão das parcelas para gerar uma média da riqueza e um desvio padrão a cada parcela inclusa.

Para isso alteramos o argumento `method` para `"random"`

``` r
plot(specaccum(floresta.2001, "random", main = "2001"))
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
plot(specaccum(floresta.2010, "random", main = "2010"))
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-6-2.png)

Podemos ainda criar uma visualização mais interessante para os mesmos gráficos adicionando mais alguns argumentos à função `plot`

``` r
plot(specaccum(floresta.2001, "random"),main = "2001", col = "blue", ci.type = "polygon", ci.col = "orange")
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
plot(specaccum(floresta.2010, "random"),main = "2010", col = "blue", ci.type = "polygon", ci.col = "orange")
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-7-2.png)

Estimativa de riqueza de espécies
---------------------------------

Para ver qual a riqueza de espécies em cada ano de amostragem, basta contar quantas colunas o data frame possui.

``` r
ncol(floresta.2001)
```

    ## [1] 215

``` r
ncol(floresta.2010)
```

    ## [1] 213

Para ver quantas espécies temos em cada parcela a função `specnumber`

``` r
specnumber(floresta.2001)
```

    ## FSN_Plot_001 FSN_Plot_002 FSN_Plot_003 FSN_Plot_004 FSN_Plot_005 
    ##           16           17           15           17           10 
    ## FSN_Plot_006 FSN_Plot_007 FSN_Plot_008 FSN_Plot_009 FSN_Plot_010 
    ##           14           16           11           21           20 
    ## FSN_Plot_011 FSN_Plot_012 FSN_Plot_013 FSN_Plot_014 FSN_Plot_015 
    ##           22           18           15           22           13 
    ## FSN_Plot_016 FSN_Plot_017 FSN_Plot_018 FSN_Plot_019 FSN_Plot_020 
    ##           22           17           14           10           18 
    ## FSN_Plot_021 FSN_Plot_022 FSN_Plot_023 FSN_Plot_024 FSN_Plot_025 
    ##           14           20           17           17           17 
    ## FSN_Plot_026 FSN_Plot_027 FSN_Plot_028 FSN_Plot_029 FSN_Plot_030 
    ##           13           15           10           13           14 
    ## FSN_Plot_031 FSN_Plot_032 FSN_Plot_033 FSN_Plot_034 FSN_Plot_035 
    ##           14           18           22           23           26 
    ## FSN_Plot_036 FSN_Plot_037 FSN_Plot_038 FSN_Plot_039 FSN_Plot_040 
    ##           16           19           14           14           16 
    ## FSN_Plot_041 FSN_Plot_042 FSN_Plot_043 FSN_Plot_044 FSN_Plot_045 
    ##           18           15           18           22           18 
    ## FSN_Plot_046 FSN_Plot_047 FSN_Plot_048 FSN_Plot_049 FSN_Plot_050 
    ##           20           15           18           21           22 
    ## FSN_Plot_051 FSN_Plot_052 FSN_Plot_053 FSN_Plot_054 FSN_Plot_055 
    ##           16           24           20           24           16 
    ## FSN_Plot_056 FSN_Plot_057 FSN_Plot_058 FSN_Plot_059 FSN_Plot_060 
    ##           19           15           17           18           16 
    ## FSN_Plot_061 FSN_Plot_062 FSN_Plot_063 FSN_Plot_064 FSN_Plot_065 
    ##           23           18           21           17           15 
    ## FSN_Plot_066 FSN_Plot_067 FSN_Plot_068 FSN_Plot_069 FSN_Plot_070 
    ##           19           12           17           24           18 
    ## FSN_Plot_071 FSN_Plot_072 FSN_Plot_073 FSN_Plot_074 FSN_Plot_075 
    ##           24           24           24           19           29 
    ## FSN_Plot_076 FSN_Plot_077 FSN_Plot_078 FSN_Plot_079 FSN_Plot_080 
    ##           21           13           17           22           22 
    ## FSN_Plot_081 FSN_Plot_082 FSN_Plot_083 FSN_Plot_084 FSN_Plot_085 
    ##           18           21           18           19           22 
    ## FSN_Plot_086 FSN_Plot_087 FSN_Plot_088 FSN_Plot_089 FSN_Plot_090 
    ##           23           19           17           26           20 
    ## FSN_Plot_091 FSN_Plot_092 FSN_Plot_093 FSN_Plot_094 FSN_Plot_095 
    ##           19           23           18           28           24 
    ## FSN_Plot_096 FSN_Plot_097 FSN_Plot_098 FSN_Plot_099 FSN_Plot_100 
    ##           22           17           15           18           19

``` r
specnumber(floresta.2010)
```

    ## FSN_Plot_001 FSN_Plot_002 FSN_Plot_003 FSN_Plot_004 FSN_Plot_005 
    ##           17           18           14           16           10 
    ## FSN_Plot_006 FSN_Plot_007 FSN_Plot_008 FSN_Plot_009 FSN_Plot_010 
    ##           15           19           11           18           20 
    ## FSN_Plot_011 FSN_Plot_012 FSN_Plot_013 FSN_Plot_014 FSN_Plot_015 
    ##           22           18           16           19           17 
    ## FSN_Plot_016 FSN_Plot_017 FSN_Plot_018 FSN_Plot_019 FSN_Plot_020 
    ##           24           19           16           14           20 
    ## FSN_Plot_021 FSN_Plot_022 FSN_Plot_023 FSN_Plot_024 FSN_Plot_025 
    ##           14           19           17           14           19 
    ## FSN_Plot_026 FSN_Plot_027 FSN_Plot_028 FSN_Plot_029 FSN_Plot_030 
    ##           13           12           11           13           19 
    ## FSN_Plot_031 FSN_Plot_032 FSN_Plot_033 FSN_Plot_034 FSN_Plot_035 
    ##           11           19           20           24           23 
    ## FSN_Plot_036 FSN_Plot_037 FSN_Plot_038 FSN_Plot_039 FSN_Plot_040 
    ##           18           20           14           14           20 
    ## FSN_Plot_041 FSN_Plot_042 FSN_Plot_043 FSN_Plot_044 FSN_Plot_045 
    ##           19           17           18           23           17 
    ## FSN_Plot_046 FSN_Plot_047 FSN_Plot_048 FSN_Plot_049 FSN_Plot_050 
    ##           19           14           19           17           22 
    ## FSN_Plot_051 FSN_Plot_052 FSN_Plot_053 FSN_Plot_054 FSN_Plot_055 
    ##           17           21           23           22           18 
    ## FSN_Plot_056 FSN_Plot_057 FSN_Plot_058 FSN_Plot_059 FSN_Plot_060 
    ##           17           12           16           18           17 
    ## FSN_Plot_061 FSN_Plot_062 FSN_Plot_063 FSN_Plot_064 FSN_Plot_065 
    ##           21           19           22           19           18 
    ## FSN_Plot_066 FSN_Plot_067 FSN_Plot_068 FSN_Plot_069 FSN_Plot_070 
    ##           19           14           18           19           19 
    ## FSN_Plot_071 FSN_Plot_072 FSN_Plot_073 FSN_Plot_074 FSN_Plot_075 
    ##           22           22           26           19           28 
    ## FSN_Plot_076 FSN_Plot_077 FSN_Plot_078 FSN_Plot_079 FSN_Plot_080 
    ##           22           13           17           25           22 
    ## FSN_Plot_081 FSN_Plot_082 FSN_Plot_083 FSN_Plot_084 FSN_Plot_085 
    ##           17           23           20           17           23 
    ## FSN_Plot_086 FSN_Plot_087 FSN_Plot_088 FSN_Plot_089 FSN_Plot_090 
    ##           25           17           16           23           19 
    ## FSN_Plot_091 FSN_Plot_092 FSN_Plot_093 FSN_Plot_094 FSN_Plot_095 
    ##           18           23           20           31           24 
    ## FSN_Plot_096 FSN_Plot_097 FSN_Plot_098 FSN_Plot_099 FSN_Plot_100 
    ##           20           20           15           21           22

Para estimar quantas espécies as comunidades possuiam em 2001 e 2010 podemos usar duas funções diferentes `specpool` ou `poolaccum`.

A primeira função retorna apenas o número de espécies total estimado, enquanto com a função `poolaccum` podemos criar gráfico com modelos de acumulação com base em cada método de estimação.

Veja abaixo:

``` r
## Estimador de riqueza de espécies
pool2001 <- specpool(floresta.2001)
pool2010 <- specpool(floresta.2010)

pool2001
```

    ##     Species     chao  chao.se  jack1 jack1.se    jack2     boot  boot.se
    ## All     215 250.2054 12.53969 268.46 8.643229 281.6059 241.2845 5.254879
    ##       n
    ## All 100

``` r
pool2010
```

    ##     Species   chao  chao.se  jack1 jack1.se    jack2     boot  boot.se   n
    ## All     213 263.46 17.41318 270.42 9.408815 295.2467 239.7745 5.368732 100

``` r
## Modelos de Acumulação (estimadores)
pool <- poolaccum(floresta.2001)
summary(pool, display = "jack2") # mostra os valores estimados com jacknife2
```

    ## $jack2
    ##         N Jackknife 2      2.5%    97.5%   Std.Dev
    ##  [1,]   3    75.24667  55.57083  98.0875 11.030706
    ##  [2,]   4    95.56833  69.66875 116.3146 11.903774
    ##  [3,]   5   111.68400  86.04875 132.4975 12.821460
    ##  [4,]   6   123.22567  95.65417 145.4583 12.654028
    ##  [5,]   7   133.23786 103.03512 162.6565 14.836236
    ##  [6,]   8   141.33214 108.38438 168.9652 16.445705
    ##  [7,]   9   149.75750 118.43368 175.7476 15.666785
    ##  [8,]  10   154.89556 125.73528 184.6481 14.847785
    ##  [9,]  11   161.62636 128.32909 185.3686 14.975462
    ## [10,]  12   167.26273 132.61780 192.7449 15.923360
    ## [11,]  13   173.31962 136.54038 203.8537 16.649687
    ## [12,]  14   178.24566 143.97734 208.9379 17.064691
    ## [13,]  15   183.92557 150.26274 216.4988 17.060806
    ## [14,]  16   187.84258 157.35760 219.2317 16.933555
    ## [15,]  17   192.56710 163.48456 225.2083 17.245642
    ## [16,]  18   195.26405 164.87704 230.0927 16.852463
    ## [17,]  19   198.14307 168.43421 231.2251 16.599642
    ## [18,]  20   200.98089 175.31454 230.7836 16.037861
    ## [19,]  21   204.44300 175.06202 239.6621 17.088622
    ## [20,]  22   208.14597 174.83772 246.5019 18.014097
    ## [21,]  23   212.63759 181.17105 248.4168 17.708918
    ## [22,]  24   215.81509 183.80322 250.6479 18.045350
    ## [23,]  25   218.42867 186.12700 253.4791 17.539643
    ## [24,]  26   221.62897 192.20942 256.8032 16.735026
    ## [25,]  27   223.56214 194.99907 257.6846 15.844257
    ## [26,]  28   226.52450 195.95651 260.7808 16.979421
    ## [27,]  29   228.42192 196.79304 266.5331 17.533516
    ## [28,]  30   230.07252 198.31009 270.6548 17.610242
    ## [29,]  31   232.27029 199.65328 267.8796 18.578853
    ## [30,]  32   234.63626 201.08569 269.9784 17.831295
    ## [31,]  33   237.42071 202.76494 267.3683 16.797452
    ## [32,]  34   240.22193 205.66767 272.8077 16.898866
    ## [33,]  35   241.74620 207.79027 273.1680 17.134543
    ## [34,]  36   243.49067 211.85609 270.9846 17.009236
    ## [35,]  37   244.74589 210.76156 273.1015 17.741463
    ## [36,]  38   246.68385 211.23864 279.0130 17.237394
    ## [37,]  39   247.63487 215.70550 281.0239 17.249124
    ## [38,]  40   249.38881 215.32399 284.8013 18.276232
    ## [39,]  41   251.42709 216.74367 286.6604 18.415283
    ## [40,]  42   253.25697 220.02639 287.0330 18.072444
    ## [41,]  43   254.65847 218.22274 289.6712 18.612778
    ## [42,]  44   256.88857 221.96015 289.9726 17.836163
    ## [43,]  45   258.00125 217.73510 289.7098 18.217350
    ## [44,]  46   259.14829 222.07076 288.9579 17.332192
    ## [45,]  47   260.00317 230.93022 291.2819 17.280411
    ## [46,]  48   261.15723 229.29246 294.0554 16.980626
    ## [47,]  49   262.23875 228.89630 292.6702 17.400422
    ## [48,]  50   263.08472 229.09341 293.4464 17.183615
    ## [49,]  51   264.59378 234.49938 295.0655 16.918018
    ## [50,]  52   265.21920 237.13429 295.8306 16.451920
    ## [51,]  53   266.07689 236.15952 294.4588 16.252175
    ## [52,]  54   267.60065 238.49573 296.4519 15.944036
    ## [53,]  55   269.21109 240.51508 298.0417 15.463372
    ## [54,]  56   270.09907 239.18240 295.5567 16.007956
    ## [55,]  57   270.94883 238.15728 295.1222 16.248525
    ## [56,]  58   272.05564 240.73001 299.7690 16.439090
    ## [57,]  59   271.97357 242.00207 300.8236 16.219485
    ## [58,]  60   272.85662 244.06484 301.8192 15.343405
    ## [59,]  61   273.39374 244.78655 298.1925 14.595031
    ## [60,]  62   273.81551 245.30598 298.6297 14.201424
    ## [61,]  63   274.73360 244.25437 301.1382 14.510791
    ## [62,]  64   275.61035 247.62318 300.5964 14.664130
    ## [63,]  65   275.99595 248.18334 298.6439 14.151196
    ## [64,]  66   276.43725 247.86099 299.2470 14.284029
    ## [65,]  67   276.46447 248.06286 300.2472 14.148607
    ## [66,]  68   277.84465 250.84080 302.8874 13.791635
    ## [67,]  69   278.85278 251.92245 303.8317 13.734474
    ## [68,]  70   279.73252 252.91446 306.8888 14.022481
    ## [69,]  71   280.15855 249.84265 307.7687 13.914248
    ## [70,]  72   280.65778 250.44276 307.9223 13.583254
    ## [71,]  73   281.49045 255.75377 306.0793 13.285032
    ## [72,]  74   281.29155 256.92187 305.1886 12.758655
    ## [73,]  75   282.05999 257.33732 305.0625 13.035513
    ## [74,]  76   281.71961 258.39859 305.4831 12.761621
    ## [75,]  77   282.61022 257.47994 304.9234 12.578909
    ## [76,]  78   283.12128 258.98511 304.1278 12.444458
    ## [77,]  79   283.15468 256.98029 302.1334 12.125196
    ## [78,]  80   282.95026 258.94420 301.7612 11.353864
    ## [79,]  81   283.34239 259.58474 300.9973 11.185272
    ## [80,]  82   284.23630 261.98200 298.9374 10.731417
    ## [81,]  83   284.57890 262.52944 299.9655 10.977630
    ## [82,]  84   284.67809 264.54708 300.0304 10.495766
    ## [83,]  85   283.99928 263.15513 300.5466 10.602924
    ## [84,]  86   284.22071 263.66039 301.5222 10.390112
    ## [85,]  87   284.26509 265.08870 302.0059  9.919254
    ## [86,]  88   284.16232 266.11260 300.5660  9.327503
    ## [87,]  89   283.78398 268.57290 299.1224  8.809082
    ## [88,]  90   283.53228 267.07078 300.5715  8.527089
    ## [89,]  91   282.90686 267.12314 297.1746  8.275837
    ## [90,]  92   282.99125 269.08066 296.7858  7.781960
    ## [91,]  93   282.74384 269.67480 294.8093  7.415439
    ## [92,]  94   282.33422 268.76997 294.7835  7.022575
    ## [93,]  95   282.94599 271.66305 293.2712  6.014255
    ## [94,]  96   282.49187 272.65025 291.8942  5.337821
    ## [95,]  97   282.24475 272.73167 290.9316  4.941310
    ## [96,]  98   282.09594 273.68946 290.3999  4.129249
    ## [97,]  99   281.84610 277.63214 287.4808  2.656067
    ## [98,] 100   281.60586 281.60586 281.6059  0.000000
    ## 
    ## attr(,"class")
    ## [1] "summary.poolaccum"

``` r
plot(pool)
```

![](Fitossociologia_files/figure-markdown_github/unnamed-chunk-10-1.png)
