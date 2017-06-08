Importar e exportar dados
================

Tabule os seus dados de maneira organizada
------------------------------------------

Há várias formas de tabular os dados de uma pesquisa, mas nem sempre a tabulação que lhe parece lógica esta organizada de maneira que os programas possam entender e processar os dados.   
Ao tabular seus dados ordene as observações nas linhas e as variáveis em cada coluna.  
Por exemplo, estamos realizando um inventário florestal onde cada indivíduo amostrado é uma observação. Assim, cada linha da tabela representa o indivíduo que tem um nome científico, foi coletado em tal parcela e tem um valor de circunferencia à altura do peito. Cada uma dessas caracteristicas será uma coluna da sua tabela.  

| Espécie                 |  Parcela|    CAP|
|:------------------------|--------:|------:|
| Euterpe edulis          |        1|   35.5|
| Ocotea catharinensis    |        1|  110.0|
| Euterpe edulis          |        2|   40.0|
| Alchornea triplinervia  |        1|   56.0|
| Hyeronima alchorneoides |        2|   42.5|

Importar dados
--------------

Os dados podem ser importados em diferentes formatos `.txt` `.csv` `.xls` `.xlsx`. No entanto, para importar arquivos de excel é necessário instalar um pacote que lide com esta extenção (veremos isso mais a frente).

Usuários iniciantes de R podem ter dificuldade em importar os dados o que acaba sendo desmotivador.

Então aqui vão algumas dicas:

-   Verifique qual é a extensão em que seus dados estão salvos
-   Verifique qual é o simbolo para decimal que está sendo usado (`.` ou `,`)
-   Verifique qual é o simbolo para a separação das colunas (`tabulação`, `;`, `.`), no caso de arquivos `.csv`ou `.txt`
-   Verifique qual a pasta de trabalho que o R está configurado (execute `getwd()`)

Há algumas funções que executam a importação de dados como `read.table`, `read.csv` e `read.csv2`. Para arquivos em formato excel (`.xls`,`.xlsx`) uma opção é a função `read_excel` do pacote `readxl`.

Importando dados com `read.table`
---------------------------------

Para iniciar baixe o arquivo que utilizaremos neste exemplo [aqui](da_fom.csv) e salve na pasta de trabalho do R.

A função `read.table` é uma das mais utilizadas para ler dados. É importante ler a ajuda desta função (executando `?read.table`) pois é uma função muito utilizada. Faça isso antes de prosseguir com o texto.

A função `read.table` tem alguns argumentos importantes:

-   `file`, o nome do arquivo, ou o caminho para ele. Você pode utilizar a função `file.choose()` neste argumento. Esta função abre uma caixa de diálogo onde você pode selecionar o arquivo deseajdo.
-   `header`, lógica (`TRUE`ou `FALSE`) indicando se o arquivo possui uma linha com os nomes das variáveis
-   `row.names`, um vetor para os nomes das colunas. Se a primeira coluna dos seus dados são os nomes das observações, então use `row.names = 1`
-   `sep`, um caracter indicando o simbolo para separador das variáveis (colunas)
-   `dec`, um caracter indicando o simbolo para decimais
-   `skip`, o número de linhas que você deseja pular do inicio do arquivo
-   `stringsAsFactors`, as variáveis de caracteres podem ser codificadas como fator? O *defalt* desse argumento é `TRUE`, então todos as variáveis que tiverem caracteres como valores serão tratadas como vetor do tipo fator. Se voce deseja que as variáveis com valores caracteres não seja tratada como fator indique como `FALSE`

Com o arquivo na pasta de trabalho do R, execute o comando abaixo para importar os dados.

``` r
FOM <- read.table("da_fom.csv", header = TRUE, row.names = 1, sep = ";", dec = ",")
```

Utilizando a função `file.choose()` o código fica assim:

``` r
FOM <- read.table(file.choose(), header = TRUE, row.names = 1, sep = ";", dec = ",")
```

Funções `read.csv`e `read.csv2`
-------------------------------

As funções `read.csv`e `read.csv2` são destinadas a importar apenas arquivos `.csv`. A diferença entre as duas função está na configuração padrão dos argumentos `dec` e `sep`.

Estes argumentos merecem muita atenção pois são os principais causadores de erros ao importar dados.

A função `read.csv` tem por pardrão `sep = ","` e `dec = "."`
A função `read.csv2` tem por pardrão `sep = ";"` e `dec = ","`

Além disso, o argumento `header` está preconfigurado como `TRUE`.

Isso tudo facilita na hora de importar seus dados, tanto por poupar tempo para configurar cada argumento citado, como para deixar o código mais fácil de ser entendido, mais intuitivo pra quem lê.

Como os dados que importamos com a função `read.table` tinham separadores `;` e decimais `,` podemos usar a função `read.csv2` como abaixo:

``` r
FOM <- read.csv2("da_fom.csv", row.names = 1)
```

Importando arquivos `.xls` ou `.xlsx`
-------------------------------------

Para importar dados de arquivos de formato Excel (`.xls` ou `.xlsx`) é necessário instalar e carregar algum pacote que realize essa função. Aqui utilizaremos a função `read_excel` do pacote `readxl` .

Veja como estão configurados os argumentos da função `read_excel` no painel de ajuda.
Baixe [esses dados em .zip](FMA.zip), e extraia na pasta de trabalho atual do R. Dê uma olhadinha em como os dados estão tabulados.

Para importar dados, primeiro instale e carrege o pacote:

``` r
install.packages("readxl")
library(readxl)
```

Então rode a função `read_excel`

``` r
read_excel("Espécies_chuvoso.xlsx", sheet = 1, skip = 3)
```

Exportar dados
--------------

Para extrair dados usamos a função `write.table`. Com ela criamos um arquivo na pasta de trabalho do R, que pode ser criado em diversos formatos, inclusive formatos para excel.

Veja a seção **Usage** da ajuda desta função.

As funções `write.csv`e `write.csv2(...)` possuem as mesmas configurações de decimais e separadores que seus parentes `read.csv`e `read.csv2`.

Execute o código abaixo para gerar o objeto `dados1`:

``` r
dados1 <- structure(list(a = 1:10, 
                         b = c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
                               FALSE, FALSE, FALSE), 
                         z = structure(c(1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L),
                                       .Label = c("a", "b"), class = "factor")),
                    .Names = c("a", "b", "z"), row.names = c(NA, -10L), 
                    class = "data.frame")
```

Agora salve os dados com:

``` r
write.table(dados1, "dados1.xlsx", sep = "\t", dec = ",")
```

Abra o arquivo e veja como ficou.
Feche o arquivo.

Agora inclua no código anterior o argumento `row.names` configurado como `FALSE`.

Veja novamente como ficou o arquivo.
