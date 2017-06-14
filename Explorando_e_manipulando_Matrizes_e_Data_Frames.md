Explorando e manipulando Matrizes e Data Frames
================

Ao importar uma planilha de dados para o R é importante conferir com os dados estão estruturados e se o R importou certinho os dados.

Algums funções do R pode nos auxiliar a entender com os dados estão estruturados.

`dim` mostra a dimensão (quantas linhas e quantas colunas) dos dados
`class` indica a classe do objeto que contem o conjunto de dados. Também pode ser aplicado para apenas uma coluna
`length` mostra o comprimento de um objeto. Quando aplicado a um vetor quantos valores o vetor contem. Quando aplicado a um data frame mostra quantas colunas ele possui. Quando aplicado a um objeto do tipo matriz mostra quantos valores a matriz completa contem
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

Exploramos como os dados estão estruturados, agora vamos entender a distribuição desses dados. Para isso podemos usar funções que nos indiquem informações básicas sobre os dados em si. Podemos, por exemplo, buscar pela média de cada variável, seu valor minimo e máximo. Para isso, podemos utilizar as funções `mean`, `min` e `max` para cada variável.

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

Note que as variáveis `Month` e `Day` estão sendo tratadas como números inteiros, quando na verdade devem ser entendidas como fatores. Neste caso podemos alterar a classe da variável para fator utilizando a função `as.factor`.

``` r
as.factor(airquality$Month)
as.factor(airquality$Day)
```

> Para alterar a classe de um objeto usamos as funções `as.` de acordo com a classe que desejamos. Acima usamos `as.factor` pra transformar uma variável númerica em fator. Outras opções são:
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

Agora sim temos dias e meses sendo tradados como fatores (ou seja, variáveis categoricas).

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

Acontece, que essas funções retornam um vetor numerico que indica as linhas ou colunas (dependendo da função em questão) que atendem ao critério que você determinou.

#### Função `order`

Por exemplo, queremos ordenar os dados de `airquality` de acordo com a temperatura, de forma crecente (do menor para o maior)

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
airquality[ordem,]
```

    ##     Ozone Solar.R Wind Temp Month Day
    ## 5      NA      NA 14.3   56     5   5
    ## 18      6      78 18.4   57     5  18
    ## 25     NA      66 16.6   57     5  25
    ## 27     NA      NA  8.0   57     5  27
    ## 15     18      65 13.2   58     5  15
    ## 26     NA     266 14.9   58     5  26
    ## 8      19      99 13.8   59     5   8
    ## 21      1       8  9.7   59     5  21
    ## 9       8      19 20.1   61     5   9
    ## 23      4      25  9.7   61     5  23
    ## 24     32      92 12.0   61     5  24
    ## 4      18     313 11.5   62     5   4
    ## 20     11      44  9.7   62     5  20
    ## 148    14      20 16.6   63     9  25
    ## 16     14     334 11.5   64     5  16
    ## 144    13     238 12.6   64     9  21
    ## 7      23     299  8.6   65     5   7
    ## 49     20      37  9.2   65     6  18
    ## 6      28      NA 14.9   66     5   6
    ## 13     11     290  9.2   66     5  13
    ## 17     34     307 12.0   66     5  17
    ## 1      41     190  7.4   67     5   1
    ## 28     23      13 12.0   67     5  28
    ## 34     NA     242 16.1   67     6   3
    ## 140    18     224 13.8   67     9  17
    ## 14     14     274 10.9   68     5  14
    ## 19     30     322 11.5   68     5  19
    ## 142    24     238 10.3   68     9  19
    ## 153    20     223 11.5   68     9  30
    ## 10     NA     194  8.6   69     5  10
    ## 12     16     256  9.7   69     5  12
    ## 147     7      49 10.3   69     9  24
    ## 149    30     193  6.9   70     9  26
    ## 137     9      24 10.9   71     9  14
    ## 138    13     112 11.5   71     9  15
    ## 145    23      14  9.2   71     9  22
    ## 2      36     118  8.0   72     5   2
    ## 48     37     284 20.7   72     6  17
    ## 114     9      36 14.3   72     8  22
    ## 22     11     320 16.6   73     5  22
    ## 50     12     120 11.5   73     6  19
    ## 58     NA      47 10.3   73     6  27
    ## 73     10     264 14.3   73     7  12
    ## 133    24     259  9.7   73     9  10
    ## 3      12     149 12.6   74     5   3
    ## 11      7      NA  6.9   74     5  11
    ## 33     NA     287  9.7   74     6   2
    ## 82     16       7  6.9   74     7  21
    ## 56     NA     135  8.0   75     6  25
    ## 115    NA     255 12.6   75     8  23
    ## 132    21     230 10.9   75     9   9
    ## 151    14     191 14.3   75     9  28
    ## 31     37     279  7.4   76     5  31
    ## 51     13     137 10.3   76     6  20
    ## 53     NA      59  1.7   76     6  22
    ## 54     NA      91  4.6   76     6  23
    ## 55     NA     250  6.3   76     6  24
    ## 110    23     115  7.4   76     8  18
    ## 135    21     259 15.5   76     9  12
    ## 141    13      27 10.3   76     9  18
    ## 152    18     131  8.0   76     9  29
    ## 47     21     191 14.9   77     6  16
    ## 52     NA     150  6.3   77     6  21
    ## 60     NA      31 14.9   77     6  29
    ## 108    22      71 10.3   77     8  16
    ## 113    21     259 15.5   77     8  21
    ## 136    28     238  6.3   77     9  13
    ## 150    NA     145 13.2   77     9  27
    ## 32     NA     286  8.6   78     6   1
    ## 57     NA     127  8.0   78     6  26
    ## 111    31     244 10.9   78     8  19
    ## 112    44     190 10.3   78     8  20
    ## 131    23     220 10.3   78     9   8
    ## 139    46     237  6.9   78     9  16
    ## 30    115     223  5.7   79     5  30
    ## 37     NA     264 14.3   79     6   6
    ## 46     NA     322 11.5   79     6  15
    ## 107    NA      64 11.5   79     8  15
    ## 109    59      51  6.3   79     8  17
    ## 116    45     212  9.7   79     8  24
    ## 45     NA     332 13.8   80     6  14
    ## 59     NA      98 11.5   80     6  28
    ## 76      7      48 14.3   80     7  15
    ## 106    65     157  9.7   80     8  14
    ## 130    20     252 10.9   80     9   7
    ## 29     45     252 14.9   81     5  29
    ## 64     32     236  9.2   81     7   3
    ## 74     27     175 14.9   81     7  13
    ## 77     48     260  6.9   81     7  16
    ## 83     NA     258  9.7   81     7  22
    ## 92     59     254  9.2   81     7  31
    ## 93     39      83  6.9   81     8   1
    ## 94      9      24 13.8   81     8   2
    ## 117   168     238  3.4   81     8  25
    ## 134    44     236 14.9   81     9  11
    ## 146    36     139 10.3   81     9  23
    ## 38     29     127  9.7   82     6   7
    ## 44     23     148  8.0   82     6  13
    ## 72     NA     139  8.6   82     7  11
    ## 78     35     274 10.3   82     7  17
    ## 84     NA     295 11.5   82     7  23
    ## 87     20      81  8.6   82     7  26
    ## 95     16      77  7.4   82     8   3
    ## 105    28     273 11.5   82     8  13
    ## 143    16     201  8.0   82     9  20
    ## 61     NA     138  8.0   83     6  30
    ## 66     64     175  4.6   83     7   5
    ## 67     40     314 10.9   83     7   6
    ## 91     64     253  7.4   83     7  30
    ## 35     NA     186  9.2   84     6   4
    ## 62    135     269  4.1   84     7   1
    ## 65     NA     101 10.9   84     7   4
    ## 79     61     285  6.3   84     7  18
    ## 129    32      92 15.5   84     9   6
    ## 36     NA     220  8.6   85     6   5
    ## 63     49     248  9.2   85     7   2
    ## 81     63     220 11.5   85     7  20
    ## 86    108     223  8.0   85     7  25
    ## 97     35      NA  7.4   85     8   5
    ## 85     80     294  8.6   86     7  24
    ## 88     52      82 12.0   86     7  27
    ## 90     50     275  7.4   86     7  29
    ## 96     78      NA  6.9   86     8   4
    ## 103    NA     137 11.5   86     8  11
    ## 104    44     192 11.5   86     8  12
    ## 118    73     215  8.0   86     8  26
    ## 39     NA     273  6.9   87     6   8
    ## 41     39     323 11.5   87     6  10
    ## 80     79     187  5.1   87     7  19
    ## 98     66      NA  4.6   87     8   6
    ## 128    47      95  7.4   87     9   5
    ## 68     77     276  5.1   88     7   7
    ## 89     82     213  7.4   88     7  28
    ## 119    NA     153  5.7   88     8  27
    ## 71     85     175  7.4   89     7  10
    ## 99    122     255  4.0   89     8   7
    ## 40     71     291 13.8   90     6   9
    ## 100    89     229 10.3   90     8   8
    ## 101   110     207  8.0   90     8   9
    ## 75     NA     291 14.9   91     7  14
    ## 124    96     167  6.9   91     9   1
    ## 43     NA     250  9.2   92     6  12
    ## 69     97     267  6.3   92     7   8
    ## 70     97     272  5.7   92     7   9
    ## 102    NA     222  8.6   92     8  10
    ## 125    78     197  5.1   92     9   2
    ## 42     NA     259 10.9   93     6  11
    ## 126    73     183  2.8   93     9   3
    ## 127    91     189  4.6   93     9   4
    ## 121   118     225  2.3   94     8  29
    ## 123    85     188  6.3   94     8  31
    ## 122    84     237  6.3   96     8  30
    ## 120    76     203  9.7   97     8  28

Note que utilizamos o resultado da função `order` no campo referente a seleção das linhas de `airquality`. Que poderia ter sido escrito dessa maneira também:

``` r
airquality[order(airquality$Temp),]
```

    ##     Ozone Solar.R Wind Temp Month Day
    ## 5      NA      NA 14.3   56     5   5
    ## 18      6      78 18.4   57     5  18
    ## 25     NA      66 16.6   57     5  25
    ## 27     NA      NA  8.0   57     5  27
    ## 15     18      65 13.2   58     5  15
    ## 26     NA     266 14.9   58     5  26
    ## 8      19      99 13.8   59     5   8
    ## 21      1       8  9.7   59     5  21
    ## 9       8      19 20.1   61     5   9
    ## 23      4      25  9.7   61     5  23
    ## 24     32      92 12.0   61     5  24
    ## 4      18     313 11.5   62     5   4
    ## 20     11      44  9.7   62     5  20
    ## 148    14      20 16.6   63     9  25
    ## 16     14     334 11.5   64     5  16
    ## 144    13     238 12.6   64     9  21
    ## 7      23     299  8.6   65     5   7
    ## 49     20      37  9.2   65     6  18
    ## 6      28      NA 14.9   66     5   6
    ## 13     11     290  9.2   66     5  13
    ## 17     34     307 12.0   66     5  17
    ## 1      41     190  7.4   67     5   1
    ## 28     23      13 12.0   67     5  28
    ## 34     NA     242 16.1   67     6   3
    ## 140    18     224 13.8   67     9  17
    ## 14     14     274 10.9   68     5  14
    ## 19     30     322 11.5   68     5  19
    ## 142    24     238 10.3   68     9  19
    ## 153    20     223 11.5   68     9  30
    ## 10     NA     194  8.6   69     5  10
    ## 12     16     256  9.7   69     5  12
    ## 147     7      49 10.3   69     9  24
    ## 149    30     193  6.9   70     9  26
    ## 137     9      24 10.9   71     9  14
    ## 138    13     112 11.5   71     9  15
    ## 145    23      14  9.2   71     9  22
    ## 2      36     118  8.0   72     5   2
    ## 48     37     284 20.7   72     6  17
    ## 114     9      36 14.3   72     8  22
    ## 22     11     320 16.6   73     5  22
    ## 50     12     120 11.5   73     6  19
    ## 58     NA      47 10.3   73     6  27
    ## 73     10     264 14.3   73     7  12
    ## 133    24     259  9.7   73     9  10
    ## 3      12     149 12.6   74     5   3
    ## 11      7      NA  6.9   74     5  11
    ## 33     NA     287  9.7   74     6   2
    ## 82     16       7  6.9   74     7  21
    ## 56     NA     135  8.0   75     6  25
    ## 115    NA     255 12.6   75     8  23
    ## 132    21     230 10.9   75     9   9
    ## 151    14     191 14.3   75     9  28
    ## 31     37     279  7.4   76     5  31
    ## 51     13     137 10.3   76     6  20
    ## 53     NA      59  1.7   76     6  22
    ## 54     NA      91  4.6   76     6  23
    ## 55     NA     250  6.3   76     6  24
    ## 110    23     115  7.4   76     8  18
    ## 135    21     259 15.5   76     9  12
    ## 141    13      27 10.3   76     9  18
    ## 152    18     131  8.0   76     9  29
    ## 47     21     191 14.9   77     6  16
    ## 52     NA     150  6.3   77     6  21
    ## 60     NA      31 14.9   77     6  29
    ## 108    22      71 10.3   77     8  16
    ## 113    21     259 15.5   77     8  21
    ## 136    28     238  6.3   77     9  13
    ## 150    NA     145 13.2   77     9  27
    ## 32     NA     286  8.6   78     6   1
    ## 57     NA     127  8.0   78     6  26
    ## 111    31     244 10.9   78     8  19
    ## 112    44     190 10.3   78     8  20
    ## 131    23     220 10.3   78     9   8
    ## 139    46     237  6.9   78     9  16
    ## 30    115     223  5.7   79     5  30
    ## 37     NA     264 14.3   79     6   6
    ## 46     NA     322 11.5   79     6  15
    ## 107    NA      64 11.5   79     8  15
    ## 109    59      51  6.3   79     8  17
    ## 116    45     212  9.7   79     8  24
    ## 45     NA     332 13.8   80     6  14
    ## 59     NA      98 11.5   80     6  28
    ## 76      7      48 14.3   80     7  15
    ## 106    65     157  9.7   80     8  14
    ## 130    20     252 10.9   80     9   7
    ## 29     45     252 14.9   81     5  29
    ## 64     32     236  9.2   81     7   3
    ## 74     27     175 14.9   81     7  13
    ## 77     48     260  6.9   81     7  16
    ## 83     NA     258  9.7   81     7  22
    ## 92     59     254  9.2   81     7  31
    ## 93     39      83  6.9   81     8   1
    ## 94      9      24 13.8   81     8   2
    ## 117   168     238  3.4   81     8  25
    ## 134    44     236 14.9   81     9  11
    ## 146    36     139 10.3   81     9  23
    ## 38     29     127  9.7   82     6   7
    ## 44     23     148  8.0   82     6  13
    ## 72     NA     139  8.6   82     7  11
    ## 78     35     274 10.3   82     7  17
    ## 84     NA     295 11.5   82     7  23
    ## 87     20      81  8.6   82     7  26
    ## 95     16      77  7.4   82     8   3
    ## 105    28     273 11.5   82     8  13
    ## 143    16     201  8.0   82     9  20
    ## 61     NA     138  8.0   83     6  30
    ## 66     64     175  4.6   83     7   5
    ## 67     40     314 10.9   83     7   6
    ## 91     64     253  7.4   83     7  30
    ## 35     NA     186  9.2   84     6   4
    ## 62    135     269  4.1   84     7   1
    ## 65     NA     101 10.9   84     7   4
    ## 79     61     285  6.3   84     7  18
    ## 129    32      92 15.5   84     9   6
    ## 36     NA     220  8.6   85     6   5
    ## 63     49     248  9.2   85     7   2
    ## 81     63     220 11.5   85     7  20
    ## 86    108     223  8.0   85     7  25
    ## 97     35      NA  7.4   85     8   5
    ## 85     80     294  8.6   86     7  24
    ## 88     52      82 12.0   86     7  27
    ## 90     50     275  7.4   86     7  29
    ## 96     78      NA  6.9   86     8   4
    ## 103    NA     137 11.5   86     8  11
    ## 104    44     192 11.5   86     8  12
    ## 118    73     215  8.0   86     8  26
    ## 39     NA     273  6.9   87     6   8
    ## 41     39     323 11.5   87     6  10
    ## 80     79     187  5.1   87     7  19
    ## 98     66      NA  4.6   87     8   6
    ## 128    47      95  7.4   87     9   5
    ## 68     77     276  5.1   88     7   7
    ## 89     82     213  7.4   88     7  28
    ## 119    NA     153  5.7   88     8  27
    ## 71     85     175  7.4   89     7  10
    ## 99    122     255  4.0   89     8   7
    ## 40     71     291 13.8   90     6   9
    ## 100    89     229 10.3   90     8   8
    ## 101   110     207  8.0   90     8   9
    ## 75     NA     291 14.9   91     7  14
    ## 124    96     167  6.9   91     9   1
    ## 43     NA     250  9.2   92     6  12
    ## 69     97     267  6.3   92     7   8
    ## 70     97     272  5.7   92     7   9
    ## 102    NA     222  8.6   92     8  10
    ## 125    78     197  5.1   92     9   2
    ## 42     NA     259 10.9   93     6  11
    ## 126    73     183  2.8   93     9   3
    ## 127    91     189  4.6   93     9   4
    ## 121   118     225  2.3   94     8  29
    ## 123    85     188  6.3   94     8  31
    ## 122    84     237  6.3   96     8  30
    ## 120    76     203  9.7   97     8  28

> caso deseje em ordem decrescente, inclua na função `order` o argumento `decreasing = TRUE`

#### Função `which`

A função `which` funciona de maneira similar, ao incluir o critério de filtro a função retorna o número das linha que atendem ao critério estabelecido. Para isso usamos comandos de lógica.

> **Comandos de lógica ** - `==` igual à
> - `!=` diferente de
> - `>` maior que
> - `>=` maior ou igual à
> - `<` menor que
> - `<=`menor ou igual à
> - `&` e
> - `|` ou
