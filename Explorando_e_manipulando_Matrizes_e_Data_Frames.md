Explorando e manipulando Matrizes e Data Frames
================

Ao importar uma planilha de dados para o R é importante conferir como os dados estão estruturados e se o R importou certinho os dados.

Algumas funções do R podem nos auxiliar a entender como os dados estão estruturados.

`dim` mostra a dimensão (quantas linhas e quantas colunas) dos dados
`class` indica a classe do objeto que contém o conjunto de dados. Também pode ser aplicado para apenas uma coluna
`length` mostra o comprimento de um objeto. Quando aplicado a um vetor, quantos valores o vetor contém. Quando aplicado a um data frame mostra quantas colunas ele possui. Quando aplicado a um objeto do tipo matriz mostra quantos valores a matriz completa contém
`str` mostra a estrutura dos dados. Essa função agrupa outras funções acima indicando a dimensão, a classe do conjunto de dados completo e a classe de cada variável (coluna)

Carregue os dados de `airquality` e explore as funções citadas acima:

``` r
data("airquality")

dim(airquality)
```

    ## [1] 153   6

``` r
class(airquality)
```

    ## [1] "data.frame"

``` r
class(airquality$Wind)
```

    ## [1] "numeric"

``` r
length(airquality)
```

    ## [1] 6

``` r
length(airquality$Ozone)
```

    ## [1] 153

``` r
str(airquality)
```

    ## 'data.frame':    153 obs. of  6 variables:
    ##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
    ##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
    ##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
    ##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

Exploramos como os dados estão estruturados, agora vamos entender a distribuição desses dados. Para isso podemos usar funções que nos indiquem informações básicas sobre os dados em si. Podemos, por exemplo, buscar pela média de cada variável, seu valor mínimo e máximo. Para isso, podemos utilizar as funções `mean`, `min` e `max` para cada variável.

Por exemplo:

``` r
mean(airquality$Wind)
```

    ## [1] 9.957516

``` r
min(airquality$Wind)
```

    ## [1] 1.7

``` r
max(airquality$Wind)
```

    ## [1] 20.7

Ou ainda, podemos usar a função `summary` para o conjunto de dados:

``` r
summary(airquality)
```

    ##      Ozone           Solar.R           Wind             Temp      
    ##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
    ##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
    ##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
    ##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
    ##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
    ##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
    ##  NA's   :37       NA's   :7                                       
    ##      Month            Day      
    ##  Min.   :5.000   Min.   : 1.0  
    ##  1st Qu.:6.000   1st Qu.: 8.0  
    ##  Median :7.000   Median :16.0  
    ##  Mean   :6.993   Mean   :15.8  
    ##  3rd Qu.:8.000   3rd Qu.:23.0  
    ##  Max.   :9.000   Max.   :31.0  
    ## 

Note que as variáveis `Month` e `Day` estão sendo tratadas como números inteiros, quando na verdade devem ser entendidas como fatores. Neste caso, podemos alterar a classe da variável para fator utilizando a função `as.factor`.

``` r
as.factor(airquality$Month)
as.factor(airquality$Day)
```

> Para alterar a classe de um objeto, usamos as funções `as.` de acordo com a classe que desejamos. Acima usamos `as.factor` pra transformar uma variável númerica em fator. Outras opções são:
> - `as.numeric`
> - `as.character`
> - `as.list`
> - `as.data.frame`
> - `as.matrix`

Vamos repetir a função `str` pra ver se deu certo nossa alteração:

``` r
str(airquality)
```

    ## 'data.frame':    153 obs. of  6 variables:
    ##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
    ##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
    ##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
    ##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

Opa, continua tratando como número inteiro, tem algo errado.

Acontece que não foi informado ao R que ele deveria substituir as variáveis `Month` e `Day` após a alteração de classe. Fazemos isso da seguinte maneira:

``` r
airquality$Month <- as.factor(airquality$Month)
airquality$Day <- as.factor(airquality$Day)

str(airquality)
```

    ## 'data.frame':    153 obs. of  6 variables:
    ##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
    ##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
    ##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
    ##  $ Month  : Factor w/ 5 levels "5","6","7","8",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Day    : Factor w/ 31 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...

Agora sim temos dias e meses sendo tradados como fatores (ou seja, variáveis categóricas).

Se usarmos o `summary` agora veremos que a função apenas retorna a contagem de cada nível de fator (ou categoria).

``` r
summary(airquality)
```

    ##      Ozone           Solar.R           Wind             Temp       Month 
    ##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00   5:31  
    ##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00   6:30  
    ##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00   7:31  
    ##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88   8:31  
    ##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00   9:30  
    ##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00         
    ##  NA's   :37       NA's   :7                                              
    ##       Day     
    ##  1      :  5  
    ##  2      :  5  
    ##  3      :  5  
    ##  4      :  5  
    ##  5      :  5  
    ##  6      :  5  
    ##  (Other):123

### Ordenar e filtrar dados

Ordenar e filtrar dados são operações comuns quando se lida com dados. No R temos as funções `order` e `which` que realizam essas operações. Entretanto, elas não são tão intuitivas para usar.

Acontece que essas funções retornam um vetor numérico que indica as linhas ou colunas (dependendo da função em questão) que atendem ao critério que você determinou.

#### Função `order`

Por exemplo, queremos ordenar os dados de `airquality` de acordo com a temperatura, de forma crescente (do menor para o maior).

``` r
order(airquality$Temp)
```

    ##   [1]   5  18  25  27  15  26   8  21   9  23  24   4  20 148  16 144   7
    ##  [18]  49   6  13  17   1  28  34 140  14  19 142 153  10  12 147 149 137
    ##  [35] 138 145   2  48 114  22  50  58  73 133   3  11  33  82  56 115 132
    ##  [52] 151  31  51  53  54  55 110 135 141 152  47  52  60 108 113 136 150
    ##  [69]  32  57 111 112 131 139  30  37  46 107 109 116  45  59  76 106 130
    ##  [86]  29  64  74  77  83  92  93  94 117 134 146  38  44  72  78  84  87
    ## [103]  95 105 143  61  66  67  91  35  62  65  79 129  36  63  81  86  97
    ## [120]  85  88  90  96 103 104 118  39  41  80  98 128  68  89 119  71  99
    ## [137]  40 100 101  75 124  43  69  70 102 125  42 126 127 121 123 122 120

O código executado acima retorna o numero da linha da cada valor, ou seja, o menor valor de temperatura está na linha 5, o segundo menor valor está na linha 18, e assim por diante. Portanto esse resultado deve ser utilizado para ordenar o objeto que desejamos.

Então podemos fazer assim:

``` r
ordem <- order(airquality$Temp)
head(airquality[ordem,])
```

    ##    Ozone Solar.R Wind Temp Month Day
    ## 5     NA      NA 14.3   56     5   5
    ## 18     6      78 18.4   57     5  18
    ## 25    NA      66 16.6   57     5  25
    ## 27    NA      NA  8.0   57     5  27
    ## 15    18      65 13.2   58     5  15
    ## 26    NA     266 14.9   58     5  26

Note que utilizamos o resultado da função `order` no campo referente a seleção das linhas de `airquality`. Que poderia ter sido escrito dessa maneira também:

``` r
head(airquality[order(airquality$Temp),])
```

    ##    Ozone Solar.R Wind Temp Month Day
    ## 5     NA      NA 14.3   56     5   5
    ## 18     6      78 18.4   57     5  18
    ## 25    NA      66 16.6   57     5  25
    ## 27    NA      NA  8.0   57     5  27
    ## 15    18      65 13.2   58     5  15
    ## 26    NA     266 14.9   58     5  26

> caso deseje em ordem decrescente, inclua na função `order` o argumento `decreasing = TRUE`

#### Função `which`

A função `which` funciona de maneira similar à função `order`, ao incluir o critério de filtro a função retorna o número das linhas que atendem ao critério estabelecido. Para isso usamos comandos de lógica.

> **Comandos de lógica**
> - `==` igual a
> - `!=` diferente de
> - `>` maior que
> - `>=` maior ou igual a
> - `<` menor que
> - `<=`menor ou igual a
> - `&` e
> - `|` ou

Exemplo: Selecionar as temperaturas maiores que 60 F e menores que 70 F

``` r
which(airquality$Temp > 60 & airquality$Temp < 70)
```

    ##  [1]   1   4   6   7   9  10  12  13  14  16  17  19  20  23  24  28  34
    ## [18]  49 140 142 144 147 148 153

``` r
airquality[which(airquality$Temp > 60 & airquality$Temp < 70),]
```

    ##     Ozone Solar.R Wind Temp Month Day
    ## 1      41     190  7.4   67     5   1
    ## 4      18     313 11.5   62     5   4
    ## 6      28      NA 14.9   66     5   6
    ## 7      23     299  8.6   65     5   7
    ## 9       8      19 20.1   61     5   9
    ## 10     NA     194  8.6   69     5  10
    ## 12     16     256  9.7   69     5  12
    ## 13     11     290  9.2   66     5  13
    ## 14     14     274 10.9   68     5  14
    ## 16     14     334 11.5   64     5  16
    ## 17     34     307 12.0   66     5  17
    ## 19     30     322 11.5   68     5  19
    ## 20     11      44  9.7   62     5  20
    ## 23      4      25  9.7   61     5  23
    ## 24     32      92 12.0   61     5  24
    ## 28     23      13 12.0   67     5  28
    ## 34     NA     242 16.1   67     6   3
    ## 49     20      37  9.2   65     6  18
    ## 140    18     224 13.8   67     9  17
    ## 142    24     238 10.3   68     9  19
    ## 144    13     238 12.6   64     9  21
    ## 147     7      49 10.3   69     9  24
    ## 148    14      20 16.6   63     9  25
    ## 153    20     223 11.5   68     9  30

Nomes
=====

Os objetos do R podem conter nomes, que podem ser muito úteis para escrever um código legível e que se auto-descreve.

Para acessar nomes ao um vetor de numeros inteiros (integer)

``` r
x <- 1:3  
names(x)  
```

    ## NULL

``` r
# nomeando os valores
names(x) <- c("New York", "Seattle", "Los Angeles") 

x
```

    ##    New York     Seattle Los Angeles 
    ##           1           2           3

``` r
names(x)
```

    ## [1] "New York"    "Seattle"     "Los Angeles"

Listas também podem ter nomes

``` r
 x <- list("Los Angeles" = 1, Boston = 2, London = 3)
 x
```

    ## $`Los Angeles`
    ## [1] 1
    ## 
    ## $Boston
    ## [1] 2
    ## 
    ## $London
    ## [1] 3

``` r
 names(x)
```

    ## [1] "Los Angeles" "Boston"      "London"

Matrizes tem tanto nomes de colunas como de linhas.

``` r
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m
```

    ##   c d
    ## a 1 3
    ## b 2 4

Nomes de coluna e de linha podem ser configurados usando as funções `colnames` e `rownames`

``` r
colnames(m) <- c("h", "f") 
rownames(m) <- c("s", "e") 
```

Assim como listas, data frames apresentam nomes de colunas que podem ser acessados tanto com a função `names` quanto com `colnames`

``` r
d <- as.data.frame(m)
dimnames(d)
```

    ## [[1]]
    ## [1] "s" "e"
    ## 
    ## [[2]]
    ## [1] "h" "f"

``` r
# nome de coluna em matriz
names(m)
```

    ## NULL

``` r
colnames(m)
```

    ## [1] "h" "f"

``` r
# nome de coluna em data frame
names(d)
```

    ## [1] "h" "f"

``` r
colnames(d)
```

    ## [1] "h" "f"

``` r
# nome de linha em matriz
rownames(m)
```

    ## [1] "s" "e"

``` r
row.names(m)
```

    ## [1] "s" "e"

``` r
# nome de linha em data frame
rownames(d)
```

    ## [1] "s" "e"

``` r
row.names(d)
```

    ## [1] "s" "e"
