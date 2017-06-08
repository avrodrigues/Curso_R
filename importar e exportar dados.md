---
title: "Importar e exportar dados"
output: github_document
---



## Tabule os seus dados de maneira organizada

Há várias formas de tabular os dados de uma pesquisa, mas nem sempre a tabulação que lhe parece lógica esta organizada para que os programas que lidam com dados possam entende-los e processá-los. 
Ao tabular seus dados ordene as observações nas linhas e as variáveis em cada coluna. Por exemplo, estamos realizando um inventário florestal onde cada indivíduo amostrado é uma observação. Assim, cada linha da matriz de dados representa o indivíduo que tem um nome científico, foi coletado em tal parcela e tem um valor de circunferencia à altura do peito. Cada uma dessas caracteristicas é uma coluna. 


```r
library(knitr)
kable(exemplo.tabela)
```



|Espécie                 | Parcela|   CAP|
|:-----------------------|-------:|-----:|
|Euterpe edulis          |       1|  35.5|
|Ocotea catharinensis    |       1| 110.0|
|Euterpe edulis          |       2|  40.0|
|Alchornea triplinervia  |       1|  56.0|
|Hyeronima alchorneoides |       2|  42.5|

## Importar dados

Os dados podem ser importados em diferentes formatos `.txt` `.csv` `.xls` `.xlsx`. No entanto, para lidar com arquivos de excel é necessário instalar um pacote que lide com esta extenção (veremos isso mais a frente).  

Usuários iniciantes de R podem ter dificuldade em importar os dados o que acaba sendo desmotivador. 

Então aqui vão algumas dicas:  

* Certifique qual a extensão em que seus dados estão salvos  
* Certifique qual é o simbolo para decimal que está sendo usado (`.` ou `,`)  
* Certifique qual é o simbolo para a separação das colunas (`tabulação`, `;`, `.`), no caso de arquivos `.csv`ou `.txt` 
* Certifique qual a pasta de trabalho que o R está configurado (execute `getwd()`)   

Há algumas funções que executam a importação de dados como `read.table`, `read.csv` e `read.csv2`. Para arquivos em formato excel (`.xls`,`.xlsx`) uma opção é a função `read_excel` do pacote `readxl`.

## Importando dados com `read.table`

Para iniciar baixe o arquivo que utilizaremos neste exemplo [aqui](da_fom.csv) e salve na pasta de trabalho do R.

A função `read.table` é uma das mais utilizadas para ler dados. É importante ler a ajuda desta função (executando `?read.table`) pois é uma função muito utilizada. 

A função `read.table` tem alguns argumentos importantes:

* `file`, o nome do arquivo, ou o caminho para ele  
* `header`, lógica (`TRUE`ou `FALSE`) indicando se o arquivo uma linha com os nomes das variáveis  
* `row.names`, um vetor para os nomes das colunas. Se a primeira coluna dos seus dados são os nomes das observações, então use `row.names = 1`  
* `sep`, um caracter indicando o simbolo para separados das variáveis  
* `dec`, um caracter indicando o simbolo para decimais  
* `skip`, o número de linhas que você deseja pular do inicio do arquivo    
* `stringsAsFactors`, as variáveis de caracteres podem ser codificadas como fator? O **defalt** desse argumento é `TRUE`, então todos as variáveis que tiverem caracteres como valores serão tratadas como vetor do tipo fator. Se voce deseja que as variáveis com valores caracteres não seja tratada como fator indique como `FALSE`  

Para importar o arquivo baixado execute:

```r
FOM <- read.table("da_fom.csv", header = TRUE, row.names = 1, sep = ";", dec = ",")
dim(FOM)
```

```
## [1] 399 144
```

```r
View(FOM)
```





