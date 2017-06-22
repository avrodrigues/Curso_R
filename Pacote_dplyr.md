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

    ## [1] 545  13

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 26 19 26 26 26 19 26 19 19 19 ...
    ##  $ Amostra             : int  2 2 5 1 3 1 4 4 3 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 5 9 5 5 5 9 5 9 9 9 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 25 46 25 25 25 46 25 6 46 27 ...
    ##  $ Clorofila           : num  54.9 51.3 59.9 51.9 61.3 ...
    ##  $ Espessura           : num  0.258 0.157 0.28 0.262 0.278 0.18 0.222 0.13 0.158 0.19 ...
    ##  $ Massa.Foliar.Turgida: num  72.9 63.3 63.2 63.1 52.3 ...
    ##  $ Area.Foliar         : num  4256 2436 3530 3303 2839 ...
    ##  $ Massa.Para.Furar    : num  141 236 76.7 168.2 123.3 ...
    ##  $ Massa.Foliar.Seca   : num  21.4 8.23 17.71 19.88 12.71 ...
    ##  $ Volume.Ramo         : num  5.21 15.72 3.9 4.79 3.07 ...
    ##  $ Massa.Seca.Ramo     : num  0.69 2.71 0.53 0.59 0.42 1.25 0.3 2.45 1.55 1.41 ...
    ##  $ Comprimento.Ramo    : num  5.8 5.9 5.7 5.7 4.8 5.5 5.2 5.5 5.6 5.3 ...

A função `select` pode ser usada para selecionar as colunas do data frame que você deseja se focar. Suponhamos que desejamos trabalhar apenas com as 4 primeiras colunas. Podemos fazer isso de algumas maneiras, indicando apenas os numeros das colunas ou os nomes das colunas

``` r
names(morfologia)[1:4]
```

    ## [1] "Especie" "Amostra" "Local"   "Data"

``` r
selecionado <- select(morfologia, Especie:Data)
head(selecionado)
```

    ##              Especie Amostra Local       Data
    ## 1 Cecropia glaziovii       2  FURB 13/04/2016
    ## 2  Bathysa australis       2  PMSF 23/05/2016
    ## 3 Cecropia glaziovii       5  FURB 13/04/2016
    ## 4 Cecropia glaziovii       1  FURB 13/04/2016
    ## 5 Cecropia glaziovii       3  FURB 13/04/2016
    ## 6  Bathysa australis       1  PMSF 23/05/2016

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
    ##  $ Volume.Ramo     : num  5.21 15.72 3.9 4.79 3.07 ...
    ##  $ Massa.Seca.Ramo : num  0.69 2.71 0.53 0.59 0.42 1.25 0.3 2.45 1.55 1.41 ...
    ##  $ Comprimento.Ramo: num  5.8 5.9 5.7 5.7 4.8 5.5 5.2 5.5 5.6 5.3 ...

Ou ainda, selecionar aquelas que começam com `M`.

``` r
selecionado <- select(morfologia, starts_with("M"))
str(selecionado)
```

    ## 'data.frame':    545 obs. of  4 variables:
    ##  $ Massa.Foliar.Turgida: num  72.9 63.3 63.2 63.1 52.3 ...
    ##  $ Massa.Para.Furar    : num  141 236 76.7 168.2 123.3 ...
    ##  $ Massa.Foliar.Seca   : num  21.4 8.23 17.71 19.88 12.71 ...
    ##  $ Massa.Seca.Ramo     : num  0.69 2.71 0.53 0.59 0.42 1.25 0.3 2.45 1.55 1.41 ...

Outras opções de espressões básicas voce pode encontrar em `?select`

Função `filter`
---------------

A função `filter` é utilizada para extrair um conjunto do linhas de um data frame.

Suponha que dejesamos filtrar `morfologia` as linhas de em que os valores de `Area.Foliar` sejam maiores que 100.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100)
str(morfo.f)
```

    ## 'data.frame':    71 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 26 19 26 26 26 19 26 19 19 19 ...
    ##  $ Amostra             : int  2 2 5 1 3 1 4 4 3 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 5 9 5 5 5 9 5 9 9 9 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 25 46 25 25 25 46 25 6 46 27 ...
    ##  $ Clorofila           : num  54.9 51.3 59.9 51.9 61.3 ...
    ##  $ Espessura           : num  0.258 0.157 0.28 0.262 0.278 0.18 0.222 0.13 0.158 0.19 ...
    ##  $ Massa.Foliar.Turgida: num  72.9 63.3 63.2 63.1 52.3 ...
    ##  $ Area.Foliar         : num  4256 2436 3530 3303 2839 ...
    ##  $ Massa.Para.Furar    : num  141 236 76.7 168.2 123.3 ...
    ##  $ Massa.Foliar.Seca   : num  21.4 8.23 17.71 19.88 12.71 ...
    ##  $ Volume.Ramo         : num  5.21 15.72 3.9 4.79 3.07 ...
    ##  $ Massa.Seca.Ramo     : num  0.69 2.71 0.53 0.59 0.42 1.25 0.3 2.45 1.55 1.41 ...
    ##  $ Comprimento.Ramo    : num  5.8 5.9 5.7 5.7 4.8 5.5 5.2 5.5 5.6 5.3 ...

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

Podemos fazer filtragens mais complexas e adicionar mais condições a serem atendias. Por exemplo, podemos filtrar as linhas em `morfologia` que possuam `Area.Foliar` acima de 100 e `Massa.Foliar.Seca` abaixo de 1.

``` r
morfo.f <- filter(morfologia, Area.Foliar > 100 & Massa.Foliar.Seca  < 1) 
str(morfo.f)
```

    ## 'data.frame':    17 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 106 50 106 65 15 106 56 56 106 4 ...
    ##  $ Amostra             : int  1 5 3 2 3 4 1 4 2 4 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 6 5 6 5 9 6 5 5 6 7 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 9 3 9 43 46 9 25 3 9 54 ...
    ##  $ Clorofila           : num  47.8 NA 49.6 50.6 53.9 ...
    ##  $ Espessura           : num  0.118 0.202 0.134 0.176 0.11 0.122 0.24 0.138 0.07 0.134 ...
    ##  $ Massa.Foliar.Turgida: num  4.14 3.53 3.26 2.83 2.57 ...
    ##  $ Area.Foliar         : num  204 159 190 114 215 ...
    ##  $ Massa.Para.Furar    : num  120.2 259 73.8 246.8 271 ...
    ##  $ Massa.Foliar.Seca   : num  0.984 0.988 0.62 0.986 0.922 0.53 0.862 0.942 0.366 0.78 ...
    ##  $ Volume.Ramo         : num  2.59 2.68 3.17 2.09 1.08 0.62 1.54 2.61 2.63 4.06 ...
    ##  $ Massa.Seca.Ramo     : num  0.98 0.56 1.13 0.66 0.35 0.48 0.8 1.44 0.96 1.4 ...
    ##  $ Comprimento.Ramo    : num  4.5 5 5.2 5.2 NA 5 5.5 5.6 5.1 4.9 ...

``` r
View(morfo.f)
```

Para filtar linhas com base em fatores a lógica é um pouco diferente. Para essa finalidade utilizamos o operador `%in%`. Por exemplo, queremos um data frame com apenas algumas espécies de `morfologia`. Antes criamos um vetor com as espécies (`spp`) que desejamos e então usamos o operador `%in%` dentro da função `filter` para estrair os valores de `Especie` em `morfologia` que estão em `spp`.

``` r
spp <- morfologia$Especie[c(23,68,256,269,500)]
spp
```

    ## [1] Hieronyma alchorneoides Hirtella hebeclada      Ocotea aciphylla       
    ## [4] Myrceugenia ovalifolia  Xylopia brasiliensis   
    ## 117 Levels: Abarema langsdorffii ... Xylopia brasiliensis

``` r
morfo.f <- filter(morfologia, Especie %in% spp)
str(morfo.f)
```

    ## 'data.frame':    25 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 55 55 55 55 55 56 56 56 56 56 ...
    ##  $ Amostra             : int  4 3 5 2 1 2 1 4 3 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 2 2 2 2 2 5 5 5 5 9 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 12 12 12 12 12 25 25 3 3 46 ...
    ##  $ Clorofila           : num  52.3 54 43.3 55.9 58.9 ...
    ##  $ Espessura           : num  0.238 0.264 0.246 0.314 0.242 0.27 0.24 0.138 0.349 0.104 ...
    ##  $ Massa.Foliar.Turgida: num  12.32 6.13 5.56 5.42 4.25 ...
    ##  $ Area.Foliar         : num  498 264 223 192 162 ...
    ##  $ Massa.Para.Furar    : num  203 281 219 297 250 ...
    ##  $ Massa.Foliar.Seca   : num  2.66 1.28 1.03 1.89 1.67 ...
    ##  $ Volume.Ramo         : num  4.17 1.21 1.3 1.83 2.19 1.42 1.54 2.61 5.23 2.05 ...
    ##  $ Massa.Seca.Ramo     : num  0.7 0.51 0.27 0.65 0.59 0.82 0.8 1.44 2.92 1.24 ...
    ##  $ Comprimento.Ramo    : num  5.5 5.1 5.3 5.3 5.3 5.5 5.5 5.6 5.5 5.3 ...

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
    ## 1           Hovenia dulcis       4 Rodeio 01/03/2017        NA     0.120
    ## 2  Lonchocarpus campestris       4 Rodeio 01/03/2017        NA     0.154
    ## 3 Diatenopteryx sorbifolia       1 Rodeio 01/03/2017        NA     0.048
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 1                0.828      47.780            83.43             0.294
    ## 2                0.300      17.623           261.38             0.112
    ## 3                0.074       4.593            74.82             0.018
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 1        1.71            0.88              5.6
    ## 2        1.21            0.59              4.6
    ## 3        1.10            0.71              4.5

``` r
tail(morfologia,3)
```

    ##                       Especie Amostra Local       Data Clorofila Espessura
    ## 543 Cryptocarya aschersoniana       4  PMSF 29/06/2016     62.32     0.172
    ## 544            Euterpe edulis       5  PMSF 29/06/2016     59.94     0.090
    ## 545          Ocotea aciphylla       3  PMSF 29/06/2016     46.16     0.188
    ##     Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 543                1.066          NA           338.89             0.456
    ## 544                0.920     73.7684           186.22             0.390
    ## 545                0.492     22.8396           263.81             0.236
    ##     Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 543        1.85            0.85              5.0
    ## 544        4.58            0.67              5.1
    ## 545        1.45            0.84              5.4

Perceba que apesar do R ter executado a função e não retornado erro o resultado não é o que desejávamos. Acontece que a coluna `Data` é um `fator` e o R entende esse tipo de dado como 'palavra' e não como dados temporais.

``` r
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 57 63 43 27 27 27 18 62 44 44 ...
    ##  $ Amostra             : int  4 4 1 6 4 5 3 2 4 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 11 11 11 18 18 18 18 18 18 18 ...
    ##  $ Data                : Factor w/ 60 levels "01/03/2017","02/03/2017",..: 1 1 1 2 2 2 2 2 2 2 ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.12 0.154 0.048 0.218 0.178 0.184 0.126 0.106 0.068 0.008 ...
    ##  $ Massa.Foliar.Turgida: num  0.828 0.3 0.074 0.988 0.902 0.884 0.498 0.086 0.079 0.056 ...
    ##  $ Area.Foliar         : num  47.78 17.62 4.59 37.25 44.15 ...
    ##  $ Massa.Para.Furar    : num  83.4 261.4 74.8 474.1 314.8 ...
    ##  $ Massa.Foliar.Seca   : num  0.294 0.112 0.018 0.438 0.378 0.368 0.184 0.054 0.032 0.024 ...
    ##  $ Volume.Ramo         : num  1.71 1.21 1.1 5.84 1.13 0.97 2.08 2.44 2.41 3.42 ...
    ##  $ Massa.Seca.Ramo     : num  0.88 0.59 0.71 3.36 0.82 0.67 1.07 0.88 0.65 0.52 ...
    ##  $ Comprimento.Ramo    : num  5.6 4.6 4.5 5.2 5.1 4.7 5.5 4.6 5.2 4.9 ...

Para corrigir esse problema devemos transformas a variável `Data` em um vetor de classe data, e aí o R será capaz de ordenar o data frame com base em uma variável de tempo.

Fazemos isso com a função `as.Date`. Nela informamos o vetor que deve ser tranformado e o formato em que a data está anotada.

``` r
morfologia$Data <- as.Date(morfologia$Data, format = "%d/%m/%Y")
str(morfologia)
```

    ## 'data.frame':    545 obs. of  13 variables:
    ##  $ Especie             : Factor w/ 117 levels "Abarema langsdorffii",..: 57 63 43 27 27 27 18 62 44 44 ...
    ##  $ Amostra             : int  4 4 1 6 4 5 3 2 4 5 ...
    ##  $ Local               : Factor w/ 18 levels "Botuverá","Braço Paula Ramos",..: 11 11 11 18 18 18 18 18 18 18 ...
    ##  $ Data                : Date, format: "2017-03-01" "2017-03-01" ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Espessura           : num  0.12 0.154 0.048 0.218 0.178 0.184 0.126 0.106 0.068 0.008 ...
    ##  $ Massa.Foliar.Turgida: num  0.828 0.3 0.074 0.988 0.902 0.884 0.498 0.086 0.079 0.056 ...
    ##  $ Area.Foliar         : num  47.78 17.62 4.59 37.25 44.15 ...
    ##  $ Massa.Para.Furar    : num  83.4 261.4 74.8 474.1 314.8 ...
    ##  $ Massa.Foliar.Seca   : num  0.294 0.112 0.018 0.438 0.378 0.368 0.184 0.054 0.032 0.024 ...
    ##  $ Volume.Ramo         : num  1.71 1.21 1.1 5.84 1.13 0.97 2.08 2.44 2.41 3.42 ...
    ##  $ Massa.Seca.Ramo     : num  0.88 0.59 0.71 3.36 0.82 0.67 1.07 0.88 0.65 0.52 ...
    ##  $ Comprimento.Ramo    : num  5.6 4.6 4.5 5.2 5.1 4.7 5.5 4.6 5.2 4.9 ...

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
    ## 2     Sloanea guianensis       3  PMSF 2016-04-06     49.00     0.200
    ## 3     Sloanea guianensis       2  PMSF 2016-04-06     60.10     0.190
    ##   Massa.Foliar.Turgida Area.Foliar Massa.Para.Furar Massa.Foliar.Seca
    ## 1                1.478    127.5930           144.46             0.620
    ## 2                1.120     89.5424           385.15             0.564
    ## 3                0.780     73.9412           332.95             0.380
    ##   Volume.Ramo Massa.Seca.Ramo Comprimento.Ramo
    ## 1        1.55            0.40              5.3
    ## 2        1.32            0.66              5.8
    ## 3        3.05            1.41              5.7

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

Renomear um variável em um data frame é algo surpreendentemente dificil de fazer no R. A função `rename` facilita essa operação

Aqui voce pode ver o nome das 5 primeira colunas de `morfologia`

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

> Note que para manter a referencia de qual espécie pertence cada valor, criamos uma variável chamada `Espécie` que é identica a variável `Nome`.

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

Este operador `%>%` é muito útil para gerar uma sequência de manipulações em um data frame. Você deve ter notado que toda vez que desejamos aplicar mais de uma função acabamos gerando uma sequencia oculta em funções que é dificil de ler.

    (terceiro(segundo(primeiro(x))))

Este encadeamento de funções não é a maneira natural de pensar uma sequência de operações. O `%>%` permite escrever de uma meneira mais lógica/intuitiva

    primeiro(x) %>% segundo %>% terceiro

Usando o `%>%` entre funções significa dizer 'pegue o data frame que resultou a operação anterior e aplique tal função'.

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

Note que informamos o data frame `morfologia` no inicio, mas depois não foi mais informado o primeiro argumento de `group_by`, `summarize`, e `head`. Acontece que quando usamos o `%>%` o primeiro argumeto é entendido como o resultado da operação anterior.

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
