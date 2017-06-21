Pacote `dplyr`
================

*Texto traduzido e adapado a partir do capítulo 13 do livro 'R Programming for Data Science' de Roger D. Peng que pode ser adquirido em <http://leanpub.com/rprogramming>*

O pacote `dplyr` contem ferramentas que facilitam ou tornam mais intuitivas a manipulação de data frames. A principal contribuição deste apcote é a implementação de uma "grámatica" para lidar com os dados. Podemos encarar as funções como verbos desta gramática. Com esta gramática, fica mais claro a comunicação do que está sendo feito com um data frame.

Gramática `dplyr`
-----------------

Alguns dos principais 'verbos' fornecidos pelo pacote são:

-   `select`: retorna um subconjunto de colunas de um data frame
-   `filter`: extrai um subconjunto de linhas de um data frame baseado em condições logicas
-   `arrange`: reordena as linhas de um data frame
-   `rename`: renomeia variaveis em um data frame
-   `mutate`: adiciona novas colunas/variáveis ou transforma variáveis existentes
-   `group_by`: agrupa valores com base em categorias
-   `summarise` / `summarize`: gera estatisticas resumidas de diferentes variaveis no data frame
-   `%>%`: O “pipe operator" (operador tubo, em tradução livre) é usada para conectar ações de multiplos verbos unidos em um 'pipeline'

Propriedades comuns as funções de `dplyr`
-----------------------------------------

Poucas caracteristicas são compartilhadas entre todas as funçõe deste pacote. Em particular:

1.  o primeiro argumento é um data frame
2.  os argumentos subsequentes descrevem o que deve ser feito com o data frame especificado no primeiro argumento
3.  o resultado é um novo data frame
4.  os data frames devem estar formatados de maneira organizada. Em suma, deve haver uma observação por linha e cada coluna deve representar uma caracteristica ou variável da observação

Instale e carregue o pacote `dplyr`
-----------------------------------

    install.packages("dplyr")

``` r
library(dplyr)
```

    ## Warning: Installed Rcpp (0.12.10) different from Rcpp used to build dplyr (0.12.11).
    ## Please reinstall dplyr to avoid random crashes or undefined behavior.

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Função `select`
---------------

Para exemplificar as funções disponíveis neste pacote utilizaremos dados morfológicos de plantas da Floresta Ombrófila Densa de Santa Catarina, que voce pode baixar neste [link](Tabela_de_medições.csv).

Baixe e importe os dados no R.

``` r
morfologia <- read.csv2("Tabela_de_medições.csv")
```

Você pode usar as funções `dim` e `str`para ver as caracteristicas do conjunto de dados.

``` r
dim(morfologia)
```

    ## [1] 545  14

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 1 2 2 2 2 3 3 3 4 4 ...
    ##  $ Amostra             : int  1 1 2 3 4 1 2 3 1 2 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 7 20 12 10 12 16 16 16 6 6 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 9 37 11 51 11 17 17 17 49 3 ...
    ##  $ Clorofila           : num  NA 57.9 NA 44.8 NA ...
    ##  $ Espessura           : num  0.076 0.09 0.212 0.246 0.216 0.124 0.087 0.07 0.158 0.112 ...
    ##  $ Massa.Foliar.Turgida: num  0.0039 1.48 1.766 6.248 4.23 ...
    ##  $ Area.Foliar         : num  0.284 80.163 71.573 212.229 177.073 ...
    ##  $ Massa.Para.Furar    : num  NA 225 172 230 199 ...
    ##  $ Massa.Foliar.seca   : num  0.00158 0.364 0.382 2.016 1.07 ...
    ##  $ Volume.Ramo         : num  2.51 1.22 1.36 3.2 2.99 2.46 2.62 3.4 3.4 1.94 ...
    ##  $ Massa.Seca.Ramo     : num  0.72 0.4 0.28 1.09 0.77 0.91 0.84 1.26 1.27 0.76 ...
    ##  $ Comprimento.Ramo    : num  NA 4.2 4.8 5 5.1 4.8 5.2 5.2 4.9 5.3 ...
    ##  $ Densidade.Vasos     : num  1.65 2.62 NA NA NA ...

A função `select` pode ser usada para selecionar as colunas do data frame que você deseja se focar. Suponhamos que desejamos trabalhar apenas com as 4 primeiras colunas. Podemos fazer isso de algumas maneiras, indicando apenas os numeros das colunas ou os nomes das colunas

``` r
names(morfologia)[1:4]
```

    ## [1] "Especie" "Amostra" "Local"   "Data"

``` r
selecionado <- select(morfologia, Especie:Data)
head(selecionado)
```

    ##                  Especie Amostra           Local       Data
    ## 1   Abarema langsdorffii       1        Ipiranga 08/08/2016
    ## 2 Aegiphila integrifolia       1       Spitzkopf 16/04/2016
    ## 3 Aegiphila integrifolia       2  Praia Vermelha 09/02/2017
    ## 4 Aegiphila integrifolia       3            PMSF 25/08/2016
    ## 5 Aegiphila integrifolia       4  Praia Vermelha 09/02/2017
    ## 6       Albizia edwallii       1 Santa Terezinha 11/05/2017

Note que `:` geralmete só pode ser usado para sequências numéricas, entretanto dentro da função `select` ele pode ser usado para especificar uma sequência de variáveis.

Podemos omitir variáveis com a função select() usando sinal de negativo:

``` r
select(morfologia, -(Especie:Data))
```

Também podemos selecionar colunas baseado em um padrões. Por exemplo, podemos selecionar as variáveis que terminam com `Ramo`

``` r
selecionado <- select(morfologia, ends_with("Ramo"))
str(selecionado)
```

    ## 'data.frame':    545 obs. of  3 variables:
    ##  $ Volume.Ramo     : num  2.51 1.22 1.36 3.2 2.99 2.46 2.62 3.4 3.4 1.94 ...
    ##  $ Massa.Seca.Ramo : num  0.72 0.4 0.28 1.09 0.77 0.91 0.84 1.26 1.27 0.76 ...
    ##  $ Comprimento.Ramo: num  NA 4.2 4.8 5 5.1 4.8 5.2 5.2 4.9 5.3 ...

Ou ainda, selecionar aquelas que começam com `M`.

``` r
selecionado <- select(morfologia, starts_with("M"))
str(selecionado)
```

    ## 'data.frame':    545 obs. of  4 variables:
    ##  $ Massa.Foliar.Turgida: num  0.0039 1.48 1.766 6.248 4.23 ...
    ##  $ Massa.Para.Furar    : num  NA 225 172 230 199 ...
    ##  $ Massa.Foliar.seca   : num  0.00158 0.364 0.382 2.016 1.07 ...
    ##  $ Massa.Seca.Ramo     : num  0.72 0.4 0.28 1.09 0.77 0.91 0.84 1.26 1.27 0.76 ...

Outras opções de espressões básicas voce pode encontrar em `?select`

Função `filter`
---------------

A função `filter` é utilizada para extrair um conjunto do linhas de um data frame.

Suponha que dejesamos filtrar `morfologia` as linhas de em que os valores de `Area.Foliar` sejam maiores que 100.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100)
str(morfo.f)
```

    ## 'data.frame':    71 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 2 2 4 4 4 4 5 5 5 5 ...
    ##  $ Amostra             : int  3 4 1 2 4 5 1 2 3 4 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 10 12 6 6 8 8 20 20 8 8 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 51 11 49 3 54 54 37 37 54 54 ...
    ##  $ Clorofila           : num  44.8 NA 44.7 48.3 42.1 ...
    ##  $ Espessura           : num  0.246 0.216 0.158 0.112 0.134 0.114 0.15 0.156 0.112 0.17 ...
    ##  $ Massa.Foliar.Turgida: num  6.25 4.23 1.6 1.76 1.86 ...
    ##  $ Area.Foliar         : num  212 177 168 111 132 ...
    ##  $ Massa.Para.Furar    : num  230 199 190 369 251 ...
    ##  $ Massa.Foliar.seca   : num  2.016 1.07 0.764 0.734 0.78 ...
    ##  $ Volume.Ramo         : num  3.2 2.99 3.4 1.94 4.06 8.5 1.76 1.46 5.71 4.3 ...
    ##  $ Massa.Seca.Ramo     : num  1.09 0.77 1.27 0.76 1.4 2.69 0.47 0.39 2.3 1.74 ...
    ##  $ Comprimento.Ramo    : num  5 5.1 4.9 5.3 4.9 5.1 5.4 5.5 5.2 4.8 ...
    ##  $ Densidade.Vasos     : num  NA NA 1.746 2.032 0.812 ...

Note que há apenas 71 linhas que atendem ao critério estabelecido. Confira a distribuição dos valores de `Area.Foliar`:

``` r
summary(morfo.f)
```

    ##                     Especie      Amostra                    Local   
    ##  Alchornea sidifolia    : 5   Min.   :1.000   FURB             :23  
    ##  Aparisthmium cordatum  : 5   1st Qu.:2.000   PMSF             :15  
    ##  Bathysa australis      : 5   Median :3.000   Braço Paula Ramos:13  
    ##  Cecropia glaziovii     : 5   Mean   :2.817   Massaranduba     : 8  
    ##  Ficus adhatodifolia    : 5   3rd Qu.:4.000   Ipiranga         : 5  
    ##  Hieronyma alchorneoides: 5   Max.   :5.000   Spitzkopf        : 3  
    ##  (Other)                :41                   (Other)          : 4  
    ##          Data      Clorofila       Espessura      Massa.Foliar.Turgida
    ##  09/06/2016:13   Min.   :41.96   Min.   :0.0700   Min.   : 1.294      
    ##  13/04/2016: 9   1st Qu.:49.68   1st Qu.:0.1500   1st Qu.: 3.029      
    ##  23/05/2016: 8   Median :54.47   Median :0.2080   Median : 4.454      
    ##  26/07/2016: 8   Mean   :54.96   Mean   :0.2159   Mean   :10.235      
    ##  02/05/2016: 7   3rd Qu.:59.95   3rd Qu.:0.2630   3rd Qu.: 7.369      
    ##  08/08/2016: 5   Max.   :77.50   Max.   :0.4500   Max.   :72.930      
    ##  (Other)   :21   NA's   :7                                            
    ##   Area.Foliar     Massa.Para.Furar  Massa.Foliar.seca  Volume.Ramo    
    ##  Min.   : 101.1   Min.   :  47.98   Min.   : 0.366    Min.   : 0.620  
    ##  1st Qu.: 132.9   1st Qu.: 201.06   1st Qu.: 1.023    1st Qu.: 1.940  
    ##  Median : 190.2   Median : 262.84   Median : 1.648    Median : 2.755  
    ##  Mean   : 497.0   Mean   : 348.82   Mean   : 3.029    Mean   : 3.886  
    ##  3rd Qu.: 302.0   3rd Qu.: 361.70   3rd Qu.: 2.647    3rd Qu.: 4.843  
    ##  Max.   :4255.6   Max.   :2275.92   Max.   :21.396    Max.   :15.720  
    ##                                                       NA's   :1       
    ##  Massa.Seca.Ramo Comprimento.Ramo Densidade.Vasos    
    ##  Min.   :0.270   Min.   :4.50     Min.   :0.000e+00  
    ##  1st Qu.:0.655   1st Qu.:5.00     1st Qu.:2.000e+00  
    ##  Median :0.920   Median :5.30     Median :4.000e+00  
    ##  Mean   :1.235   Mean   :5.31     Mean   :1.353e+08  
    ##  3rd Qu.:1.405   3rd Qu.:5.60     3rd Qu.:1.400e+01  
    ##  Max.   :6.780   Max.   :7.20     Max.   :2.163e+09  
    ##                  NA's   :1        NA's   :52

Podemos fazer filtragens mais complexas e adicionar mais condições a serem atendias. Por exemplo, podemos filtrar as linhas em `morfologia` que possuam `Area.Foliar` acima de 100 e `Massa.Foliar.Seca` abaixo de 1.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100 & Massa.Foliar.seca  < 1) 
str(morfo.f)
```

    ## 'data.frame':    17 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 4 4 4 4 6 10 15 49 50 56 ...
    ##  $ Amostra             : int  1 2 4 5 1 4 3 3 5 1 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 6 6 8 8 10 10 10 10 6 6 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 49 3 54 54 5 45 46 60 3 25 ...
    ##  $ Clorofila           : num  44.7 48.3 42.1 44.4 51.1 ...
    ##  $ Espessura           : num  0.158 0.112 0.134 0.114 0.304 0.15 0.11 0.094 0.202 0.24 ...
    ##  $ Massa.Foliar.Turgida: num  1.6 1.76 1.86 1.53 1.48 ...
    ##  $ Area.Foliar         : num  168 111 132 129 128 ...
    ##  $ Massa.Para.Furar    : num  190 369 251 345 144 ...
    ##  $ Massa.Foliar.seca   : num  0.764 0.734 0.78 0.65 0.62 0.808 0.922 0.632 0.988 0.862 ...
    ##  $ Volume.Ramo         : num  3.4 1.94 4.06 8.5 1.55 1.22 1.08 7.83 2.68 1.54 ...
    ##  $ Massa.Seca.Ramo     : num  1.27 0.76 1.4 2.69 0.4 0.7 0.35 1.3 0.56 0.8 ...
    ##  $ Comprimento.Ramo    : num  4.9 5.3 4.9 5.1 5.3 5.2 NA 5.6 5 5.5 ...
    ##  $ Densidade.Vasos     : num  1.746 2.032 0.812 1.79 NA ...

``` r
View(morfo.f)
```

Para filtar linhas com base em fatores a lógica é um pouco diferente. Para essa finalidade utilizamos o operador `%in%`. Por exemplo, queremos um data frame com apenas algumas espécies de `morfologia`. Antes criamos um vetor com as espécies (`spp`) que desejamos e então usamos o operador `%in%` dentro da função `filter` para estrair os valores de `Especie` em `morfologia` que estão em `spp`.

``` r
spp <- morfologia$Especie[c(23,68,256,269,500)]
spp
```

    ## [1] Alchornea triplinervia    Aspidosperma australe    
    ## [3] Hieronyma alchorneoides   Ilex dumosa              
    ## [5] Solanum sanctaecatharinae
    ## 117 Levels: Abarema langsdorffii ... Xylopia brasiliensis

``` r
morfo.f <- filter(morfologia, Especie %in% spp)
str(morfo.f)
```

    ## 'data.frame':    24 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 6 6 6 6 6 16 16 16 16 16 ...
    ##  $ Amostra             : int  1 2 3 4 5 1 2 3 4 5 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 10 6 10 10 10 20 6 10 10 10 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 5 49 12 12 12 37 49 6 8 27 ...
    ##  $ Clorofila           : num  51.1 51.4 44.9 58.8 45.1 ...
    ##  $ Espessura           : num  0.304 0.192 0.072 0.236 0.188 0.178 0.155 0.15 0.19 0.108 ...
    ##  $ Massa.Foliar.Turgida: num  1.48 1.35 NA 1.51 NA ...
    ##  $ Area.Foliar         : num  127.6 83.2 80.1 84.7 43.7 ...
    ##  $ Massa.Para.Furar    : num  144 256 125 315 433 ...
    ##  $ Massa.Foliar.seca   : num  0.62 0.548 0.292 0.674 0.414 0.076 0.054 0.096 0.092 0.078 ...
    ##  $ Volume.Ramo         : num  1.55 1.8 3.78 2.11 1.09 0.34 2.49 3.38 3.21 0.71 ...
    ##  $ Massa.Seca.Ramo     : num  0.4 0.69 1.14 0.75 0.48 0.28 1.4 1.88 1.77 0.46 ...
    ##  $ Comprimento.Ramo    : num  5.3 5.3 5.3 5.7 4.9 4.5 5.5 5.5 5.1 5.4 ...
    ##  $ Densidade.Vasos     : num  NA NA NA NA NA ...

``` r
View(morfo.f)
```

Função `arrange`
----------------

A função `arrange` é utilizada para ordenar o data frame com base nos valores de uma coluna, preservando a order correspondente das outras colunas.

Aqui podemos ordenar as observações por data de coleta. Assim, as primeiras linhas serão as mais antigas e as ultimas linhas serão as observações realizadas mais recentemente.

``` r
morfologia <- arrange(morfologia, Data)
```

Vamos conferir as primeiras e as ultimas linhas.

``` r
head(morfologia,3)
```

    ##                    Especie Amostra  Local       Data Clorofila Espessura
    ## 1 Diatenopteryx sorbifolia       1 Rodeio 01/03/2017        NA     0.048
    ## 2           Hovenia dulcis       4 Rodeio 01/03/2017        NA     0.120
    ## 3  Lonchocarpus campestris       4 Rodeio 01/03/2017        NA     0.154
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.seca
    ## 1                0.074       4.593            74.82             0.018
    ## 2                0.828      47.780            83.43             0.294
    ## 3                0.300      17.623           261.38             0.112
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo Densidade.Vasos
    ## 1        1.10            0.71              4.5              NA
    ## 2        1.71            0.88              5.6              NA
    ## 3        1.21            0.59              4.6              NA

``` r
tail(morfologia,3)
```

    ##              Especie Amostra Local       Data Clorofila Espessura
    ## 543   Euterpe edulis       4  PMSF 29/06/2016     62.70     0.620
    ## 544   Euterpe edulis       5  PMSF 29/06/2016     59.94     0.090
    ## 545 Ocotea aciphylla       3  PMSF 29/06/2016     46.16     0.188
    ##     Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.seca
    ## 543                1.094     80.3268           115.93             0.402
    ## 544                0.920     73.7684           186.22             0.390
    ## 545                0.492     22.8396           263.81             0.236
    ##     Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo Densidade.Vasos
    ## 543        4.24            0.85              5.4              NA
    ## 544        4.58            0.67              5.1              NA
    ## 545        1.45            0.84              5.4        6.054577

Perceba que apesar do R ter executado a função e não retornado erro o resultado não é o que desejávamos. Acontece que a coluna `Data` é um `fator` e o R entende esse tipo de dado como 'palavra' e não como dados temporais.

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 4 5 6 3 4 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 13 13 13 22 22 22 22 22 22 22 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 1 1 1 2 2 2 2 2 2 2 ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.048 0.12 0.154 0.0847 0.126 0.178 0.184 0.218 0.074 0.068 ...
    ##  $ Massa.Foliar.Turgida: num  0.074 0.828 0.3 NA 0.498 0.902 0.884 0.988 0.046 0.079 ...
    ##  $ Area.Foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ Massa.Para.Furar    : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ Massa.Foliar.seca   : num  0.018 0.294 0.112 0.244 0.184 0.378 0.368 0.438 0.022 0.032 ...
    ##  $ Volume.Ramo         : num  1.1 1.71 1.21 4.07 2.08 1.13 0.97 5.84 3.91 2.41 ...
    ##  $ Massa.Seca.Ramo     : num  0.71 0.88 0.59 0.65 1.07 0.82 0.67 3.36 0.79 0.65 ...
    ##  $ Comprimento.Ramo    : num  4.5 5.6 4.6 4.8 5.5 5.1 4.7 5.2 5.3 5.2 ...
    ##  $ Densidade.Vasos     : num  NA NA NA NA NA NA NA NA NA NA ...

Para corrigir esse problema devemos transformas a variável `Data` em um vetor de classe data, e aí o R será capaz de ordenar o data frame com base em uma variável de tempo.

Fazemos isso com a função `as.Date`. Nela informamos o vetor que deve ser tranformado e o formato em que a data está anotada.

``` r
morfologia$Data <- as.Date(morfologia$Data, format = "%d/%m/%Y")
str(morfologia)
```

    ## 'data.frame':    545 obs. of  14 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 4 5 6 3 4 ...
    ##  $ Local               : Factor w/ 22 levels "Botuverá","Braço Paula Ramos",..: 13 13 13 22 22 22 22 22 22 22 ...
    ##  $ Data                : Date, format: "2017-03-01" "2017-03-01" ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.048 0.12 0.154 0.0847 0.126 0.178 0.184 0.218 0.074 0.068 ...
    ##  $ Massa.Foliar.Turgida: num  0.074 0.828 0.3 NA 0.498 0.902 0.884 0.988 0.046 0.079 ...
    ##  $ Area.Foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ Massa.Para.Furar    : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ Massa.Foliar.seca   : num  0.018 0.294 0.112 0.244 0.184 0.378 0.368 0.438 0.022 0.032 ...
    ##  $ Volume.Ramo         : num  1.1 1.71 1.21 4.07 2.08 1.13 0.97 5.84 3.91 2.41 ...
    ##  $ Massa.Seca.Ramo     : num  0.71 0.88 0.59 0.65 1.07 0.82 0.67 3.36 0.79 0.65 ...
    ##  $ Comprimento.Ramo    : num  4.5 5.6 4.6 4.8 5.5 5.1 4.7 5.2 5.3 5.2 ...
    ##  $ Densidade.Vasos     : num  NA NA NA NA NA NA NA NA NA NA ...

Agora, reaplicamos a função `arrange` e conferimos o resultado

``` r
morfologia <- arrange(morfologia, Data)
```

Vamos conferir as primeiras e as ultimas linhas.

``` r
head(morfologia,3)
```

    ##                  Especie Amostra Local       Data Clorofila Espessura
    ## 1 Alchornea triplinervia       1  PMSF 2016-04-06     51.14     0.304
    ## 2  Cyathea corcovadensis       1  PMSF 2016-04-06     62.70     0.230
    ## 3       Myrcia splendens       1  PMSF 2016-04-06     46.70     0.110
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.seca
    ## 1                1.478     127.593           144.46             0.620
    ## 2                0.270      12.704           213.37             0.094
    ## 3                0.040       4.029           157.38             0.022
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo Densidade.Vasos
    ## 1        1.55            0.40              5.3              NA
    ## 2        7.64            1.37              8.9              NA
    ## 3        2.00            1.23              5.8              NA

``` r
tail(morfologia,3)
```

    ##                     Especie Amostra        Local       Data Clorofila
    ## 543    Myrcia catharinensis       5         FURB 2017-05-28        NA
    ## 544 Byrsonima ligustrifolia       4 Morro do Baú 2017-12-12        NA
    ## 545        Casearia obliqua       5 Morro do Baú 2017-12-12        NA
    ##     Espessura Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar
    ## 543     0.230                1.296          NA           474.87
    ## 544     0.232                0.910     41.9954           215.58
    ## 545     0.062                0.068      7.4492           128.91
    ##     Massa.Foliar.seca Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 543             0.452        1.87            1.13              5.4
    ## 544             0.380        1.77            0.80              5.3
    ## 545             0.022        1.20            0.75              5.6
    ##     Densidade.Vasos
    ## 543              NA
    ## 544              NA
    ## 545              NA

Para ordenar de forma decrescente utiliza-se a função `desc` dessa maneira

``` r
morfologia <- arrange(morfologia, desc(Massa.Foliar.Turgida))
head(select(morfologia, Especie, Massa.Foliar.Turgida))
```

    ##              Especie Massa.Foliar.Turgida
    ## 1 Cecropia glaziovii               72.930
    ## 2  Bathysa australis               63.325
    ## 3 Cecropia glaziovii               63.242
    ## 4 Cecropia glaziovii               63.064
    ## 5 Cecropia glaziovii               52.310
    ## 6  Bathysa australis               33.086

``` r
tail(select(morfologia, Especie, Massa.Foliar.Turgida))
```

    ##                    Especie Massa.Foliar.Turgida
    ## 540       Albizia edwallii               0.0014
    ## 541 Alchornea triplinervia                   NA
    ## 542 Alchornea triplinervia                   NA
    ## 543   Posoqueria latifolia                   NA
    ## 544      Ocotea silvestris                   NA
    ## 545       Alsophila setosa                   NA

Função `rename`
---------------

Renomear um variável em um data frame é algo surpreendentemente dificil de fazer no R. A função `rename` facilita essa operação

Aqui voce pode ver o nome das 5 primeira colunas de `morfologia`

``` r
names(morfologia)[1:5]
```

    ## [1] "Especie"   "Amostra"   "Local"     "Data"      "Clorofila"

Vamos alterar `Especie` para `Nome` e `Local` para `Localidade`.

``` r
morfologia <- rename(morfologia, Nome = Especie, Localidade = Local)
head(morfologia[,1:5], 3)
```

    ##                 Nome Amostra Localidade       Data Clorofila
    ## 1 Cecropia glaziovii       2       FURB 2016-04-13     54.92
    ## 2  Bathysa australis       2       PMSF 2016-05-23     51.32
    ## 3 Cecropia glaziovii       5       FURB 2016-04-13     59.88

A sintaxe dessa função é colocar o novo nome à esquerda do sinal de `=` e o nome antigo à direita de `=`.

Função `mutate`
---------------

A função `mutate` existe para calcular transformações das variáveis do data frame. Frequentemente utilizamos as variáveis em um data frame para criar novas variáveis e `mutate` pode facilitar esse tipo de operação.

Por exemplo, em `morfologia` possuimos valores de massa seca do ramo e também de volume do ramo coletado em cada observação. Podemos, então, criar uma nova coluna que possuirá a densidade do ramo de cada observação.

``` r
morfologia <- mutate(morfologia, Densidade.Ramo = Massa.Seca.Ramo / Volume.Ramo)
head(morfologia, 3)
```

    ##                 Nome Amostra Localidade       Data Clorofila Espessura
    ## 1 Cecropia glaziovii       2       FURB 2016-04-13     54.92     0.258
    ## 2  Bathysa australis       2       PMSF 2016-05-23     51.32     0.157
    ## 3 Cecropia glaziovii       5       FURB 2016-04-13     59.88     0.280
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.seca
    ## 1               72.930    4255.560           140.96            21.396
    ## 2               63.325    2435.640           236.04             8.235
    ## 3               63.242    3530.186            76.70            17.714
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo Densidade.Vasos
    ## 1        5.21            0.69              5.8              NA
    ## 2       15.72            2.71              5.9              NA
    ## 3        3.90            0.53              5.7              NA
    ##   Densidade.Ramo
    ## 1      0.1324376
    ## 2      0.1723919
    ## 3      0.1358974

Há outra função relacionada chamada `transmute` que funciona da mesma maneira que `mutate` mas retorna como resultado apenas as variáveis criadas.

``` r
head(transmute(morfologia, 
               Especie = Nome,
               Densidade.Ramo = Massa.Seca.Ramo / Volume.Ramo,
               Massa.Foliar.Por.Area = Massa.Foliar.seca / Area.Foliar))
```

    ##              Especie Densidade.Ramo Massa.Foliar.Por.Area
    ## 1 Cecropia glaziovii      0.1324376           0.005027775
    ## 2  Bathysa australis      0.1723919           0.003381041
    ## 3 Cecropia glaziovii      0.1358974           0.005017866
    ## 4 Cecropia glaziovii      0.1231733           0.006019084
    ## 5 Cecropia glaziovii      0.1368078           0.004476963
    ## 6  Bathysa australis      0.2173913           0.005490683

> Note que para manter a referencia de qual espécie pertence cada valor, criamos uma variável chamada `Espécie` que é identica a variável `Nome`.
