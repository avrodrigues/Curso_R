Transformações
================

Dependendo dos dados que você está utiliznado para fazer uma ordenação é necessário seja realizado alguma transformação dos dados ou ainda a padronização deles.

Dados de abundância de espécies
===============================

Quando utilizamos dados de contagem de espécie (abundância) para ordenar parcelas, um tipo de dado muito comum em ecologia, devemos transformar os dados previamente pois esse tipo de analise é sensível a presença de duplos zeros nas colunas. Neste caso, é recomendado fazer uma transformação de Hellinger par prossegir com as analises.

A função `decostand` do pacote vegan realiza essa e outras transformações.

Vamos usar os dados de espécies de `varespec`.

``` r
# Carregue o pacote vegan
library(vegan)

# carregue os dados de espécies
data("varespec")
spe <- varespec
spe.h <- decostand(spe, "hel")
```

Realize as analises de ordenação com base nos dados transformados.

Dados ambientais
================

Quando usamos dados ambientais para correlacionar com o gradiente revelado pela ordenação frequentemente os dados ambientais foram medidos em diferentes unidades de medida. Por exemplo, temperatura é medida em ºC e precipitação em mm. Neste caso, devemos padronizar as variáveis. A padronização também é executada via função `decostand`.

Como exemplo, vamos utilizar os dados ambientais de `varechem`.

``` r
# Carregue os dados ambientais
data("varechem")
env <- varechem
env.stand <- decostand(env, "stand") 
```

Reduzir o nome das espécies
===========================

Os nomes científicos devem ser abreviados para que a representação gráfica fique mais limpa. Como geralmente as ordenações são realizadas com base em umuitas espécies que descrevem as parcelas, quando esses nomes são plotados no gráfico geralmete há muita sobreposição. Costuma-se, então, reduzir o nome das espécie para 8 caracteres. Assim, mantemos os primeiros 4 caracteres do genero e os primeiros 4 caracteres do epíteto. Isso é feito com facilidade com a função `make.cepnames` também do pacote vegan.

Vejamos como isso funciona com os dados de `BCI`.

``` r
data("BCI")
names(BCI)
```

    ##   [1] "Abarema.macradenia"               "Vachellia.melanoceras"           
    ##   [3] "Acalypha.diversifolia"            "Acalypha.macrostachya"           
    ##   [5] "Adelia.triloba"                   "Aegiphila.panamensis"            
    ##   [7] "Alchornea.costaricensis"          "Alchornea.latifolia"             
    ##   [9] "Alibertia.edulis"                 "Allophylus.psilospermus"         
    ##  [11] "Alseis.blackiana"                 "Amaioua.corymbosa"               
    ##  [13] "Anacardium.excelsum"              "Andira.inermis"                  
    ##  [15] "Annona.spraguei"                  "Apeiba.glabra"                   
    ##  [17] "Apeiba.tibourbou"                 "Aspidosperma.desmanthum"         
    ##  [19] "Astrocaryum.standleyanum"         "Astronium.graveolens"            
    ##  [21] "Attalea.butyracea"                "Banara.guianensis"               
    ##  [23] "Beilschmiedia.pendula"            "Brosimum.alicastrum"             
    ##  [25] "Brosimum.guianense"               "Calophyllum.longifolium"         
    ##  [27] "Casearia.aculeata"                "Casearia.arborea"                
    ##  [29] "Casearia.commersoniana"           "Casearia.guianensis"             
    ##  [31] "Casearia.sylvestris"              "Cassipourea.guianensis"          
    ##  [33] "Cavanillesia.platanifolia"        "Cecropia.insignis"               
    ##  [35] "Cecropia.obtusifolia"             "Cedrela.odorata"                 
    ##  [37] "Ceiba.pentandra"                  "Celtis.schippii"                 
    ##  [39] "Cespedesia.spathulata"            "Chamguava.schippii"              
    ##  [41] "Chimarrhis.parviflora"            "Maclura.tinctoria"               
    ##  [43] "Chrysochlamys.eclipes"            "Chrysophyllum.argenteum"         
    ##  [45] "Chrysophyllum.cainito"            "Coccoloba.coronata"              
    ##  [47] "Coccoloba.manzinellensis"         "Colubrina.glandulosa"            
    ##  [49] "Cordia.alliodora"                 "Cordia.bicolor"                  
    ##  [51] "Cordia.lasiocalyx"                "Coussarea.curvigemma"            
    ##  [53] "Croton.billbergianus"             "Cupania.cinerea"                 
    ##  [55] "Cupania.latifolia"                "Cupania.rufescens"               
    ##  [57] "Cupania.seemannii"                "Dendropanax.arboreus"            
    ##  [59] "Desmopsis.panamensis"             "Diospyros.artanthifolia"         
    ##  [61] "Dipteryx.oleifera"                "Drypetes.standleyi"              
    ##  [63] "Elaeis.oleifera"                  "Enterolobium.schomburgkii"       
    ##  [65] "Erythrina.costaricensis"          "Erythroxylum.macrophyllum"       
    ##  [67] "Eugenia.florida"                  "Eugenia.galalonensis"            
    ##  [69] "Eugenia.nesiotica"                "Eugenia.oerstediana"             
    ##  [71] "Faramea.occidentalis"             "Ficus.colubrinae"                
    ##  [73] "Ficus.costaricana"                "Ficus.insipida"                  
    ##  [75] "Ficus.maxima"                     "Ficus.obtusifolia"               
    ##  [77] "Ficus.popenoei"                   "Ficus.tonduzii"                  
    ##  [79] "Ficus.trigonata"                  "Ficus.yoponensis"                
    ##  [81] "Garcinia.intermedia"              "Garcinia.madruno"                
    ##  [83] "Genipa.americana"                 "Guapira.myrtiflora"              
    ##  [85] "Guarea.fuzzy"                     "Guarea.grandifolia"              
    ##  [87] "Guarea.guidonia"                  "Guatteria.dumetorum"             
    ##  [89] "Guazuma.ulmifolia"                "Guettarda.foliacea"              
    ##  [91] "Gustavia.superba"                 "Hampea.appendiculata"            
    ##  [93] "Hasseltia.floribunda"             "Heisteria.acuminata"             
    ##  [95] "Heisteria.concinna"               "Hirtella.americana"              
    ##  [97] "Hirtella.triandra"                "Hura.crepitans"                  
    ##  [99] "Hieronyma.alchorneoides"          "Inga.acuminata"                  
    ## [101] "Inga.cocleensis"                  "Inga.goldmanii"                  
    ## [103] "Inga.laurina"                     "Inga.semialata"                  
    ## [105] "Inga.nobilis"                     "Inga.oerstediana"                
    ## [107] "Inga.pezizifera"                  "Inga.punctata"                   
    ## [109] "Inga.ruiziana"                    "Inga.sapindoides"                
    ## [111] "Inga.spectabilis"                 "Inga.umbellifera"                
    ## [113] "Jacaranda.copaia"                 "Lacistema.aggregatum"            
    ## [115] "Lacmellea.panamensis"             "Laetia.procera"                  
    ## [117] "Laetia.thamnia"                   "Lafoensia.punicifolia"           
    ## [119] "Licania.hypoleuca"                "Licania.platypus"                
    ## [121] "Lindackeria.laurina"              "Lonchocarpus.heptaphyllus"       
    ## [123] "Luehea.seemannii"                 "Macrocnemum.roseum"              
    ## [125] "Maquira.guianensis.costaricana"   "Margaritaria.nobilis"            
    ## [127] "Marila.laxiflora"                 "Maytenus.schippii"               
    ## [129] "Miconia.affinis"                  "Miconia.argentea"                
    ## [131] "Miconia.elata"                    "Miconia.hondurensis"             
    ## [133] "Mosannona.garwoodii"              "Myrcia.gatunensis"               
    ## [135] "Myrospermum.frutescens"           "Nectandra.cissiflora"            
    ## [137] "Nectandra.lineata"                "Nectandra.purpurea"              
    ## [139] "Ochroma.pyramidale"               "Ocotea.cernua"                   
    ## [141] "Ocotea.oblonga"                   "Ocotea.puberula"                 
    ## [143] "Ocotea.whitei"                    "Oenocarpus.mapora"               
    ## [145] "Ormosia.amazonica"                "Ormosia.coccinea"                
    ## [147] "Ormosia.macrocalyx"               "Pachira.quinata"                 
    ## [149] "Pachira.sessilis"                 "Perebea.xanthochyma"             
    ## [151] "Cinnamomum.triplinerve"           "Picramnia.latifolia"             
    ## [153] "Piper.reticulatum"                "Platymiscium.pinnatum"           
    ## [155] "Platypodium.elegans"              "Posoqueria.latifolia"            
    ## [157] "Poulsenia.armata"                 "Pourouma.bicolor"                
    ## [159] "Pouteria.fossicola"               "Pouteria.reticulata"             
    ## [161] "Pouteria.stipitata"               "Prioria.copaifera"               
    ## [163] "Protium.costaricense"             "Protium.panamense"               
    ## [165] "Protium.tenuifolium"              "Pseudobombax.septenatum"         
    ## [167] "Psidium.friedrichsthalianum"      "Psychotria.grandis"              
    ## [169] "Pterocarpus.rohrii"               "Quararibea.asterolepis"          
    ## [171] "Quassia.amara"                    "Randia.armata"                   
    ## [173] "Sapium.broadleaf"                 "Sapium.glandulosum"              
    ## [175] "Schizolobium.parahyba"            "Senna.dariensis"                 
    ## [177] "Simarouba.amara"                  "Siparuna.guianensis"             
    ## [179] "Siparuna.pauciflora"              "Sloanea.terniflora"              
    ## [181] "Socratea.exorrhiza"               "Solanum.hayesii"                 
    ## [183] "Sorocea.affinis"                  "Spachea.membranacea"             
    ## [185] "Spondias.mombin"                  "Spondias.radlkoferi"             
    ## [187] "Sterculia.apetala"                "Swartzia.simplex.var.grandiflora"
    ## [189] "Swartzia.simplex.continentalis"   "Symphonia.globulifera"           
    ## [191] "Handroanthus.guayacan"            "Tabebuia.rosea"                  
    ## [193] "Tabernaemontana.arborea"          "Tachigali.versicolor"            
    ## [195] "Talisia.nervosa"                  "Talisia.princeps"                
    ## [197] "Terminalia.amazonia"              "Terminalia.oblonga"              
    ## [199] "Tetragastris.panamensis"          "Tetrathylacium.johansenii"       
    ## [201] "Theobroma.cacao"                  "Thevetia.ahouai"                 
    ## [203] "Tocoyena.pittieri"                "Trattinnickia.aspera"            
    ## [205] "Trema.micrantha"                  "Trichanthera.gigantea"           
    ## [207] "Trichilia.pallida"                "Trichilia.tuberculata"           
    ## [209] "Trichospermum.galeottii"          "Triplaris.cumingiana"            
    ## [211] "Trophis.caucana"                  "Trophis.racemosa"                
    ## [213] "Turpinia.occidentalis"            "Unonopsis.pittieri"              
    ## [215] "Virola.multiflora"                "Virola.sebifera"                 
    ## [217] "Virola.surinamensis"              "Vismia.baccifera"                
    ## [219] "Vochysia.ferruginea"              "Xylopia.macrantha"               
    ## [221] "Zanthoxylum.ekmanii"              "Zanthoxylum.juniperinum"         
    ## [223] "Zanthoxylum.panamense"            "Zanthoxylum.setulosum"           
    ## [225] "Zuelania.guidonia"

``` r
make.cepnames(names(BCI))
```

    ##   [1] "Abarmacr" "Vachmela" "Acaldive" "Acalmacr" "Adeltril" "Aegipana"
    ##   [7] "Alchcost" "Alchlati" "Alibedul" "Allopsil" "Alseblac" "Amaicory"
    ##  [13] "Anacexce" "Andiiner" "Annospra" "Apeiglab" "Apeitibo" "Aspidesm"
    ##  [19] "Astrstan" "Astrgrav" "Attabuty" "Banaguia" "Beilpend" "Brosalic"
    ##  [25] "Brosguia" "Calolong" "Caseacul" "Casearbo" "Casecomm" "Caseguia"
    ##  [31] "Casesylv" "Cassguia" "Cavaplat" "Cecrinsi" "Cecrobtu" "Cedrodor"
    ##  [37] "Ceibpent" "Celtschi" "Cespspat" "Chamschi" "Chimparv" "Macltinc"
    ##  [43] "Chryecli" "Chryarge" "Chrycain" "Cocccoro" "Coccmanz" "Coluglan"
    ##  [49] "Cordalli" "Cordbico" "Cordlasi" "Couscurv" "Crotbill" "Cupacine"
    ##  [55] "Cupalati" "Cuparufe" "Cupaseem" "Dendarbo" "Desmpana" "Diosarta"
    ##  [61] "Diptolei" "Drypstan" "Elaeolei" "Entescho" "Erytcost" "Erytmacr"
    ##  [67] "Eugeflor" "Eugegala" "Eugenesi" "Eugeoers" "Faraocci" "Ficucolu"
    ##  [73] "Ficucost" "Ficuinsi" "Ficumaxi" "Ficuobtu" "Ficupope" "Ficutond"
    ##  [79] "Ficutrig" "Ficuyopo" "Garcinte" "Garcmadr" "Geniamer" "Guapmyrt"
    ##  [85] "Guarfuzz" "Guargran" "Guarguid" "Guatdume" "Guazulmi" "Guetfoli"
    ##  [91] "Gustsupe" "Hampappe" "Hassflor" "Heisacum" "Heisconc" "Hirtamer"
    ##  [97] "Hirttria" "Huracrep" "Hieralch" "Ingaacum" "Ingacocl" "Ingagold"
    ## [103] "Ingalaur" "Ingasemi" "Inganobi" "Ingaoers" "Ingapezi" "Ingapunc"
    ## [109] "Ingaruiz" "Ingasapi" "Ingaspec" "Ingaumbe" "Jacacopa" "Laciaggr"
    ## [115] "Lacmpana" "Laetproc" "Laettham" "Lafopuni" "Licahypo" "Licaplat"
    ## [121] "Lindlaur" "Lonchept" "Luehseem" "Macrrose" "Maqucost" "Margnobi"
    ## [127] "Marilaxi" "Maytschi" "Micoaffi" "Micoarge" "Micoelat" "Micohond"
    ## [133] "Mosagarw" "Myrcgatu" "Myrofrut" "Nectciss" "Nectline" "Nectpurp"
    ## [139] "Ochrpyra" "Ocotcern" "Ocotoblo" "Ocotpube" "Ocotwhit" "Oenomapo"
    ## [145] "Ormoamaz" "Ormococc" "Ormomacr" "Pachquin" "Pachsess" "Perexant"
    ## [151] "Cinntrip" "Picrlati" "Pipereti" "Platpinn" "Plateleg" "Posolati"
    ## [157] "Poularma" "Pourbico" "Poutfoss" "Poutreti" "Poutstip" "Priocopa"
    ## [163] "Protcost" "Protpana" "Prottenu" "Pseusept" "Psidfrie" "Psycgran"
    ## [169] "Pterrohr" "Quaraste" "Quasamar" "Randarma" "Sapibroa" "Sapiglan"
    ## [175] "Schipara" "Senndari" "Simaamar" "Sipaguia" "Sipapauc" "Sloatern"
    ## [181] "Socrexor" "Solahaye" "Soroaffi" "Spacmemb" "Sponmomb" "Sponradl"
    ## [187] "Sterapet" "Swargran" "Swarcont" "Sympglob" "Handguay" "Taberose"
    ## [193] "Tabearbo" "Tachvers" "Talinerv" "Taliprin" "Termamaz" "Termoblo"
    ## [199] "Tetrpana" "Tetrjoha" "Theocaca" "Thevahou" "Tocopitt" "Trataspe"
    ## [205] "Tremmicr" "Tricgiga" "Tricpall" "Trictube" "Tricgale" "Tripcumi"
    ## [211] "Tropcauc" "Troprace" "Turpocci" "Unonpitt" "Viromult" "Virosebi"
    ## [217] "Virosuri" "Vismbacc" "Vochferr" "Xylomacr" "Zantekma" "Zantjuni"
    ## [223] "Zantpana" "Zantsetu" "Zuelguid"

``` r
# assinale os novos nomes para as colunas de BCI
names(BCI) <- make.cepnames(names(BCI))

# confira o resultado 
names(BCI)
```

    ##   [1] "Abarmacr" "Vachmela" "Acaldive" "Acalmacr" "Adeltril" "Aegipana"
    ##   [7] "Alchcost" "Alchlati" "Alibedul" "Allopsil" "Alseblac" "Amaicory"
    ##  [13] "Anacexce" "Andiiner" "Annospra" "Apeiglab" "Apeitibo" "Aspidesm"
    ##  [19] "Astrstan" "Astrgrav" "Attabuty" "Banaguia" "Beilpend" "Brosalic"
    ##  [25] "Brosguia" "Calolong" "Caseacul" "Casearbo" "Casecomm" "Caseguia"
    ##  [31] "Casesylv" "Cassguia" "Cavaplat" "Cecrinsi" "Cecrobtu" "Cedrodor"
    ##  [37] "Ceibpent" "Celtschi" "Cespspat" "Chamschi" "Chimparv" "Macltinc"
    ##  [43] "Chryecli" "Chryarge" "Chrycain" "Cocccoro" "Coccmanz" "Coluglan"
    ##  [49] "Cordalli" "Cordbico" "Cordlasi" "Couscurv" "Crotbill" "Cupacine"
    ##  [55] "Cupalati" "Cuparufe" "Cupaseem" "Dendarbo" "Desmpana" "Diosarta"
    ##  [61] "Diptolei" "Drypstan" "Elaeolei" "Entescho" "Erytcost" "Erytmacr"
    ##  [67] "Eugeflor" "Eugegala" "Eugenesi" "Eugeoers" "Faraocci" "Ficucolu"
    ##  [73] "Ficucost" "Ficuinsi" "Ficumaxi" "Ficuobtu" "Ficupope" "Ficutond"
    ##  [79] "Ficutrig" "Ficuyopo" "Garcinte" "Garcmadr" "Geniamer" "Guapmyrt"
    ##  [85] "Guarfuzz" "Guargran" "Guarguid" "Guatdume" "Guazulmi" "Guetfoli"
    ##  [91] "Gustsupe" "Hampappe" "Hassflor" "Heisacum" "Heisconc" "Hirtamer"
    ##  [97] "Hirttria" "Huracrep" "Hieralch" "Ingaacum" "Ingacocl" "Ingagold"
    ## [103] "Ingalaur" "Ingasemi" "Inganobi" "Ingaoers" "Ingapezi" "Ingapunc"
    ## [109] "Ingaruiz" "Ingasapi" "Ingaspec" "Ingaumbe" "Jacacopa" "Laciaggr"
    ## [115] "Lacmpana" "Laetproc" "Laettham" "Lafopuni" "Licahypo" "Licaplat"
    ## [121] "Lindlaur" "Lonchept" "Luehseem" "Macrrose" "Maqucost" "Margnobi"
    ## [127] "Marilaxi" "Maytschi" "Micoaffi" "Micoarge" "Micoelat" "Micohond"
    ## [133] "Mosagarw" "Myrcgatu" "Myrofrut" "Nectciss" "Nectline" "Nectpurp"
    ## [139] "Ochrpyra" "Ocotcern" "Ocotoblo" "Ocotpube" "Ocotwhit" "Oenomapo"
    ## [145] "Ormoamaz" "Ormococc" "Ormomacr" "Pachquin" "Pachsess" "Perexant"
    ## [151] "Cinntrip" "Picrlati" "Pipereti" "Platpinn" "Plateleg" "Posolati"
    ## [157] "Poularma" "Pourbico" "Poutfoss" "Poutreti" "Poutstip" "Priocopa"
    ## [163] "Protcost" "Protpana" "Prottenu" "Pseusept" "Psidfrie" "Psycgran"
    ## [169] "Pterrohr" "Quaraste" "Quasamar" "Randarma" "Sapibroa" "Sapiglan"
    ## [175] "Schipara" "Senndari" "Simaamar" "Sipaguia" "Sipapauc" "Sloatern"
    ## [181] "Socrexor" "Solahaye" "Soroaffi" "Spacmemb" "Sponmomb" "Sponradl"
    ## [187] "Sterapet" "Swargran" "Swarcont" "Sympglob" "Handguay" "Taberose"
    ## [193] "Tabearbo" "Tachvers" "Talinerv" "Taliprin" "Termamaz" "Termoblo"
    ## [199] "Tetrpana" "Tetrjoha" "Theocaca" "Thevahou" "Tocopitt" "Trataspe"
    ## [205] "Tremmicr" "Tricgiga" "Tricpall" "Trictube" "Tricgale" "Tripcumi"
    ## [211] "Tropcauc" "Troprace" "Turpocci" "Unonpitt" "Viromult" "Virosebi"
    ## [217] "Virosuri" "Vismbacc" "Vochferr" "Xylomacr" "Zantekma" "Zantjuni"
    ## [223] "Zantpana" "Zantsetu" "Zuelguid"
