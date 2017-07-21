Pacote `dplyr`
================

*Texto traduzido e adapado a partir do capítulo 13 do livro 'R Programming for Data Science' de Roger D. Peng que pode ser adquirido em <http://leanpub.com/rprogramming>*

O pacote `dplyr` contém ferramentas que facilitam ou tornam mais intuitiva a manipulação de data frames. A principal contribuição deste pacote é a implementação de uma "grámatica" para lidar com os dados. Podemos encarar as funções como verbos desta gramática. Com esta gramática, fica mais clara a comunicação do que está sendo feito com o data frame.

Gramática `dplyr`
-----------------

Alguns dos principais 'verbos' fornecidos pelo pacote são:

-   `select`: retorna um subconjunto de colunas de um data frame
-   `filter`: extrai um subconjunto de linhas de um data frame baseado em condições lógicas
-   `arrange`: reordena as linhas de um data frame
-   `rename`: renomeia variáveis em um data frame
-   `mutate`: adiciona novas colunas/variáveis ou transforma variáveis existentes
-   `group_by`: agrupa valores com base em categorias
-   `summarise` / `summarize`: gera estatísticas resumidas de diferentes variáveis no data frame
-   `%>%`: O “pipe operator" (operador tubo, em tradução livre) é usado para conectar ações de múltiplos verbos unidos em um 'pipeline'

Propriedades comuns as funções de `dplyr`
-----------------------------------------

Poucas características são compartilhadas entre todas as funções deste pacote. Em particular:

1.  O primeiro argumento é um data frame
2.  Os argumentos subsequentes descrevem o que deve ser feito com o data frame especificado no primeiro argumento
3.  O resultado é um novo data frame
4.  Os data frames devem estar formatados de maneira organizada. Em suma, deve haver uma observação por linha e cada coluna deve representar uma característica ou variável da observação

Instale e carregue o pacote `dplyr`
-----------------------------------

    install.packages("dplyr")

``` r
library(dplyr)
```

    ## Warning: Installed Rcpp (0.12.10) different from Rcpp used to build dplyr (0.12.12).
    ## Please reinstall dplyr to avoid random crashes or undefined behavior.

Função `select`
---------------

Para exemplificar as funções disponíveis neste pacote utilizaremos dados morfológicos de plantas da Floresta Ombrófila Densa de Santa Catarina, que você pode baixar neste [link](Tabela_de_medições.csv).

Baixe e importe os dados no R.

``` r
morfologia <- read.csv2("Tabela_de_medições.csv")
```

Você pode usar as funções `dim` e `str`para ver as características do conjunto de dados.

``` r
dim(morfologia)
```

    ## [1] 545  13

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 1 2 2 2 2 3 3 3 4 4 ...
    ##  $ Amostra             : int  1 3 4 2 1 1 2 3 3 4 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 6 9 10 10 16 13 13 13 5 7 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 9 51 11 11 37 17 17 17 3 54 ...
    ##  $ Clorofila           : num  NA 44.8 NA NA 57.9 ...
    ##  $ Espessura           : num  0.076 0.246 0.216 0.212 0.09 0.124 0.087 0.07 0.126 0.134 ...
    ##  $ Massa.Foliar.Turgida: num  0.0039 6.248 4.23 1.766 1.48 ...
    ##  $ Area.Foliar         : num  0.284 212.229 177.073 71.573 80.163 ...
    ##  $ Massa.Para.Furar    : num  NA 230 199 172 225 ...
    ##  $ Massa.Foliar.Seca   : num  0.00158 2.016 1.07 0.382 0.364 ...
    ##  $ Volume.Ramo         : num  2.51 3.2 2.99 1.36 1.22 2.46 2.62 3.4 1.8 4.06 ...
    ##  $ Massa.Seca.Ramo     : num  0.72 1.09 0.77 0.28 0.4 0.91 0.84 1.26 0.66 1.4 ...
    ##  $ Comprimento.Ramo    : num  NA 5 5.1 4.8 4.2 4.8 5.2 5.2 5.6 4.9 ...

A função `select` pode ser usada para selecionar as colunas do data frame em que você deseja se focar. Suponhamos que desejamos trabalhar apenas com as 4 primeiras colunas. Podemos fazer isso de algumas maneiras, indicando apenas os números das colunas ou os nomes das colunas

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
    ## 2 Aegiphila integrifolia       3            PMSF 25/08/2016
    ## 3 Aegiphila integrifolia       4  Praia Vermelha 09/02/2017
    ## 4 Aegiphila integrifolia       2  Praia Vermelha 09/02/2017
    ## 5 Aegiphila integrifolia       1       Spitzkopf 16/04/2016
    ## 6       Albizia edwallii       1 Santa Terezinha 11/05/2017

Note que `:` geralmente só pode ser usado para sequências numéricas, entretanto dentro da função `select` ele pode ser usado para especificar uma sequência de variáveis.

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
    ##  $ Volume.Ramo     : num  2.51 3.2 2.99 1.36 1.22 2.46 2.62 3.4 1.8 4.06 ...
    ##  $ Massa.Seca.Ramo : num  0.72 1.09 0.77 0.28 0.4 0.91 0.84 1.26 0.66 1.4 ...
    ##  $ Comprimento.Ramo: num  NA 5 5.1 4.8 4.2 4.8 5.2 5.2 5.6 4.9 ...

Ou ainda, selecionar aquelas que começam com `M`.

``` r
selecionado <- select(morfologia, starts_with("M"))
str(selecionado)
```

    ## 'data.frame':    545 obs. of  4 variables:
    ##  $ Massa.Foliar.Turgida: num  0.0039 6.248 4.23 1.766 1.48 ...
    ##  $ Massa.Para.Furar    : num  NA 230 199 172 225 ...
    ##  $ Massa.Foliar.Seca   : num  0.00158 2.016 1.07 0.382 0.364 ...
    ##  $ Massa.Seca.Ramo     : num  0.72 1.09 0.77 0.28 0.4 0.91 0.84 1.26 0.66 1.4 ...

Outras opções de expressões básicas você pode encontrar em `?select`

Função `filter`
---------------

A função `filter` é utilizada para extrair um conjunto do linhas de um data frame.

Suponha que dejesamos filtrar `morfologia` as linhas em que os valores de `Area.Foliar` sejam maiores que 100.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100)
str(morfo.f)
```

    ## 'data.frame':    71 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 2 2 4 4 4 4 5 5 5 5 ...
    ##  $ Amostra             : int  3 4 4 2 1 5 5 1 3 2 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 9 10 7 5 5 7 7 16 7 16 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 51 11 54 3 49 54 54 37 54 37 ...
    ##  $ Clorofila           : num  44.8 NA 42.1 48.3 44.7 ...
    ##  $ Espessura           : num  0.246 0.216 0.134 0.112 0.158 0.114 0.184 0.15 0.112 0.156 ...
    ##  $ Massa.Foliar.Turgida: num  6.25 4.23 1.86 1.76 1.6 ...
    ##  $ Area.Foliar         : num  212 177 132 111 168 ...
    ##  $ Massa.Para.Furar    : num  230 199 251 369 190 ...
    ##  $ Massa.Foliar.Seca   : num  2.016 1.07 0.78 0.734 0.764 ...
    ##  $ Volume.Ramo         : num  3.2 2.99 4.06 1.94 3.4 8.5 6.04 1.76 5.71 1.46 ...
    ##  $ Massa.Seca.Ramo     : num  1.09 0.77 1.4 0.76 1.27 2.69 1.72 0.47 2.3 0.39 ...
    ##  $ Comprimento.Ramo    : num  5 5.1 4.9 5.3 4.9 5.1 5.3 5.4 5.2 5.5 ...

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
    ##   Area.Foliar     Massa.Para.Furar  Massa.Foliar.Seca  Volume.Ramo    
    ##  Min.   : 101.1   Min.   :  47.98   Min.   : 0.366    Min.   : 0.620  
    ##  1st Qu.: 132.9   1st Qu.: 201.06   1st Qu.: 1.023    1st Qu.: 1.940  
    ##  Median : 190.2   Median : 262.84   Median : 1.648    Median : 2.755  
    ##  Mean   : 497.0   Mean   : 348.82   Mean   : 3.029    Mean   : 3.886  
    ##  3rd Qu.: 302.0   3rd Qu.: 361.70   3rd Qu.: 2.647    3rd Qu.: 4.843  
    ##  Max.   :4255.6   Max.   :2275.92   Max.   :21.396    Max.   :15.720  
    ##                                                       NA's   :1       
    ##  Massa.Seca.Ramo Comprimento.Ramo
    ##  Min.   :0.270   Min.   :4.50    
    ##  1st Qu.:0.655   1st Qu.:5.00    
    ##  Median :0.920   Median :5.30    
    ##  Mean   :1.235   Mean   :5.31    
    ##  3rd Qu.:1.405   3rd Qu.:5.60    
    ##  Max.   :6.780   Max.   :7.20    
    ##                  NA's   :1

Podemos fazer filtragens mais complexas e adicionar mais condições a serem atendidas. Por exemplo, podemos filtrar as linhas em `morfologia` que possuam `Area.Foliar` acima de 100 e `Massa.Foliar.Seca` abaixo de 1.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100 & Massa.Foliar.Seca  < 1) 
str(morfo.f)
```

    ## 'data.frame':    17 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 4 4 4 4 6 10 15 49 50 56 ...
    ##  $ Amostra             : int  4 2 1 5 1 4 3 3 5 1 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 7 5 5 7 9 9 9 9 5 5 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 54 3 49 54 5 45 46 60 3 25 ...
    ##  $ Clorofila           : num  42.1 48.3 44.7 44.4 51.1 ...
    ##  $ Espessura           : num  0.134 0.112 0.158 0.114 0.304 0.15 0.11 0.094 0.202 0.24 ...
    ##  $ Massa.Foliar.Turgida: num  1.86 1.76 1.6 1.53 1.48 ...
    ##  $ Area.Foliar         : num  132 111 168 129 128 ...
    ##  $ Massa.Para.Furar    : num  251 369 190 345 144 ...
    ##  $ Massa.Foliar.Seca   : num  0.78 0.734 0.764 0.65 0.62 0.808 0.922 0.632 0.988 0.862 ...
    ##  $ Volume.Ramo         : num  4.06 1.94 3.4 8.5 1.55 1.22 1.08 7.83 2.68 1.54 ...
    ##  $ Massa.Seca.Ramo     : num  1.4 0.76 1.27 2.69 0.4 0.7 0.35 1.3 0.56 0.8 ...
    ##  $ Comprimento.Ramo    : num  4.9 5.3 4.9 5.1 5.3 5.2 NA 5.6 5 5.5 ...

``` r
View(morfo.f)
```

Para filtar linhas com base em fatores a lógica é um pouco diferente. Para essa finalidade utilizamos o operador `%in%`. Por exemplo, queremos um data frame com apenas algumas espécies de `morfologia`. Antes criamos um vetor com as espécies (`spp`) que desejamos e então usamos o operador `%in%` dentro da função `filter` para extrair os valores de `Especie` em `morfologia` que estão em `spp`.

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

    ## 'data.frame':    24 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 6 6 6 6 6 16 16 16 16 16 ...
    ##  $ Amostra             : int  4 1 2 3 5 3 4 5 1 6 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 9 9 5 9 9 9 9 9 16 10 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 12 5 49 12 12 6 8 27 37 11 ...
    ##  $ Clorofila           : num  58.8 51.1 51.4 44.9 45.1 ...
    ##  $ Espessura           : num  0.236 0.304 0.192 0.072 0.188 0.15 0.19 0.108 0.178 0.122 ...
    ##  $ Massa.Foliar.Turgida: num  1.51 1.48 1.35 NA NA ...
    ##  $ Area.Foliar         : num  84.7 127.6 83.2 80.1 43.7 ...
    ##  $ Massa.Para.Furar    : num  315 144 256 125 433 ...
    ##  $ Massa.Foliar.Seca   : num  0.674 0.62 0.548 0.292 0.414 0.096 0.092 0.078 0.076 0.068 ...
    ##  $ Volume.Ramo         : num  2.11 1.55 1.8 3.78 1.09 3.38 3.21 0.71 0.34 0.43 ...
    ##  $ Massa.Seca.Ramo     : num  0.75 0.4 0.69 1.14 0.48 1.88 1.77 0.46 0.28 0.29 ...
    ##  $ Comprimento.Ramo    : num  5.7 5.3 5.3 5.3 4.9 5.5 5.1 5.4 4.5 4.7 ...

``` r
View(morfo.f)
```

Função `arrange`
----------------

A função `arrange` é utilizada para ordenar o data frame com base nos valores de uma coluna, preservando a ordem correspondente das outras colunas.

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
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 1                0.074       4.593            74.82             0.018
    ## 2                0.828      47.780            83.43             0.294
    ## 3                0.300      17.623           261.38             0.112
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 1        1.10            0.71              4.5
    ## 2        1.71            0.88              5.6
    ## 3        1.21            0.59              4.6

``` r
tail(morfologia,3)
```

    ##              Especie Amostra Local       Data Clorofila Espessura
    ## 543   Euterpe edulis       4  PMSF 29/06/2016     62.70     0.620
    ## 544   Euterpe edulis       5  PMSF 29/06/2016     59.94     0.090
    ## 545 Ocotea aciphylla       3  PMSF 29/06/2016     46.16     0.188
    ##     Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 543                1.094     80.3268           115.93             0.402
    ## 544                0.920     73.7684           186.22             0.390
    ## 545                0.492     22.8396           263.81             0.236
    ##     Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 543        4.24            0.85              5.4
    ## 544        4.58            0.67              5.1
    ## 545        1.45            0.84              5.4

Perceba que apesar do R ter executado a função e não retornado erro o resultado não é o que desejávamos. Acontece que a coluna `Data` é um `fator` e o R entende esse tipo de dado como 'palavra' e não como dados temporais.

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 6 4 5 4 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 11 11 11 18 18 18 18 18 18 18 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 1 1 1 2 2 2 2 2 2 2 ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.048 0.12 0.154 0.0847 0.126 0.218 0.178 0.184 0.068 0.008 ...
    ##  $ Massa.Foliar.Turgida: num  0.074 0.828 0.3 NA 0.498 0.988 0.902 0.884 0.079 0.056 ...
    ##  $ Area.Foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ Massa.Para.Furar    : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ Massa.Foliar.Seca   : num  0.018 0.294 0.112 0.244 0.184 0.438 0.378 0.368 0.032 0.024 ...
    ##  $ Volume.Ramo         : num  1.1 1.71 1.21 4.07 2.08 5.84 1.13 0.97 2.41 3.42 ...
    ##  $ Massa.Seca.Ramo     : num  0.71 0.88 0.59 0.65 1.07 3.36 0.82 0.67 0.65 0.52 ...
    ##  $ Comprimento.Ramo    : num  4.5 5.6 4.6 4.8 5.5 5.2 5.1 4.7 5.2 4.9 ...

Para corrigir esse problema devemos transformas a variável `Data` em um vetor de classe data, e aí o R será capaz de ordenar o data frame com base em uma variável de tempo.

Fazemos isso com a função `as.Date`. Nela informamos o vetor que deve ser tranformado e o formato em que a data está anotada.

``` r
morfologia$Data <- as.Date(morfologia$Data, format = "%d/%m/%Y")
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 6 4 5 4 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 11 11 11 18 18 18 18 18 18 18 ...
    ##  $ Data                : Date, format: "2017-03-01" "2017-03-01" ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.048 0.12 0.154 0.0847 0.126 0.218 0.178 0.184 0.068 0.008 ...
    ##  $ Massa.Foliar.Turgida: num  0.074 0.828 0.3 NA 0.498 0.988 0.902 0.884 0.079 0.056 ...
    ##  $ Area.Foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ Massa.Para.Furar    : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ Massa.Foliar.Seca   : num  0.018 0.294 0.112 0.244 0.184 0.438 0.378 0.368 0.032 0.024 ...
    ##  $ Volume.Ramo         : num  1.1 1.71 1.21 4.07 2.08 5.84 1.13 0.97 2.41 3.42 ...
    ##  $ Massa.Seca.Ramo     : num  0.71 0.88 0.59 0.65 1.07 3.36 0.82 0.67 0.65 0.52 ...
    ##  $ Comprimento.Ramo    : num  4.5 5.6 4.6 4.8 5.5 5.2 5.1 4.7 5.2 4.9 ...

Agora, reaplicamos a função `arrange` e conferimos o resultado

``` r
morfologia <- arrange(morfologia, Data)
```

Vamos conferir as primeiras e as últimas linhas.

``` r
head(morfologia,3)
```

    ##                  Especie Amostra Local       Data Clorofila Espessura
    ## 1 Alchornea triplinervia       1  PMSF 2016-04-06     51.14     0.304
    ## 2  Cyathea corcovadensis       1  PMSF 2016-04-06     62.70     0.230
    ## 3       Myrcia splendens       1  PMSF 2016-04-06     46.70     0.110
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 1                1.478     127.593           144.46             0.620
    ## 2                0.270      12.704           213.37             0.094
    ## 3                0.040       4.029           157.38             0.022
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 1        1.55            0.40              5.3
    ## 2        7.64            1.37              8.9
    ## 3        2.00            1.23              5.8

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
    ##     Massa.Foliar.Seca Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 543             0.452        1.87            1.13              5.4
    ## 544             0.380        1.77            0.80              5.3
    ## 545             0.022        1.20            0.75              5.6

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

Renomear uma variável em um data frame é algo surpreendentemente difícil de fazer no R. A função `rename` facilita essa operação

Aqui você pode ver o nome das 5 primeira colunas de `morfologia`

``` r
names(morfologia)[1:5]
```

    ## [1] "Especie"   "Amostra"   "Local"     "Data"      "Clorofila"

Vamos alterar `Especie` para `Nome` e `Local` para `Localidade`.

``` r
morfologia <- rename(morfologia, Nome.Cientifico = Especie, Localidade = Local)
head(morfologia[,1:5], 3)
```

    ##      Nome.Cientifico Amostra Localidade       Data Clorofila
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

    ##      Nome.Cientifico Amostra Localidade       Data Clorofila Espessura
    ## 1 Cecropia glaziovii       2       FURB 2016-04-13     54.92     0.258
    ## 2  Bathysa australis       2       PMSF 2016-05-23     51.32     0.157
    ## 3 Cecropia glaziovii       5       FURB 2016-04-13     59.88     0.280
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 1               72.930    4255.560           140.96            21.396
    ## 2               63.325    2435.640           236.04             8.235
    ## 3               63.242    3530.186            76.70            17.714
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo Densidade.Ramo
    ## 1        5.21            0.69              5.8      0.1324376
    ## 2       15.72            2.71              5.9      0.1723919
    ## 3        3.90            0.53              5.7      0.1358974

Há outra função relacionada chamada `transmute` que funciona da mesma maneira que `mutate` mas retorna como resultado apenas as variáveis criadas.

``` r
head(transmute(morfologia, 
               Especie = Nome.Cientifico,
               Densidade.Ramo = Massa.Seca.Ramo / Volume.Ramo,
               Massa.Foliar.Por.Area = Massa.Foliar.Seca / Area.Foliar))
```

    ##              Especie Densidade.Ramo Massa.Foliar.Por.Area
    ## 1 Cecropia glaziovii      0.1324376           0.005027775
    ## 2  Bathysa australis      0.1723919           0.003381041
    ## 3 Cecropia glaziovii      0.1358974           0.005017866
    ## 4 Cecropia glaziovii      0.1231733           0.006019084
    ## 5 Cecropia glaziovii      0.1368078           0.004476963
    ## 6  Bathysa australis      0.2173913           0.005490683

> Note que para manter a referência de qual espécie pertence cada valor, criamos uma variável chamada `Espécie` que é idêntica à variável `Nome`.

Função `group_by`
-----------------

Esta função é utilizada para gerar resumos estatíticos de um data frame baseados em um agrupamento dentro de uma variável. Por exemplo, nos dados `morfologia` há repetições de observações para cada espécie, podemos querer conhecer a média de massa foliar seca em cada espécie. A função `group_by` é frequentemente utilizada em conjunto com a função `summarize`.

A operação básica é uma combinação de 'quebra' do data frame em diferentes partes definida por uma variável ou um grupo de variáveis (`gruoup_by`) e então aplica-se a função de resumo (`summarize`) a cada subconjunto.

``` r
grupo <- group_by(morfologia, Nome.Cientifico)
massa.media <- summarise(grupo, 
                         Media.Massa.foliar.Seca =  mean(Massa.Foliar.Seca, na.rm = TRUE))
head(massa.media)
```

    ## # A tibble: 6 x 2
    ##          Nome.Cientifico Media.Massa.foliar.Seca
    ##                   <fctr>                   <dbl>
    ## 1   Abarema langsdorffii             0.001580000
    ## 2 Aegiphila integrifolia             0.958000000
    ## 3       Albizia edwallii             0.003033333
    ## 4   Alchornea glandulosa             0.774800000
    ## 5    Alchornea sidifolia             1.682000000
    ## 6 Alchornea triplinervia             0.509600000

Operador pipeline `%>%`
-----------------------

Este operador `%>%` é muito útil para gerar uma sequência de manipulações em um data frame. Você deve ter notado que toda vez que desejamos aplicar mais de uma função acabamos gerando uma sequência oculta em funções que é dificil de ler.

    (terceiro(segundo(primeiro(x))))

Este encadeamento de funções não é a maneira natural de pensar uma sequência de operações. O `%>%` permite escrever de uma meneira mais lógica/intuitiva

    primeiro(x) %>% segundo %>% terceiro

Usando o `%>%` entre funções significa dizer 'pegue o data frame que resultou da operação anterior e aplique tal função'.

Para exemplificar a utilização do *pipeline* vamos obter a média por espécie das variáveis clorofila e Espessura. Assim temos que:

1.  Separar/agrupar o data frame por espécie (`group_by`)
2.  Calcular a média de `Clorofila` e `Espessura` para as espécies (`summarize`)

``` r
morfologia %>%
  group_by(Nome.Cientifico) %>%
  summarize(Clorofila = mean(Clorofila, na.rm = TRUE),
            Espessura = mean(Espessura, na.rm = TRUE)) %>%
  head(6)
```

    ## # A tibble: 6 x 3
    ##          Nome.Cientifico Clorofila  Espessura
    ##                   <fctr>     <dbl>      <dbl>
    ## 1   Abarema langsdorffii       NaN 0.07600000
    ## 2 Aegiphila integrifolia    51.340 0.19100000
    ## 3       Albizia edwallii       NaN 0.09366667
    ## 4   Alchornea glandulosa    44.895 0.12880000
    ## 5    Alchornea sidifolia    49.128 0.15440000
    ## 6 Alchornea triplinervia    50.256 0.19840000

Dessa maneira não há necessidade de criarmos objetos temporários (como o objeto `grupo` criado na seção anterior)

Note que informamos o data frame `morfologia` no início, mas depois não foi mais informado o primeiro argumento de `group_by`, `summarize`, e `head`. Acontece que quando usamos o `%>%` o primeiro argumeto é entendido como o resultado da operação anterior.

Para dar outro exemplo da utilização do `%>%` vamos resumir as informações com base na localidade da coleta. Então agrupamos `morfologia` por `Localidade` e então computamos a média das variáveis `Massa.Foliar.Seca` e `Massa.Foliar.Turgida`, para este exemplo. O resultado final será assinalado ao objeto `massa.foliar`

``` r
massa.foliar <- morfologia %>%
  group_by(Localidade) %>%
  summarize(Massa.Foliar.seca = mean(Massa.Foliar.Seca, na.rm = TRUE),
            Massa.Foliar.Turgida =  mean(Massa.Foliar.Turgida, na.rm = TRUE))

massa.foliar
```

    ## # A tibble: 18 x 3
    ##             Localidade Massa.Foliar.seca Massa.Foliar.Turgida
    ##                 <fctr>             <dbl>                <dbl>
    ##  1            Botuverá         0.1198864            0.3044545
    ##  2   Braço Paula Ramos         1.0000333            2.6749318
    ##  3            Curitiba         0.1390000            0.2760000
    ##  4     Faxinal do Bepe         0.3664000            0.8510000
    ##  5                FURB         1.2696667            4.0884255
    ##  6            Ipiranga         0.3911516            1.1393980
    ##  7        Massaranduba         0.7984667            2.1046667
    ##  8        Morro do Baú         0.1601290            0.4703226
    ##  9                PMSF         0.6879684            2.7565217
    ## 10      Praia Vermelha         0.3460000            1.2418750
    ## 11              Rodeio         0.1413333            0.4006667
    ## 12 Rua Bahia, Blumenau         0.5346000            1.2298000
    ## 13     Santa Terezinha         0.1849095            0.4169095
    ## 14     Serra da Abelha         0.2380000            0.5820000
    ## 15       Serra da Leoa         0.1747742            0.4796129
    ## 16           Spitzkopf         0.4399259            1.1617778
    ## 17            Tirolesa         0.2811667            0.9663333
    ## 18              UA 803         0.1550000            0.3291538

> Para ter certeza que cada passo está trazendo o resultado esperado inclua uma função de cada vez, confira o resultado e então adicione outro `%>%`. Quando toda a sequência de operações tiver sido conferida você assinala (`<-`) o resultado a um objeto.
