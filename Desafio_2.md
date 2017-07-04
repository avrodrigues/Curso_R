Desafio 2
================

Manipulação e exploração de dados
=================================

A proposta aqui é utilizar um banco de dados já publicado para exercitar a manipulação de dados, a geração de novos data frames e de estatísticas descritivas.

Para isso, utilizaremos dados do artigo *Tree Diversity and Dynamics of the Forest of Seu Nico, Viçosa, Minas Gerais, Brazil* (Gastauer et al 2015) que você pode conferir [aqui](http://bdj.pensoft.net/article/5425/list/5/).

Em suma, este artigo disponibiliza dados de parcelas permanentes em uma área total de 1 ha, dividida em 100 subparcelas de 10 x 10 m. A área foi inventariada em 2001 e em 2010.

O desafio é gerar dois data frames, um com dados de 2001 e outro com dados de 2010.

Cada data frame deve conter os indivíduos como linhas e três colunas.
As colunas devem ter como nome:

-   `spp`: nome da espécie observada
-   `parc`: a subparcela onde o indivíduo foi amostrado
-   `dap`: diâmetro à altura do peito para cada indivíduo

Com os dois data frames criados, gere a média do diâmetro à altura do peito para cada espécie em cada ano de medição.

Ao final do desafio você terá 4 produtos:

-   data frame de 2001
-   data frame de 2010
-   média de dap por espécie para 2001
-   média de dap por espécie para 2010

Instruções
----------

Baixe e extraia para a pasta de trabalho do R o Material Suplementar 2 do artigo. ([link para o artigo](http://bdj.pensoft.net/article/5425/list/5/))

Para realizar o desafio utilizaremos apenas os arquivos `measurementorfact.txt` e `occurrence.txt`.

O arquivo `measurementorfact.txt` contém:

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

O arquivo `occurrence.txt` possui 34 colunas, aqui descrevo o conteúdo de algumas colunas que podem ser úteis para a realização do desafio:

| Nome da coluna    | Descrição                         |
|-------------------|-----------------------------------|
| id                | Código do indíviduo               |
| occurrenceID      | Código da ocorrência              |
| occurrenceRemarks | Indica a subparcela da ocorrência |
| eventDate         | Data do evento                    |
| scientificName    | Nome científico                   |

Note que você precisa extrair dados dos dois arquivos e depois criar um data frame com `spp` `parc` e `dap`.

Há diversas abordagens para realizar esta tarefa. Porém, eu sugiro que você:

1.  crie uma nova variável para `measurementorfact.txt` com apenas o ano de amostragem
2.  selecione os dados com base no ano
3.  utilize o `id` desta seleção para extrair o nome científico e a subparcela em `occurrence.txt`
4.  crie o data frame final para o ano selecionado.

As funções do pacote `dplyr` serão muito úteis nessa atividade.

### Dicas

#### Dica 1

A função `substr` pode ser útil para criar uma variável que contenha apenas o ano da data de amostragem. Esta função extrai parte de um vetor de caracteres. Funciona assim:

``` r
str(substr)
```

    ## function (x, start, stop)

onde:
`x` é um vetor de caracteres
`start` é a posição onde inicia a seleção/extração
`stop` é a posição onde finaliza a seleção/extração

Exemplo:

``` r
vegetacao <- c("Floresta Ombrófila Densa", 
               "Floresta Ombrófila Mista", 
               "Floresta Estacional Decidual", 
               "Restinga")
substr(vegetacao, 1, 8)
```

    ## [1] "Floresta" "Floresta" "Floresta" "Restinga"

#### Dica 2

Você pode criar um data frame utilizando valores disponíveis em outros objetos usando a função `data.frame` e nomear as colunas diretamente na função `data.frame`.

Veja o exemplo:

``` r
# criando objetos exemplo
dados1 <- data.frame(a = 1:3, b = 50:52)
dados2 <- data.frame(nomes = c("aaa", "bbb", "c"), 
                               valor = c(0.1, 0.5, 10))

# Novo data frame com valores dos objetos criados acima
dados.final <- data.frame(letras = dados2$nomes, cod = dados1$a, valor = dados2$valor)

dados.final
```

    ##   letras cod valor
    ## 1    aaa   1   0.1
    ## 2    bbb   2   0.5
    ## 3      c   3  10.0
