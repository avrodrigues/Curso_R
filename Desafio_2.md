Desafio 2
================

Manipulação e exploração de dados
=================================

A proposta aqui é utilizar um banco de dados já publicado para exercitar a manipulação de dados, a geração de novos data frames e de estatísticas descritivas.

Para isso, utilizaremos dados do artigo *Tree Diversity and Dynamics of the Forest of Seu Nico, Viçosa, Minas Gerais, Brazil* (Gastauer et al 2015) que você pode conferir [aqui](http://bdj.pensoft.net/article/5425/list/5/). Baixe e extraia para a pasta de trabalho do R o Material Suplementar 2.

Resumindo, este artigo disponibiliza dados de parcelas permanentes em uma área total de 1 ha, dividida em 100 subparcelas de 10 x 10 m. A área foi inventariada em 2001 e em 2010.

O desafio é gerar dois data frames, um com dados de 2001 e com dados de 2010. Cada data frame deve conter os indivíduos como linhas e três colunas.
As colunas devem ter como nome:

-   spp: nome da espécie observada
-   parc: a subparcela onde o indivíduo foi amostrado
-   dap: diâmetro à altura do peito para cada indíviduo

Com os dois data frames criados, gere a média do diâmetro da altura do peito para cada espécie em cada ano de medição.

Ao final do desafio você terá 4 produtos:

-   data frame de 2001
-   data frame de 2010
-   média de dap por espécie para 2001
-   média de dap por espécie para 2010

Instruções
----------

Baixe e extraia para a pasta de trabalho do R o Material Suplementar 2 do artigo. ([link para o artigo](http://bdj.pensoft.net/article/5425/list/5/))

Para realizar o desafio utilizaremos apenas os arquivos `measurementorfact.txt` e `occurrence.txt`.

`measurementorfact.txt` contém:

| Nome da coluna            | Descrição                     |
|---------------------------|-------------------------------|
| id                        | Código do indíviduo           |
| measurementID             | Código da medição             |
| measurementType           | Tipo de medição               |
| measurementValue          | Valor da medição              |
| measurementUnit           | Unidade de medida             |
| measurementDeterminedDate | Data da medição               |
| measurementMethod         | Método de medição             |
| measurementRemarks        | Observações sobre as medições |

`occurrence.txt` possui 34 colunas, aqui descrevo o conteúdo de algumas colunas que podem ser úteis para a realização do desafio:

| Nome da coluna    | Descrição                         |
|-------------------|-----------------------------------|
| id                | Código do indíviduo               |
| occurrenceID      | Código da ocorrência              |
| occurrenceRemarks | Indica a subparcela da ocorrência |
| eventDate         | Data do evento                    |
| scientificName    | Nome científico                   |

### Dicas

A função `substr` pode ser útil para criar uma variável que contenha apenas o ano da data de amostragem. Esta função extrai parte de um vetor de caracteres. Funciona assim:

``` r
str(substr)
```

    ## function (x, start, stop)

onde:
`x` é um vetor de caracteres
`start` é a posição onde inicia a seleção/extração
`end` é a posição onde finaliza a seleção/extração

Exemplo:

``` r
vegetacao <- c("Floresta Ombrófila Densa", 
               "Floresta Ombrófila Mista", 
               "Floresta Estacional Decidual", 
               "Restinga")
substr(vegetacao, 1, 8)
```

    ## [1] "Floresta" "Floresta" "Floresta" "Restinga"
