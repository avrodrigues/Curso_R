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

Função `select`
---------------

Para exemplificar as funções disponíveis neste pacote utilizaremos dados morfológicos de plantas da Floresta Ombrófila Densa de Santa Catarina, que você pode baixar neste [link](tabela_de_medições.csv).

Baixe e importe os dados no R.

``` r
morfologia <- read.csv2("Tabela_de_medições.csv")
```

Você pode usar as funções `dim` e `str`para ver as características do conjunto de dados.

``` r
dim(morfologia)
```

    ## [1] 544  14

``` r
str(morfologia)
```

    ## 'data.frame':    544 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 1 1 2 2 2 2 3 3 3 4 ...
    ##  $ Amostra             : int  2 1 3 1 4 2 3 1 2 2 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 8 9 14 26 16 16 20 20 20 7 ...
    ##  $ Data                : Factor w/ 51 levels "01/03/2017","02/03/2017",..: 51 9 42 32 11 11 17 17 17 3 ...
    ##  $ Clorofila           : num  NA NA 44.8 57.9 NA ...
    ##  $ espessura.foliar    : num  0.162 0.076 0.246 0.09 0.216 0.212 0.07 0.124 0.087 0.112 ...
    ##  $ massa.turgida.foliar: num  0.00647 0.0039 6.248 1.48 4.23 ...
    ##  $ area.foliar         : num  0.242 0.284 212.229 80.163 177.073 ...
    ##  $ massa.para.furar.g. : num  NA NA 230 225 199 ...
    ##  $ massa.seca.foliar   : num  0.00281 0.00158 2.016 0.364 1.07 ...
    ##  $ volume.ramo         : num  0.7 2.51 3.2 1.22 2.99 1.36 3.4 2.46 2.62 1.94 ...
    ##  $ peso.seco.ramo      : num  0.46 0.72 1.09 0.4 0.77 0.28 1.26 0.91 0.84 0.76 ...
    ##  $ comprimento.ramo    : num  5.8 NA 5 4.2 5.1 4.8 5.2 4.8 5.2 5.3 ...
    ##  $ densidade.vasos     : num  NA 1.65 NA 2.62 4.65 ...

A função `select` pode ser usada para selecionar as colunas do data frame em que você deseja se focar. Suponhamos que desejamos trabalhar apenas com as 4 primeiras colunas. Podemos fazer isso de algumas maneiras, indicando apenas os números das colunas ou os nomes das colunas

``` r
names(morfologia)[1:4]
```

    ## [1] "Espécie" "Amostra" "Local"   "Data"

``` r
selecionado <- select(morfologia, Espécie:Data)
head(selecionado)
```

    ##                  Espécie Amostra          Local       Data
    ## 1   Abarema langsdorffii       2    Gaspar alto 30/06/2017
    ## 2   Abarema langsdorffii       1       Ipiranga 08/08/2016
    ## 3 Aegiphila integrifolia       3           PMSF 25/08/2016
    ## 4 Aegiphila integrifolia       1          Spitz 16/04/2016
    ## 5 Aegiphila integrifolia       4 Praia Vermelha 09/02/2017
    ## 6 Aegiphila integrifolia       2 Praia Vermelha 09/02/2017

Note que `:` geralmente só pode ser usado para sequências numéricas, entretanto dentro da função `select` ele pode ser usado para especificar uma sequência de variáveis.

Podemos omitir variáveis com a função `select` usando sinal de negativo:

``` r
select(morfologia, -(Espécie:Data))
```

Também podemos selecionar colunas baseado em um padrões. Por exemplo, podemos selecionar as variáveis que terminam com `Ramo`

``` r
selecionado <- select(morfologia, ends_with("ramo"))
str(selecionado)
```

    ## 'data.frame':    544 obs. of  3 variables:
    ##  $ volume.ramo     : num  0.7 2.51 3.2 1.22 2.99 1.36 3.4 2.46 2.62 1.94 ...
    ##  $ peso.seco.ramo  : num  0.46 0.72 1.09 0.4 0.77 0.28 1.26 0.91 0.84 0.76 ...
    ##  $ comprimento.ramo: num  5.8 NA 5 4.2 5.1 4.8 5.2 4.8 5.2 5.3 ...

Ou ainda, selecionar aquelas que começam com `M`.

``` r
selecionado <- select(morfologia, starts_with("m"))
str(selecionado)
```

    ## 'data.frame':    544 obs. of  3 variables:
    ##  $ massa.turgida.foliar: num  0.00647 0.0039 6.248 1.48 4.23 ...
    ##  $ massa.para.furar.g. : num  NA NA 230 225 199 ...
    ##  $ massa.seca.foliar   : num  0.00281 0.00158 2.016 0.364 1.07 ...

Outras opções de expressões básicas você pode encontrar em `?select`

Função `filter`
---------------

A função `filter` é utilizada para extrair um conjunto do linhas de um data frame.

Suponha que dejesamos filtrar `morfologia` as linhas em que os valores de `area.foliar` sejam maiores que 100.

``` r
morfo.f <- filter(morfologia, area.foliar > 100)
str(morfo.f)
```

    ## 'data.frame':    71 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 2 2 4 4 4 4 4 5 5 5 ...
    ##  $ Amostra             : int  3 4 2 1 3 4 5 4 3 5 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 14 16 7 7 7 10 10 10 10 10 ...
    ##  $ Data                : Factor w/ 51 levels "01/03/2017","02/03/2017",..: 42 11 3 40 3 44 44 44 44 44 ...
    ##  $ Clorofila           : num  44.8 NA 48.3 44.7 NA ...
    ##  $ espessura.foliar    : num  0.246 0.216 0.112 0.158 0.126 0.134 0.114 0.17 0.112 0.184 ...
    ##  $ massa.turgida.foliar: num  6.25 4.23 1.76 1.6 2.25 ...
    ##  $ area.foliar         : num  212 177 111 168 139 ...
    ##  $ massa.para.furar.g. : num  230 199 369 190 260 ...
    ##  $ massa.seca.foliar   : num  2.016 1.07 0.734 0.764 0.946 ...
    ##  $ volume.ramo         : num  3.2 2.99 1.94 3.4 1.8 4.06 8.5 4.3 5.71 6.04 ...
    ##  $ peso.seco.ramo      : num  1.09 0.77 0.76 1.27 0.66 1.4 2.69 1.74 2.3 1.72 ...
    ##  $ comprimento.ramo    : num  5 5.1 5.3 4.9 5.6 4.9 5.1 4.8 5.2 5.3 ...
    ##  $ densidade.vasos     : num  NA 4.65 2.03 1.75 NA ...

Note que há apenas 71 linhas que atendem ao critério estabelecido. Confira a distribuição dos valores de `area.foliar`:

``` r
summary(morfo.f)
```

    ##                     Espécie      Amostra                    Local   
    ##  Alchornea glandulosa   : 5   Min.   :1.000   FURB             :24  
    ##  Alchornea sidifolia    : 5   1st Qu.:2.000   Braço Paula Ramos:13  
    ##  Bathysa australis      : 5   Median :3.000   PMSF             :13  
    ##  Cecropia glaziovii     : 5   Mean   :2.845   Massaranduba     : 8  
    ##  Ficus adhatodifolia    : 5   3rd Qu.:4.000   Ipiranga         : 5  
    ##  Hieronyma alchorneoides: 5   Max.   :5.000   Spitz            : 3  
    ##  (Other)                :41                   (Other)          : 5  
    ##          Data      Clorofila     espessura.foliar massa.turgida.foliar
    ##  09/06/2016:13   Min.   :41.96   Min.   :0.0700   Min.   : 1.478      
    ##  13/04/2016: 9   1st Qu.:49.64   1st Qu.:0.1530   1st Qu.: 3.111      
    ##  02/05/2016: 8   Median :54.23   Median :0.2100   Median : 4.456      
    ##  26/07/2016: 8   Mean   :54.87   Mean   :0.2177   Mean   :10.307      
    ##  23/05/2016: 7   3rd Qu.:59.67   3rd Qu.:0.2630   3rd Qu.: 7.369      
    ##  08/08/2016: 5   Max.   :77.50   Max.   :0.4500   Max.   :72.930      
    ##  (Other)   :21   NA's   :9                                            
    ##   area.foliar     massa.para.furar.g. massa.seca.foliar  volume.ramo    
    ##  Min.   : 101.1   Min.   : 47.98      Min.   : 0.366    Min.   : 0.620  
    ##  1st Qu.: 133.7   1st Qu.:198.33      1st Qu.: 1.023    1st Qu.: 1.940  
    ##  Median : 184.0   Median :261.30      Median : 1.650    Median : 2.850  
    ##  Mean   : 503.2   Mean   :284.61      Mean   : 3.050    Mean   : 3.985  
    ##  3rd Qu.: 278.6   3rd Qu.:346.15      3rd Qu.: 2.798    3rd Qu.: 5.122  
    ##  Max.   :4255.6   Max.   :754.45      Max.   :21.396    Max.   :15.720  
    ##                   NA's   :3                             NA's   :1       
    ##  peso.seco.ramo  comprimento.ramo densidade.vasos  
    ##  Min.   :0.270   Min.   :4.500    Min.   : 0.2681  
    ##  1st Qu.:0.655   1st Qu.:5.025    1st Qu.: 2.1202  
    ##  Median :0.920   Median :5.300    Median : 4.7848  
    ##  Mean   :1.272   Mean   :5.321    Mean   : 8.2174  
    ##  3rd Qu.:1.425   3rd Qu.:5.600    3rd Qu.:11.6664  
    ##  Max.   :6.780   Max.   :7.200    Max.   :34.1105  
    ##                  NA's   :1        NA's   :49

Podemos fazer filtragens mais complexas e adicionar mais condições a serem atendidas. Por exemplo, podemos filtrar as linhas em `morfologia` que possuam `area.foliar` acima de 100 e `massa.seca.foliar` abaixo de 1.

``` r
morfo.f <- filter(morfologia, area.foliar > 100 & massa.seca.foliar  < 1) 
str(morfo.f)
```

    ## 'data.frame':    17 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 4 4 4 4 4 6 15 49 50 56 ...
    ##  $ Amostra             : int  2 1 3 4 5 1 3 3 5 4 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 7 7 7 10 10 14 14 14 7 7 ...
    ##  $ Data                : Factor w/ 51 levels "01/03/2017","02/03/2017",..: 3 40 3 44 44 6 37 50 3 3 ...
    ##  $ Clorofila           : num  48.3 44.7 NA 42.1 44.4 ...
    ##  $ espessura.foliar    : num  0.112 0.158 0.126 0.134 0.114 0.304 0.11 0.094 0.202 0.138 ...
    ##  $ massa.turgida.foliar: num  1.76 1.6 2.25 1.86 1.53 ...
    ##  $ area.foliar         : num  111 168 139 132 129 ...
    ##  $ massa.para.furar.g. : num  369 190 260 251 345 ...
    ##  $ massa.seca.foliar   : num  0.734 0.764 0.946 0.78 0.65 0.62 0.922 0.632 0.988 0.942 ...
    ##  $ volume.ramo         : num  1.94 3.4 1.8 4.06 8.5 1.55 1.08 7.83 2.68 2.61 ...
    ##  $ peso.seco.ramo      : num  0.76 1.27 0.66 1.4 2.69 0.4 0.35 1.3 0.56 1.44 ...
    ##  $ comprimento.ramo    : num  5.3 4.9 5.6 4.9 5.1 5.3 NA 5.6 5 5.6 ...
    ##  $ densidade.vasos     : num  2.032 1.746 NA 0.812 1.79 ...

``` r
View(morfo.f)
```

Para filtrar linhas com base em fatores a lógica é um pouco diferente. Para essa finalidade utilizamos o operador `%in%`.

Por exemplo, queremos um data frame com apenas algumas espécies de `morfologia`. Antes criamos um vetor com as espécies (`spp`) que desejamos e então usamos o operador `%in%` dentro da função `filter` para extrair os valores de `Especie` em `morfologia` que estão em `spp`.

``` r
spp <- morfologia$Espécie[c(23,68,256,269,500)]
spp
```

    ## [1] Alchornea triplinervia    Aspidosperma australe    
    ## [3] Hieronyma alchorneoides   Ilex dumosa              
    ## [5] Solanum sanctaecatharinae
    ## 117 Levels: Abarema langsdorffii ... Xylopia brasiliensis

``` r
morfo.f <- filter(morfologia, Espécie %in% spp)
str(morfo.f)
```

    ## 'data.frame':    23 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 6 6 6 6 6 16 16 16 16 16 ...
    ##  $ Amostra             : int  5 2 4 3 1 1 6 5 2 3 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 14 7 14 14 14 26 16 14 7 14 ...
    ##  $ Data                : Factor w/ 51 levels "01/03/2017","02/03/2017",..: 12 40 12 12 6 32 13 27 40 7 ...
    ##  $ Clorofila           : num  45.1 51.4 58.8 44.9 51.1 ...
    ##  $ espessura.foliar    : num  0.188 0.192 0.236 0.072 0.304 0.178 0.122 0.108 0.155 0.15 ...
    ##  $ massa.turgida.foliar: num  NA 1.35 1.51 NA 1.48 ...
    ##  $ area.foliar         : num  43.7 83.2 84.7 80.1 127.6 ...
    ##  $ massa.para.furar.g. : num  433 256 315 125 144 ...
    ##  $ massa.seca.foliar   : num  0.414 0.548 0.674 0.292 0.62 0.076 0.068 0.078 0.054 0.096 ...
    ##  $ volume.ramo         : num  1.09 1.8 2.11 3.78 1.55 0.34 0.43 0.71 2.49 3.38 ...
    ##  $ peso.seco.ramo      : num  0.48 0.69 0.75 1.14 0.4 0.28 0.29 0.46 1.4 1.88 ...
    ##  $ comprimento.ramo    : num  4.9 5.3 5.7 5.3 5.3 4.5 4.7 5.4 5.5 5.5 ...
    ##  $ densidade.vasos     : num  3.02 NA NA 2.88 NA ...

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

    ##                    Espécie Amostra  Local       Data Clorofila
    ## 1 Diatenopteryx sorbifolia       1 Rodeio 01/03/2017        NA
    ## 2           Hovenia dulcis       4 Rodeio 01/03/2017        NA
    ## 3  Lonchocarpus campestris       4 Rodeio 01/03/2017        NA
    ##   espessura.foliar massa.turgida.foliar area.foliar massa.para.furar.g.
    ## 1            0.048                0.074       4.593               74.82
    ## 2            0.120                0.828      47.780               83.43
    ## 3            0.154                0.300      17.623              261.38
    ##   massa.seca.foliar volume.ramo peso.seco.ramo comprimento.ramo
    ## 1             0.018        1.10           0.71              4.5
    ## 2             0.294        1.71           0.88              5.6
    ## 3             0.112        1.21           0.59              4.6
    ##   densidade.vasos
    ## 1              NA
    ## 2        1.791075
    ## 3              NA

``` r
tail(morfologia,3)
```

    ##                   Espécie Amostra       Local       Data Clorofila
    ## 542  Abarema langsdorffii       2 Gaspar alto 30/06/2017        NA
    ## 543 Piptadenia paniculata       4    Blumenau 30/06/2017     54.44
    ## 544 Piptadenia paniculata       5    Blumenau 30/06/2017     59.42
    ##     espessura.foliar massa.turgida.foliar area.foliar massa.para.furar.g.
    ## 542            0.162              0.00647   0.2419062                  NA
    ## 543            0.040              0.03000   2.8474000                70.6
    ## 544            0.094              0.03200   1.9228000                96.8
    ##     massa.seca.foliar volume.ramo peso.seco.ramo comprimento.ramo
    ## 542           0.00281        0.70           0.46              5.8
    ## 543           0.01000        1.22           0.62              5.2
    ## 544           0.01600        2.22           0.81              4.8
    ##     densidade.vasos
    ## 542              NA
    ## 543              NA
    ## 544              NA

Perceba que apesar do R ter executado a função e não retornado erro o resultado não é o que desejávamos. Acontece que a coluna `Data` é um `fator` e o R entende esse tipo de dado como 'palavra' e não como dados temporais.

``` r
str(morfologia)
```

    ## 'data.frame':    544 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 4 5 6 4 3 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 17 17 17 28 28 28 28 28 28 28 ...
    ##  $ Data                : Factor w/ 51 levels "01/03/2017","02/03/2017",..: 1 1 1 2 2 2 2 2 2 2 ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ espessura.foliar    : num  0.048 0.12 0.154 0.0847 0.126 0.178 0.184 0.218 0.068 0.074 ...
    ##  $ massa.turgida.foliar: num  0.074 0.828 0.3 NA 0.498 0.902 0.884 0.988 0.079 0.046 ...
    ##  $ area.foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ massa.para.furar.g. : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ massa.seca.foliar   : num  0.018 0.294 0.112 0.244 0.184 0.378 0.368 0.438 0.032 0.022 ...
    ##  $ volume.ramo         : num  1.1 1.71 1.21 4.07 2.08 1.13 0.97 5.84 2.41 3.91 ...
    ##  $ peso.seco.ramo      : num  0.71 0.88 0.59 0.65 1.07 0.82 0.67 3.36 0.65 0.79 ...
    ##  $ comprimento.ramo    : num  4.5 5.6 4.6 4.8 5.5 5.1 4.7 5.2 5.2 5.3 ...
    ##  $ densidade.vasos     : num  NA 1.79 NA NA NA ...

Para corrigir esse problema devemos transformas a variável `Data` em um vetor de classe data, e aí o R será capaz de ordenar o data frame com base em uma variável de tempo.

Fazemos isso com a função `as.Date`. Nela informamos o vetor que deve ser tranformado e o formato em que a data está anotada.

``` r
morfologia$Data <- as.Date(morfologia$Data, format = "%d/%m/%Y")
str(morfologia)
```

    ## 'data.frame':    544 obs. of  14 variables:
    ##  $ Espécie             : Factor w/ 117 levels "Abarema langsdorffii",..: 43 57 63 9 18 27 27 27 44 44 ...
    ##  $ Amostra             : int  1 4 4 5 3 4 5 6 4 3 ...
    ##  $ Local               : Factor w/ 28 levels "Blumenau","Botuverá",..: 17 17 17 28 28 28 28 28 28 28 ...
    ##  $ Data                : Date, format: "2017-03-01" "2017-03-01" ...
    ##  $ Clorofila           : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ espessura.foliar    : num  0.048 0.12 0.154 0.0847 0.126 0.178 0.184 0.218 0.068 0.074 ...
    ##  $ massa.turgida.foliar: num  0.074 0.828 0.3 NA 0.498 0.902 0.884 0.988 0.079 0.046 ...
    ##  $ area.foliar         : num  4.59 47.78 17.62 8.56 31.59 ...
    ##  $ massa.para.furar.g. : num  74.8 83.4 261.4 15.5 178 ...
    ##  $ massa.seca.foliar   : num  0.018 0.294 0.112 0.244 0.184 0.378 0.368 0.438 0.032 0.022 ...
    ##  $ volume.ramo         : num  1.1 1.71 1.21 4.07 2.08 1.13 0.97 5.84 2.41 3.91 ...
    ##  $ peso.seco.ramo      : num  0.71 0.88 0.59 0.65 1.07 0.82 0.67 3.36 0.65 0.79 ...
    ##  $ comprimento.ramo    : num  4.5 5.6 4.6 4.8 5.5 5.1 4.7 5.2 5.2 5.3 ...
    ##  $ densidade.vasos     : num  NA 1.79 NA NA NA ...

Agora, reaplicamos a função `arrange` e conferimos o resultado

``` r
morfologia <- arrange(morfologia, Data)
```

Vamos conferir as primeiras e as últimas linhas.

``` r
head(morfologia,3)
```

    ##                  Espécie Amostra Local       Data Clorofila
    ## 1 Alchornea triplinervia       1  PMSF 2016-04-06     51.14
    ## 2  Cyathea corcovadensis       1  PMFS 2016-04-06     62.70
    ## 3       Myrcia splendens       1  PMSF 2016-04-06     46.70
    ##   espessura.foliar massa.turgida.foliar area.foliar massa.para.furar.g.
    ## 1            0.304                1.478     127.593              144.46
    ## 2            0.230                0.270      12.704              213.37
    ## 3            0.110                0.040       4.029              157.38
    ##   massa.seca.foliar volume.ramo peso.seco.ramo comprimento.ramo
    ## 1             0.620        1.55           0.40              5.3
    ## 2             0.094        7.64           1.37              8.9
    ## 3             0.022        2.00           1.23              5.8
    ##   densidade.vasos
    ## 1              NA
    ## 2              NA
    ## 3              NA

``` r
tail(morfologia,3)
```

    ##                     Espécie Amostra          Local       Data Clorofila
    ## 542 Byrsonima ligustrifolia       4   Morro do Baú 2017-12-12        NA
    ## 543        Casearia obliqua       5   Morro do Baú 2017-12-12        NA
    ## 544   Aspidosperma australe       6 Praia Vermelha       <NA>        NA
    ##     espessura.foliar massa.turgida.foliar area.foliar massa.para.furar.g.
    ## 542            0.232                0.910     41.9954              215.58
    ## 543            0.062                0.068      7.4492              128.91
    ## 544            0.122                0.238     12.1918              182.85
    ##     massa.seca.foliar volume.ramo peso.seco.ramo comprimento.ramo
    ## 542             0.380        1.77           0.80              5.3
    ## 543             0.022        1.20           0.75              5.6
    ## 544             0.068        0.43           0.29              4.7
    ##     densidade.vasos
    ## 542              NA
    ## 543              NA
    ## 544              NA

Para ordenar de forma decrescente utiliza-se a função `desc` dessa maneira

``` r
morfologia <- arrange(morfologia, desc(massa.turgida.foliar))
head(select(morfologia, Espécie, massa.turgida.foliar))
```

    ##              Espécie massa.turgida.foliar
    ## 1 Cecropia glaziovii               72.930
    ## 2  Bathysa australis               63.325
    ## 3 Cecropia glaziovii               63.242
    ## 4 Cecropia glaziovii               63.064
    ## 5 Cecropia glaziovii               52.310
    ## 6  Bathysa australis               33.086

``` r
tail(select(morfologia, Espécie, massa.turgida.foliar))
```

    ##                  Espécie massa.turgida.foliar
    ## 539 Posoqueria latifolia                   NA
    ## 540    Ocotea silvestris                   NA
    ## 541  Myrcia brasiliensis                   NA
    ## 542     Alsophila setosa                   NA
    ## 543     Albizia edwallii                   NA
    ## 544     Albizia edwallii                   NA

Função `rename`
---------------

Renomear uma variável em um data frame é algo surpreendentemente difícil de fazer no R. A função `rename` facilita essa operação

Aqui você pode ver o nome das 5 primeira colunas de `morfologia`

``` r
names(morfologia)[1:5]
```

    ## [1] "Espécie"   "Amostra"   "Local"     "Data"      "Clorofila"

Vamos alterar `Especie` para `Nome` e `Local` para `Localidade`.

``` r
morfologia <- rename(morfologia, Nome.Cientifico = Espécie, Localidade = Local)
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
morfologia <- mutate(morfologia, Densidade.Ramo = peso.seco.ramo / volume.ramo)
head(morfologia, 3)
```

    ##      Nome.Cientifico Amostra Localidade       Data Clorofila
    ## 1 Cecropia glaziovii       2       FURB 2016-04-13     54.92
    ## 2  Bathysa australis       2       PMSF 2016-05-23     51.32
    ## 3 Cecropia glaziovii       5       FURB 2016-04-13     59.88
    ##   espessura.foliar massa.turgida.foliar area.foliar massa.para.furar.g.
    ## 1            0.258               72.930    4255.560              140.96
    ## 2            0.157               63.325    3044.550              236.04
    ## 3            0.280               63.242    3530.186               76.70
    ##   massa.seca.foliar volume.ramo peso.seco.ramo comprimento.ramo
    ## 1            21.396        5.21           0.69              5.8
    ## 2             8.235       15.72           2.71              5.9
    ## 3            17.714        3.90           0.53              5.7
    ##   densidade.vasos Densidade.Ramo
    ## 1              NA      0.1324376
    ## 2              NA      0.1723919
    ## 3              NA      0.1358974

Há outra função relacionada chamada `transmute` que funciona da mesma maneira que `mutate` mas retorna como resultado apenas as variáveis criadas.

``` r
head(transmute(morfologia, 
               Especie = Nome.Cientifico,
               Densidade.Ramo = peso.seco.ramo  / volume.ramo,
               Massa.Foliar.Por.Area = massa.seca.foliar / area.foliar))
```

    ##              Especie Densidade.Ramo Massa.Foliar.Por.Area
    ## 1 Cecropia glaziovii      0.1324376           0.005027775
    ## 2  Bathysa australis      0.1723919           0.002704833
    ## 3 Cecropia glaziovii      0.1358974           0.005017866
    ## 4 Cecropia glaziovii      0.1231733           0.006019084
    ## 5 Cecropia glaziovii      0.1368078           0.004476963
    ## 6  Bathysa australis      0.2173913           0.005490683

> Note que para manter a referência de qual espécie pertence cada valor, criamos uma variável chamada `Espécie` que é idêntica à variável `Nome`.

Função `group_by`
-----------------

Esta função é utilizada para gerar resumos estatíticos de um data frame baseados em um agrupamento dentro de uma variável. Por exemplo, nos dados `morfologia` há repetições de observações para cada espécie, podemos querer conhecer a média de massa foliar seca em cada espécie. A função `group_by` é frequentemente utilizada em conjunto com a função `summarize`.

A operação básica é uma combinação de 'quebra' do data frame em diferentes partes definida por uma variável ou um grupo de variáveis (`group_by`) e então aplica-se a função de resumo (`summarize`) a cada subconjunto.

``` r
grupo <- group_by(morfologia, Nome.Cientifico)
massa.media <- summarise(grupo, 
                         Media.Massa.foliar.Seca =  mean( massa.seca.foliar, na.rm = TRUE))
head(massa.media)
```

    ## # A tibble: 6 x 2
    ##          Nome.Cientifico Media.Massa.foliar.Seca
    ##                   <fctr>                   <dbl>
    ## 1   Abarema langsdorffii             0.002195000
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
2.  Calcular a média de `Clorofila` e `espessura.foliar` para as espécies (`summarize`)

``` r
morfologia %>%
  group_by(Nome.Cientifico) %>%
  summarize(Clorofila = mean(Clorofila, na.rm = TRUE),
            Espessura = mean(espessura.foliar, na.rm = TRUE)) %>%
  head(6)
```

    ## # A tibble: 6 x 3
    ##          Nome.Cientifico Clorofila  Espessura
    ##                   <fctr>     <dbl>      <dbl>
    ## 1   Abarema langsdorffii       NaN 0.11900000
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
  summarize(Massa.Foliar.seca = mean(massa.seca.foliar, na.rm = TRUE),
            Massa.Foliar.Turgida =  mean(massa.turgida.foliar, na.rm = TRUE))

massa.foliar
```

    ## # A tibble: 28 x 3
    ##            Localidade Massa.Foliar.seca Massa.Foliar.Turgida
    ##                <fctr>             <dbl>                <dbl>
    ##  1           Blumenau         0.0130000            0.0310000
    ##  2           Botuverá         0.1198864            0.3044545
    ##  3  Braço Paula Ramos         1.0200341            2.7317907
    ##  4 Braço Paula Ramos          0.1200000            0.2300000
    ##  5           Curitiba         0.1161818            0.2701818
    ##  6    Faxinal do Bepe         0.3664000            0.8510000
    ##  7               FURB         1.3061414            4.2093172
    ##  8        Gaspar alto         0.0028100            0.0064700
    ##  9           Ipiranga         0.3862412            1.1637062
    ## 10       Massaranduba         0.7902143            2.0643571
    ## # ... with 18 more rows

> Para ter certeza que cada passo está trazendo o resultado esperado inclua uma função de cada vez, confira o resultado e então adicione outro `%>%`. Quando toda a sequência de operações tiver sido conferida você assinala (`<-`) o resultado a um objeto.
