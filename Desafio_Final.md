Desafio Final
================

Ordenação
---------

Neste desafio você vai analisar como as variáveis climáticas estão relaciondas com as comunidades vegetais do Vale do Itajai.

Para isso eu forneço duas matrizes para você:

1 - matriz de abundância (64 parcelas x 358 espécies) [espécies](vale do itajai.csv)  
2 - matriz ambiental (64 parcelas x 22 variáveis climáticas) [ambiente](env_world_Clim_v2.csv)

Conduza uma RDA entre a matriz de abundância e a matriz ambiental. Antes disso você deve selecionar algumas variáveis ambientais. Escolha 5 variáveis ambientais que você imagina que podem afetar as comunidades e realize a analise com base apenas nessas variavéis escolhidas.

A lista abaixo explica o que cada código de variável ambiental significa:

    bio1 = Temperatura anual média

    bio2 = Média da variação diurna (Média de temp max - temp min)

    bio3 = Isotermalidade (bio2/bio7) (* 100)

    bio4 = Sazonalidade da Temperatura  (Desvio padrão *100)

    bio5 = Temperatura máxima do mês mais quente

    bio6 = Temperatura do mês mais frio

    bio7 = Variação da temperatura anual (bio5-bio6)

    bio8 = Média de temperatura do trimestre mais úmido

    bio9 = Média de temperatura do trimestre mais seco

    bio10 = Média de temperatura do trimestre mais quente

    bio11 = Média de temperatura do trimestre mais frio

    bio12 = Precipitação anual

    bio13 = Precipitação do mês mais úmido

    bio14 = Precipitação do mês mais seco

    bio15 = Sazonalidade da precipitação (coeficiente de variação)

    bio16 = Precipitação do trimestre mais úmido

    bio17 = Precipitação do trimestre mais seco

    bio18 = Precipitação do trimestre mais quente

    bio19 = Precipitação do trimestre mais frio

    Vapor.anualMean = Média anual de pressão de vapor de agua

    solarRad.anualMean  = Média anual de radiação solar

    wind.anualMean = Média Anual de velociadade do vento
