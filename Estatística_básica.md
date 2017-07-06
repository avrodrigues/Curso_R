Estatística básica
================

A idéia desse seção é apresentar como rodar análises estatísticas e como utilizar os resultados, assim como apresentar as funções que testam alguns pressupostos das estatísticas paramétricas.

Neste sentido, demostrarei com fazer Teste-T, Anova, Teste de Tukey, Teste de Correlação e Regressão Linear.

Teste T
-------

O teste T é conduzido no R com a função `t.test`.

Para exemplificar, vamos comparar utilizar os dados de captura de CO2 da por *Echinochloa crus-galli* de acordo com a origem da planta.

``` r
data("CO2")
str(CO2)
```

    ## Classes 'nfnGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':   84 obs. of  5 variables:
    ##  $ Plant    : Ord.factor w/ 12 levels "Qn1"<"Qn2"<"Qn3"<..: 1 1 1 1 1 1 1 2 2 2 ...
    ##  $ Type     : Factor w/ 2 levels "Quebec","Mississippi": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Treatment: Factor w/ 2 levels "nonchilled","chilled": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ conc     : num  95 175 250 350 500 675 1000 95 175 250 ...
    ##  $ uptake   : num  16 30.4 34.8 37.2 35.3 39.2 39.7 13.6 27.3 37.1 ...
    ##  - attr(*, "formula")=Class 'formula'  language uptake ~ conc | Plant
    ##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
    ##  - attr(*, "outer")=Class 'formula'  language ~Treatment * Type
    ##   .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
    ##  - attr(*, "labels")=List of 2
    ##   ..$ x: chr "Ambient carbon dioxide concentration"
    ##   ..$ y: chr "CO2 uptake rate"
    ##  - attr(*, "units")=List of 2
    ##   ..$ x: chr "(uL/L)"
    ##   ..$ y: chr "(umol/m^2 s)"

Antes de aplicar o teste T, devemos saber se há homegeneidade das variâncias. Para isso, aplicamos a função `leveneTest` do pacote `car`

``` r
library(car)
leveneTest(CO2$uptake ~ CO2$Type)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##       Df F value Pr(>F)
    ## group  1  0.1704 0.6808
    ##       82

No resultado acima `Pr(>F)` refere-se ao valor de p. Caso for significativo, abaixo de 0,05, consideramos que NÂO há homogeneidade das variâncias.

Como nossos dados poussem variâncias homogêneas, devemos incluir o argumento `var.equal = TRUE` na função `t.test`. Caso contrário, não há necessidade de informar o argumento `var.equal`

``` r
t <- t.test(CO2$uptake ~ CO2$Type, var.equal = TRUE)
t
```

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  CO2$uptake by CO2$Type
    ## t = 6.5969, df = 82, p-value = 3.835e-09
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##   8.84200 16.47705
    ## sample estimates:
    ##      mean in group Quebec mean in group Mississippi 
    ##                  33.54286                  20.88333

O teste nos mostrou que temos diferenças na captura de CO2 entre os locais. Vamos visualizar os dados com um boxplot. E adicionamos uma legenda para informar os resultados do teste T.

``` r
boxplot(CO2$uptake ~ CO2$Type)
```

![](Estatística_básica_files/figure-markdown_github/unnamed-chunk-4-1.png)
