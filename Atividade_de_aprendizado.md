Atividade de aprendizado
================

### Objetos e o ambiente global

Comandos básicos:

**No Script:**

`Ctrl + R` (Windons) ou `Ctrl/Command + ENTER` (Linux/mac) - *Executa o comando. Executa a linha de código ou somente o campo selecionado.*

`Shift + Seta para cima/baixo` - *Seleciona uma linha de código*

`Ctrl + Shift + Seta para direita/esquerda` - *Seleciona por blocos de código*

**No Console:**

`ENTER` - *Executa um comando*

`Seta para cima` - *recupera comandos já executados*

Atividades:

1 - Depois de [baixar](https://github.com/avrodrigues/avrodrigues.github.io/blob/master/Aula%201/script_inicial.R) e abrir o script no RStudio, execute todos os comandos.

2 - Observe que no campo do ambiente global foram criados objetos, separados por tipo (**data**, **values**). São listados neste campo informações básicas sobre os objetos.

3 - Algumas funções podem ser utilizadas para colher informações sobre os dados. Como o comprimento do objeto, as dimensões de uma tabela ou matriz, a classe a que o objeto pertence ou ainda a estrutura do objeto. Utilize as funções abaixo com todos os objetos criados pelo script para entender como elas funcionam:

`length(x)`  
`dim(x)`  
`str(x)`  
`class(x)`  
`ncol(x)`  
`nrow(x)`  

4 - Operações de cálculo básicas podem ser realizadas com o R utilizando os simbolos `+`, `-`, `*` e `/`. Exponenciais são precedidos de `^`.

**Exemplo:**

`2 * 5`  
`10 + 50`  
`10 / 2`  
`2^2`  

Essas operações podem ser utilizadas com os objetos também (`a * 2`, por exemplo) Com isso em mente realize as seguintes operações:

`dados * 2`  
`a + 10`  
`x * 5`  

Relate o que aconteceu em cada operação. Porque uma delas deu erro?

5 - Observe como se deu a criação de cada objeto presente no script. Em comum todas utilizaram o simbolo `<-`, esse símbolo assinala os valores ou caracteres a um objeto. Algumas funções foram utilizadas para a criação dos objetos. Pesquise a ajuda das funções abaixo para entender como elas funcionam e se habituar a utilizar o painel de ajuda.

`c`  
`rep`  
`as.factor`  
`rnorm`  
`matrix`  
`data.frame`  

Para acessar a ajuda digite ‘?’ antes do nome da função e execute o comando, como no exemplo:

`?as.factor`

6 - Crie um objeto do tipo data frame com nome `info`. Nomeie as colunas como abaixo e assinale as informações necessárias em cada coluna.

Nomes das colunas: `Nome`, `Cidade_Natal`, `Graduação`, `Área_de_pesquisa`, `Conhece_o_R`

7 - Gere 10 valores aleatórios entre 10 e 50, nomeie o objeto como `aleatorio`. Utilize o [Cheat Sheet do Base R](https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf) como guia básico para extrair a média e o desvio padrão deste conjunto de dados.

8 - Use a função `seq` para criar uma sequência, somente com números pares de 10 a 29. Nomeie esse objeto como `sequencia`.

9 - Crie um objeto chamado `categorias` com as categorias baixo, médio e alto repetidas 3, 3 e 4 vezes, respectivamente.

10 - Utilizando a função `data.frame` crie um objeto chamado `tabela` que contenha como colunas os objetos criados anteriormente: `aleatorio`, `sequencia` e `categorias`.
