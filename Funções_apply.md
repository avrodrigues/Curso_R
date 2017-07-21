Funções `apply`
================

*Texto traduzido e adaptado com base no capítulo 18 do livro 'R Programming for Data Science' de Roger D. Peng que pode ser adquirido em <http://leanpub.com/rprogramming>*

Trabalhando com data frames frequentemente necessitamos realizar operações em loop, ou seja, aplicar uma função a diversos fatores de um data frame.

Um exemplo básico de uma operação em loop seria obter o valor médio de cada coluna em um data frame, neste caso a função é a média e os fatores são as colunas.

As funções `apply` implementam loopings numa forma compacta.

-   `lapply`: Faz loop sobre uma lista e aplica a função a cada elemento
-   `sapply`: Igual ao `lapply` mas simplifica o resultado
-   `apply`: Aplica uma função à margem de uma matriz
-   `tapply`: Aplica uma função a subgrupos de um vetor
-   `mapply`: versão multivariada de lapply

> A função `split` pode auxiliar na operação de `tapply`

Criar uma função
----------------

Todas as funções `apply` listadas acima necessitam de que você indique a função que será aplicada ao conjunto de dados de interesse. Elas aceitam funções pré-existentes mas você pode criar uma função. Essas funções irmãs fazem uso pesado de funções criadas pelo usuário.

Portanto é fundamental que você entenda como criar uma função no R.

Usamos `function` para criar uma nova função. Veja abaixo uma função que soma dois elementos e eleva o resultado ao quadrado.

``` r
soma.quadrado <- function(a, b){
    (a + b)^2
}

soma.quadrado(2,2)
```

    ## [1] 16

> -   Em `function` informamos os argumentos que a função deve conter, no exemplo acima prevemos os argumentos `a` e `b`
> -   Entre chaves `{}` informamos a operação que deve ser realizada ("Some os objetos `a` e `b` e depois eleve ao quadrado")
> -   Assinalmos a função ao objeto `soma.quadrado` que será um objeto do tipo função salvo no Ambiente Global do R
> -   Ao utilizar `soma.quadrado` informamos os valores dos argumentos `a` e `b` entre parentesis `()`

Podemos incluir valores padrão para algum argumento, então ao utilizar a função o argumento que possui um valor padronizado pode ser omitido.

Por exemplo, em `soma.quadrado` vamos padronizar `b = 2`.

``` r
soma.quadrado <- function(a, b = 2){
    (a + b)^2
}

soma.quadrado(2)
```

    ## [1] 16

``` r
soma.quadrado(2,7)
```

    ## [1] 81

> Note que se omitimos o valor de `b` a função usa o valor padrão para completar a operação.

Função `lapply`
---------------

1.  Faz loop sobre uma lista, interagindo com cada elemento dessa lista
2.  Aplica uma função a cada elemento dessa lista (uma função que você especifica)
3.  Retorna uma lista como resultadon (O `l` é de lista)

`lapply`possui 3 argumentos básicos:

-   uma lista `X`
-   uma função (ou o nome de uma função) `FUN`
-   outros argumentos da função via `...`

`lapply` admite outros tipos de objeto além de lista, porém o resultado é sempre uma lista.

Aqui aplicamos a função `mean` a todos os elementos de uma lista como exemplo

``` r
x <- list(a = rnorm(10), b = 50:100, c = rnorm(30))
lapply(x, mean)
```

    ## $a
    ## [1] 0.3082321
    ## 
    ## $b
    ## [1] 75
    ## 
    ## $c
    ## [1] 0.3264395

Note que a função `mean` está como um argumento em `lappy` e portanto não necessita dos `()` ao final. Caso necessite incluir algum argumento relativo a função que você está aplicando, basta incluir uma `,` e adicionar o argumento como na função normal.

Exemplo: obter a média de dados que possuem alguns valores faltantes (`NA`).

``` r
data("airquality")
str(airquality)
```

    ## 'data.frame':    153 obs. of  6 variables:
    ##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
    ##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
    ##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
    ##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

``` r
lapply(airquality, mean, na.rm = TRUE)
```

    ## $Ozone
    ## [1] 42.12931
    ## 
    ## $Solar.R
    ## [1] 185.9315
    ## 
    ## $Wind
    ## [1] 9.957516
    ## 
    ## $Temp
    ## [1] 77.88235
    ## 
    ## $Month
    ## [1] 6.993464
    ## 
    ## $Day
    ## [1] 15.80392

Você pode usar o `lapply` para rodar uma função múltiplas vezes, cada vez com um argumento diferente. Abaixo, usamos a função `rnorm` para gerar valores de distribuição normal 5 vezes, cada vez com um número diferente de valores. Além disso, informamos que os valores gerados devem ter média = 1 e desvio padrão = 0.5

``` r
x <- 1:5
lapply(x, rnorm, mean = 1, sd = 0.5)
```

    ## [[1]]
    ## [1] 1.040312
    ## 
    ## [[2]]
    ## [1] 1.2502982 0.7825499
    ## 
    ## [[3]]
    ## [1] 0.2780254 0.6352528 0.9063537
    ## 
    ## [[4]]
    ## [1] 1.0398507 0.9129057 0.4201851 0.6127515
    ## 
    ## [[5]]
    ## [1] 2.0138862 0.6344018 1.5234040 0.8146687 2.0630001

A lógica por trás dessa maneira de usar `lapply` é que os valores no vetor são entendidos como o primeiro argumento de `rnorm`. Os outros argumentos de `rnorm` são configurados dentro da função `lapply`.

Podemos criar uma função anônima e aplicá-la `lapply` e seus familiares. Uma função anônima é uma função criada que não fica salva no Ambiente Global. Ela é utilizada apenas enquanto você usa o `lapply`.

Aqui vou criar uma lista com duas matrizes e selecionar apenas a primeira coluna delas via função anônima.

``` r
lista <- list(a = matrix(1:12, 4,3), b = matrix(1:25, 5, 5))
lapply(lista, function(elem) elem[,1])
```

    ## $a
    ## [1] 1 2 3 4
    ## 
    ## $b
    ## [1] 1 2 3 4 5

Acima, definimos uma nova função diretamente dentro da função `lappy`. Caso a função seja muito complexa é mais indicado que se crie a função primeiro e depois aplique via `lapply`. Veja abaixo:

``` r
f <- function(elem){
  elem[,1]
}

lapply (lista, f)
```

    ## $a
    ## [1] 1 2 3 4
    ## 
    ## $b
    ## [1] 1 2 3 4 5

Agora já não temos mais uma função anônima, uma vez que ela tem um nome (`f`). Se você define uma função ou usa uma função anônima depende do contexto. Se você pretende utilizar mais vezes a função ao longo do seu código, vale a pena criar a função. Por outro lado, se ela será usada apenas uma vez via `lapply` é mais conveniente usá-la como função anônima.

Função `sapply`
---------------

A função `sapply` funciona da mesma maneira que `lapply`, porém produz um resultado mais simplificado, em forma de vetor ou matriz. Essencialmente, `sapply` roda `lapply` internamente e altera apenas a apresentação do resultado.

-   Se cada elemento da lista tem comprimento = 1, retorna um vetor
-   Se cada elemento da lista tem comprimento &gt; 1, porém todos com o mesmo comprimento, retorna uma matriz
-   Se cada elemento da lista possui um comprimento diferente, então `sapply` retorna uma lista

Para comparar os resultados retornados pelas duas funções, vamos calcular a media das colunas em `airquality`

``` r
lapply(airquality, mean, na.rm = TRUE)
```

    ## $Ozone
    ## [1] 42.12931
    ## 
    ## $Solar.R
    ## [1] 185.9315
    ## 
    ## $Wind
    ## [1] 9.957516
    ## 
    ## $Temp
    ## [1] 77.88235
    ## 
    ## $Month
    ## [1] 6.993464
    ## 
    ## $Day
    ## [1] 15.80392

``` r
sapply(airquality, mean, na.rm = TRUE)
```

    ##      Ozone    Solar.R       Wind       Temp      Month        Day 
    ##  42.129310 185.931507   9.957516  77.882353   6.993464  15.803922

Como o resultado em `lapply` era uma lista de elementos com comprimento 1 `sapply` retorna um vetor como resultado, o que é frequentemente mais útil que uma lista.

Abaixo, utilizei a função `range` para extrair o valor mínimo e máximo de `airquality`. Como cada elemento do resultado de `lapply` tem comprimento maior que 1, `sapply` retorna uma matriz.

``` r
lapply(airquality, range, na.rm = TRUE)
```

    ## $Ozone
    ## [1]   1 168
    ## 
    ## $Solar.R
    ## [1]   7 334
    ## 
    ## $Wind
    ## [1]  1.7 20.7
    ## 
    ## $Temp
    ## [1] 56 97
    ## 
    ## $Month
    ## [1] 5 9
    ## 
    ## $Day
    ## [1]  1 31

``` r
sapply(airquality, range, na.rm = TRUE)
```

    ##      Ozone Solar.R Wind Temp Month Day
    ## [1,]     1       7  1.7   56     5   1
    ## [2,]   168     334 20.7   97     9  31

Função `split`
--------------

A função `split` pega um vetor ou um objeto e o divide em grupos determinados por um fator ou uma lista de fatores.

``` r
str(split)
```

    ## function (x, f, drop = FALSE, ...)

`split` possui 3 argumentos: \* `x`, é um vetor (ou lista) ou data frame \* `f` é um fator ou uma lista de fatores \* `drop` indica se níveis de fator vazios devem ser descartados

A função `split` é frequentemente usada em conjunto com `lapply` ou `sapply`. A ideia básica é que você pode pegar dados estruturados, dividí-los em subconjuntos baseados em uma variável e então aplicar uma função sobre esses subconjuntos. O resultado de aplicar uma função sobre esses subconjuntos é reuni-los e retorná-los como um objeto.

Vamos utilizar os dados de `airquality` para exemplificar. Podemos dividir `airqulity` por mês e então extrair médias de Ozonio, radiação solar e vento por mês.

``` r
s <- split(airquality, airquality$Month)
str(s)
```

    ## List of 5
    ##  $ 5:'data.frame':   31 obs. of  6 variables:
    ##   ..$ Ozone  : int [1:31] 41 36 12 18 NA 28 23 19 8 NA ...
    ##   ..$ Solar.R: int [1:31] 190 118 149 313 NA NA 299 99 19 194 ...
    ##   ..$ Wind   : num [1:31] 7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
    ##   ..$ Temp   : int [1:31] 67 72 74 62 56 66 65 59 61 69 ...
    ##   ..$ Month  : int [1:31] 5 5 5 5 5 5 5 5 5 5 ...
    ##   ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ 6:'data.frame':   30 obs. of  6 variables:
    ##   ..$ Ozone  : int [1:30] NA NA NA NA NA NA 29 NA 71 39 ...
    ##   ..$ Solar.R: int [1:30] 286 287 242 186 220 264 127 273 291 323 ...
    ##   ..$ Wind   : num [1:30] 8.6 9.7 16.1 9.2 8.6 14.3 9.7 6.9 13.8 11.5 ...
    ##   ..$ Temp   : int [1:30] 78 74 67 84 85 79 82 87 90 87 ...
    ##   ..$ Month  : int [1:30] 6 6 6 6 6 6 6 6 6 6 ...
    ##   ..$ Day    : int [1:30] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ 7:'data.frame':   31 obs. of  6 variables:
    ##   ..$ Ozone  : int [1:31] 135 49 32 NA 64 40 77 97 97 85 ...
    ##   ..$ Solar.R: int [1:31] 269 248 236 101 175 314 276 267 272 175 ...
    ##   ..$ Wind   : num [1:31] 4.1 9.2 9.2 10.9 4.6 10.9 5.1 6.3 5.7 7.4 ...
    ##   ..$ Temp   : int [1:31] 84 85 81 84 83 83 88 92 92 89 ...
    ##   ..$ Month  : int [1:31] 7 7 7 7 7 7 7 7 7 7 ...
    ##   ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ 8:'data.frame':   31 obs. of  6 variables:
    ##   ..$ Ozone  : int [1:31] 39 9 16 78 35 66 122 89 110 NA ...
    ##   ..$ Solar.R: int [1:31] 83 24 77 NA NA NA 255 229 207 222 ...
    ##   ..$ Wind   : num [1:31] 6.9 13.8 7.4 6.9 7.4 4.6 4 10.3 8 8.6 ...
    ##   ..$ Temp   : int [1:31] 81 81 82 86 85 87 89 90 90 92 ...
    ##   ..$ Month  : int [1:31] 8 8 8 8 8 8 8 8 8 8 ...
    ##   ..$ Day    : int [1:31] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ 9:'data.frame':   30 obs. of  6 variables:
    ##   ..$ Ozone  : int [1:30] 96 78 73 91 47 32 20 23 21 24 ...
    ##   ..$ Solar.R: int [1:30] 167 197 183 189 95 92 252 220 230 259 ...
    ##   ..$ Wind   : num [1:30] 6.9 5.1 2.8 4.6 7.4 15.5 10.9 10.3 10.9 9.7 ...
    ##   ..$ Temp   : int [1:30] 91 92 93 93 87 84 80 78 75 73 ...
    ##   ..$ Month  : int [1:30] 9 9 9 9 9 9 9 9 9 9 ...
    ##   ..$ Day    : int [1:30] 1 2 3 4 5 6 7 8 9 10 ...

O objeto `s` contem uma lista com subconjuntos de data frames separados por mês Podemos, agora, aplicar a função `sapply` para gerar as médias de `Ozone`, `Solar.R` e `Wind` para cada mês.

``` r
sapply(s, function(x){
  colMeans(x[,c("Ozone","Solar.R", "Wind")])
})
```

    ##                5         6          7        8        9
    ## Ozone         NA        NA         NA       NA       NA
    ## Solar.R       NA 190.16667 216.483871       NA 167.4333
    ## Wind    11.62258  10.26667   8.941935 8.793548  10.1800

Infelizmente há dados faltantes (`NA`s) em `airquality` e isso impede `colMeans` de retornar um valor médio. Podemos pedir para que `colMeans` remova os `NA`s antes de calcular a média incluindo o argumento `na.rm = TRUE`

``` r
sapply(s, function(x){
  colMeans(x[,c("Ozone","Solar.R", "Wind")],
           na.rm = TRUE)
})
```

    ##                 5         6          7          8         9
    ## Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
    ## Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
    ## Wind     11.62258  10.26667   8.941935   8.793548  10.18000

Função `tapply`
---------------

`taplly` é usado para aplicar uma função em subconjuntos de um vetor. Pode ser entendido como uma combinação de `split` e `sapply` aplicados apenas a vetores.

``` r
str(tapply)
```

    ## function (X, INDEX, FUN = NULL, ..., simplify = TRUE)

Os argumentos de `taplly` são:

-   `X`: é um vetor
-   `INDEX`: é um fator ou uma lista de fatores
-   `FUN`: é a função a ser aplicada
-   `...`: argumentos que podem ser aplicados à `FUN`
-   `simplify`: devemos simplificar o resultado?

Uma operação simples é extrair a média dos grupos em um vetor numérico.

``` r
tapply(airquality$Ozone, INDEX = airquality$Month, mean, na.rm = TRUE)
```

    ##        5        6        7        8        9 
    ## 23.61538 29.44444 59.11538 59.96154 31.44828

> Note que diferentemente do que fizemos com a combinação de `split` e `sapply` aqui informamos apenas um vetor como primeiro argumento, pois `tapply` não aceita mais de um vetor como dado de entrada. Perceba também que indicamos o argumento `na.rm = TRUE` que foi usado na função `mean`.

Função `apply`
--------------

A função `apply` é usada para aplicar uma função (geralmente uma anônima) sobre as margens de uma matriz. Uma matriz possui duas margens, uma margem representa as linhas e outra representa as colunas.

``` r
str(apply)
```

    ## function (X, MARGIN, FUN, ...)

Os argumentos de `apply`são:

-   `X` é uma matriz
-   `MARGIN` é um número que indica que margem deve ser considerada (1 = linhas, 2 = colunas)
-   `FUN` é a função a ser aplicada
-   `...`: argumentos que podem ser aplicados à `FUN`

Vamos criar uma matriz com 50 valores aleatórios entre 10 e 15, então extraímos a média de cada coluna.

``` r
m <- matrix(runif(50, 10, 15), 10, 5)
apply(m, 2, mean)
```

    ## [1] 12.13608 12.80259 12.44350 12.67017 12.96126

Podemos fazer a soma de cada linha também:

``` r
apply(m, 1, sum)
```

    ##  [1] 58.10275 62.19151 65.36754 59.65908 68.01745 65.73839 54.33801
    ##  [8] 61.96324 70.70561 64.05225

> Note que nos dois casos `apply` retornou um vetor numérico como resultado.

Média e soma de linhas/colunas
------------------------------

Em casos especiais de soma ou média de linhas/colunas existem funções de atalho:

-   `rowSums` = `apply(x, 1, sum)`
-   `rowMeans` = `apply(x, 1, mean)`
-   `colSums` = `apply(x, 2, sum)`
-   `colMeans` = `apply(x, 2, mean)`

As funções acima realizam a mesma tarefa, alguma diferença em relação ao tempo de computação poderá ser notado em grandes volumes de dados. Um aspecto interessante é que usar `colMeans` ao invés de `apply(x, 2, mean)` deixa seu código mais compreensível para quem o lê.

Função `mapply`
---------------

A função `mapply` é um tipo de `apply` multivariado que aplica uma função em paralelo sobre um conjunto de argumentos. Lembre-se que `lapply` e as funções irmãs interagem sobre um único objeto. Se você deseja uma iteração sobre múltiplos objetos do R em paralelo, `mapply` é desenhada para isso.

``` r
str(mapply)
```

    ## function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)

Os argumentos de `mapply` são:

-   `FUN` é a função a ser aplicada
-   `...` contém os objetos R em que será aplicada a função
-   `MoreArgs` é uma lista de outros argumento de `FUN`
-   `SIMPLIFY` indica se o resultado deve ser simplicadado

O uso de `mapply` é um pouco diferente das outras funções (como `lapply`) pois o primeiro argumento é uma função, ao invés de um objeto. Os objetos sobre os quais aplicamos a função são dados por `...` pois admite um número arbitrário de objetos.

Nos exemplos abaixo vamos explorar como a função `mapply` é útil quando desejamos simular dados alterando os paramêtros a cada simulação.

Exemplo 1: vamos criar uma lista que contenha dados aleatórios de distribução normal. Desejamos que a função gere 5 valores com média 5 e desvio padrão de 1 a 5.

``` r
mapply(rnorm, 5, 5, 1:5)
```

    ##          [,1]     [,2]      [,3]       [,4]       [,5]
    ## [1,] 3.782616 5.678138  9.884158 12.1274905  8.6853152
    ## [2,] 3.512011 3.382083  3.769903  0.2312697 -0.7253811
    ## [3,] 5.381752 7.741395  7.784132  4.9589955  2.2970560
    ## [4,] 5.747862 2.476091  2.566933  2.9402028  0.5554765
    ## [5,] 5.656420 5.246543 10.638058  6.4440282 -6.0673248

Isso passou o valor 5 para o primeiro e o segundo argumento de `rnorm` e a sequência `1:5` para o terceiro argumento de `rnom`.

Caso utilizássemos apenas a função `rnorm` com os argumentos configurados da mesma maneira este seria o resultado

``` r
rnorm(5, 5, 1:5)
```

    ## [1] 4.142037 5.259773 8.705171 9.099852 7.222000

A diferença é que para cada valor gerado a função `rnorm` utilizou um desvio padrão diferente.

Para gerar o resultado da função `mapply` deveríamos repetir a função `rnorm`, cada vez com um valor de desvio padrão diferente e uni-los em uma matriz. Ficaria assim:

``` r
matrix(c(rnorm(5, 5, 1),
         rnorm(5, 5, 2),
         rnorm(5, 5, 3),
         rnorm(5, 5, 4),
         rnorm(5, 5, 5)), 
       nrow = 5, ncol = 5)
```

    ##          [,1]     [,2]     [,3]      [,4]        [,5]
    ## [1,] 6.567593 5.840806 3.173540  5.444564 -0.04452862
    ## [2,] 5.312262 6.501611 8.062785 -2.039101  4.36699871
    ## [3,] 4.746929 3.205048 5.221110  5.240578  2.19477102
    ## [4,] 4.441257 8.663218 7.358360 -6.438797  4.12066929
    ## [5,] 5.337217 8.620375 7.477555  7.378145  3.72077674

Exemplo 2:

Gerar uma lista de repetições com valores de 1:4, repetidos 4, 3, 2 e 1 vez respectivamente.

Usando `mapply`

``` r
mapply(rep, 1:4, 4:1)
```

    ## [[1]]
    ## [1] 1 1 1 1
    ## 
    ## [[2]]
    ## [1] 2 2 2
    ## 
    ## [[3]]
    ## [1] 3 3
    ## 
    ## [[4]]
    ## [1] 4

Sem usar `mapply`

``` r
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
```

    ## [[1]]
    ## [1] 1 1 1 1
    ## 
    ## [[2]]
    ## [1] 2 2 2
    ## 
    ## [[3]]
    ## [1] 3 3
    ## 
    ## [[4]]
    ## [1] 4
