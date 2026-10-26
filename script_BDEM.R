# script roteiro do BDEM - no repositório Projeto_BDEM_2016
# Antes de começar a fazer qualquer coisa:
# a) Coloque todos os arquivos postados no Classroom (já descompactados) dentro do repositório local Projeto_BDEM_2016
# b) commit este roteiro com a mensagem "dados, arquivos de texto e script roteiro BDEM" e envie para o repositório Projeto_BDEM_2016
# c) salve o script com outro nome (script_BDEM.R) e commit com a mensagem "script BDEM" e envie para o repositório Projeto_BDEM_2016

# Ao inserir os comandos em cada Tarefa de cada Etapa, mantenha as linhas de comentários e orientações colocadas pela professora


##################################
# ETAPA 1: BANCO DE DADOS DO SIM
##################################
# Você deve criar e estar na branch SIM antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SIM_2016 com 1309774 linhas e 87 colunas com o nome de dados_sim
# Verificar se a leitura foi feita corretamente e a estrutura dos dados

#Lendo o banco de dados
dados_sim = read.csv("SIM_2016.csv",
                     sep = ";",
                     header = T)

#Verificando a leitura
dim(dados_sim)

#Verificando a estrutura e a separação das linhas
str(dados_sim)

head(dados_sim)


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sim apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sim_1
# As colunas serão: 1, 3, 9, 10, 11, 14, 17, 35, 47
# Nomes das respectivas variáveis: CONTADOR, TIPOBITO, IDADE, SEXO, RACACOR, ESC2010, CODMUNRES, TPMORTEOCO, CAUSABAS

#Selecionando apenas as colunas necessárias
dados_sim_1 = dados_sim[, c(1, 3, 9, 10, 11, 14, 17, 35, 47)]

#Verificando as colunas selecionadas
names(dados_sim_1)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sim_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sim_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF

#Selecionando apenas os dados do Rio Grande do Sul
dados_sim_2 = dados_sim_1[substr(dados_sim_1$CODMUNRES, 1, 2) == "43", ]

# observar abaixo o número de óbitos por UF de residência para certificar-se que seu banco de dados está correto
# 11:8344      12:3763     13:16799    14:2157      15:38557     16:2995     17:7490
# 21:34362     22:19187    23:54276    24:21922     25:28041     26:66928    27:20769    28:13516     29:88094
# 31:135257    32:22868    33:141089   35:296359
# 41:74740     42:40270    43:87583
# 50:16749     51:17535    52:38074    53:12050 

#Verificando o número de óbitos (óbitos esperados = 87583)
nrow(dados_sim_2)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIM - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sim_2 a frequência das categorias das seguintes variáveis:
# TIPOBITO, SEXO, RACACOR, ESC2010, TPMORTEOCO, CAUSABAS
# Avalie também os valores das variável IDADE (não estranhe mas idade é composta de um dígito inicial que indica a unidade de medida)
# Unidades de medida a serem consideradas em IDADE: 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
# Atenção: a unidade de medida de IDADE no DICIONÀRIO do SIM está errada
# O propósito das avaliações acima é verificar se as categorias estão de acordo com o dicionário do SIM ou se aparecem categorias estranhas

table(dados_sim_2$TIPOBITO)
table(dados_sim_2$SEXO)
table(dados_sim_2$RACACOR)
table(dados_sim_2$ESC2010)
table(dados_sim_2$TPMORTEOCO)
table(dados_sim_2$CAUSABAS)

summary(dados_sim_2$IDADE)



# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIM - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sim_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SIM para identificar qual o código das categorias de cada variável
# Em variáveis quantitativas como IDADE verificar se existem valores como 9999 para NA


# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SIM - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016

dados_sim_2$SEXO[dados_sim_2$SEXO == 0] = NA
dados_sim_2$ESC2010[dados_sim_2$ESC2010 == 9] = NA
dados_sim_2$TPMORTEOCO[dados_sim_2$TPMORTEOCO == 9] = NA

dados_sim_2$IDADE[dados_sim_2$IDADE == 999] = NA


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal")

# ATENçÃO: 1. Na hora de escrever os labels, somente a PRIMEIRA LETRA da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados

dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal"))

dados_sim_2$SEXO = factor(dados_sim_2$SEXO, levels = c(1,2), labels = c("Masculino", "Feminino"))

dados_sim_2$RACACOR = factor(dados_sim_2$RACACOR, levels = c(1,2,3,4,5), labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sim_2$ESC2010 = factor(dados_sim_2$ESC2010, levels = c(0,1,2,3,4,5), labels = c("Sem escolaridade", "Fundamental I (1ª a 4ª série)", "Fundamental II (5ª a 8ª série)", "Médio (antigo 2º grau)", "Superior incompleto", "Superior completo"))

dados_sim_2$TPMORTEOCO = factor(dados_sim_2$TPMORTEOCO, levels = c(1,2,3,4,5,8), labels = c("Na gravidez", "No parto", "No abortamento", "Até 42 dias após o término do parto", "De 43 dias a 1 ano após o término da gestação", "Não ocorreu nestes períodos"))



# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SIM - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Criar um banco de dados, de nome SIM_UF.csv (Exemplo: SIM_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 7 - SIM.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada


# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SIM - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016
LETRA = substr(dados_sim_2$CAUSABAS, 1, 1)
NUM = as.numeric(substr(dados_sim_2$CAUSABAS, 2, 3))

# Base inicial (municípios)
base = data.frame(CODMUNRES = sort(unique(dados_sim_2$CODMUNRES)))


# TO - Total de óbitos
TO = as.data.frame(table(factor(dados_sim_2$CODMUNRES)))

names(TO) = c("CODMUNRES","TO")

base = merge(base, TO, by = "CODMUNRES", all.x = TRUE)


# TORC - Registros completos nas 87 variáveis
dados_UF = dados_sim[substr(as.character(dados_sim$CODMUNRES),1,2) == "43",]

dados_UF_comp = dados_UF[complete.cases(dados_UF),]

TORC = as.data.frame(table(factor(dados_UF_comp$CODMUNRES,
                                  levels = base$CODMUNRES)))

names(TORC) = c("CODMUNRES","TORC")

base = merge(base, TORC, by = "CODMUNRES", all.x = TRUE)


# TORCR- Total de óbitos com registros completos nas 9 variáveis selecionadas
dados_UF_1 = dados_sim_1[substr(as.character(dados_sim_1$CODMUNRES),1,2) == "43",]

dados_UF_1_comp = dados_UF_1[complete.cases(dados_UF_1),]

TORCR = as.data.frame(table(factor(dados_UF_1_comp$CODMUNRES, levels = base$CODMUNRES)))

names(TORCR) = c("CODMUNRES","TORCR")

base = merge(base, TORCR, by = "CODMUNRES", all.x = TRUE)


# TO_NN - Total de óbitos por causas externas (CID-10: V01-Y98)
tab = table(factor(dados_sim_2$CODMUNRES[LETRA %in% c("V","W","X","Y")], levels = base$CODMUNRES))

TO_NN = as.data.frame(tab)
names(TO_NN) = c("CODMUNRES","TO_NN")

base = merge(base, TO_NN, by = "CODMUNRES", all.x = TRUE)


# TO_N - Total de óbitos por causas naturais
tab = table(factor(dados_sim_2$CODMUNRES[!(LETRA %in% c("V","W","X","Y"))], levels = base$CODMUNRES))

TO_N = as.data.frame(tab)
names(TO_N) = c("CODMUNRES","TO_N")

base = merge(base, TO_N, by = "CODMUNRES", all.x = TRUE)


# TO_CB_I - Doenças infecciosas e parasitárias (A00-B99)
tab = table(factor(dados_sim_2$CODMUNRES[LETRA %in% c("A","B")], levels = base$CODMUNRES))

TO_CB_I = as.data.frame(tab)
names(TO_CB_I) = c("CODMUNRES","TO_CB_I")

base = merge(base, TO_CB_I, by = "CODMUNRES", all.x = TRUE)


# TO_CB_N - Neoplasias e doenças do sangue (C00-D48 e D50-D89)
tab = table(factor(dados_sim_2$CODMUNRES[LETRA == "C" | (LETRA == "D" & NUM <= 48) | (LETRA == "D" & NUM >= 50)
], levels = base$CODMUNRES))

TO_CB_N = as.data.frame(tab)
names(TO_CB_N) = c("CODMUNRES","TO_CB_N")

base = merge(base, TO_CB_N, by = "CODMUNRES", all.x = TRUE)


# TO_CB_C - Doenças do aparelho circulatório (I00-I99)
tab = table(factor(dados_sim_2$CODMUNRES[LETRA == "I"], levels = base$CODMUNRES))

TO_CB_C = as.data.frame(tab)
names(TO_CB_C) = c("CODMUNRES","TO_CB_C")

base = merge(base, TO_CB_C, by = "CODMUNRES", all.x = TRUE)


# TO_CB_R - Doenças do aparelho respiratório (J00-J99)
tab = table(factor(dados_sim_2$CODMUNRES[LETRA == "J"], levels = base$CODMUNRES))

TO_CB_R = as.data.frame(tab)
names(TO_CB_R) = c("CODMUNRES","TO_CB_R")

base = merge(base, TO_CB_R, by = "CODMUNRES", all.x = TRUE)


# TO_CB_O - Outras causas básicas naturais
tab = table(factor(dados_sim_2$CODMUNRES[!(LETRA %in% c("V","W","X","Y")) & !(LETRA %in% c("A","B","C","I","J")) &
                                           !(LETRA == "D" & NUM <= 48) & !(LETRA == "D" & NUM >= 50)], levels = base$CODMUNRES))

TO_CB_O = as.data.frame(tab)

names(TO_CB_O) = c("CODMUNRES","TO_CB_O")

base = merge(base, TO_CB_O, by = "CODMUNRES", all.x = TRUE)


# TO_M - Total de óbitos masculinos
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$SEXO == "Masculino"], levels = base$CODMUNRES))

TO_M = as.data.frame(tab)

names(TO_M) = c("CODMUNRES","TO_M")

base = merge(base, TO_M, by = "CODMUNRES", all.x = TRUE)


# TO_F - Total de óbitos femininos
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$SEXO == "Feminino"], levels = base$CODMUNRES))

TO_F = as.data.frame(tab)

names(TO_F) = c("CODMUNRES","TO_F")

base = merge(base, TO_F, by = "CODMUNRES", all.x = TRUE)


# TO_F_IF - Total de óbitos femininos em idade fértil (15 a 49 anos)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$SEXO == "Feminino" & dados_sim_2$IDADE >= 415 & dados_sim_2$IDADE <= 449],
                   levels = base$CODMUNRES))

TO_F_IF = as.data.frame(tab)

names(TO_F_IF) = c("CODMUNRES","TO_F_IF")

base = merge(base, TO_F_IF, by = "CODMUNRES", all.x = TRUE)


# TO_FT - Total de óbitos fetais
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Fetal"],levels = base$CODMUNRES))

TO_FT = as.data.frame(tab)

names(TO_FT) = c("CODMUNRES","TO_FT")

base = merge(base, TO_FT, by = "CODMUNRES", all.x = TRUE)


# TO_NT - Total de óbitos neonatais (0 a 27 dias)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 200 & dados_sim_2$IDADE <= 227], levels = base$CODMUNRES))

TO_NT = as.data.frame(tab)

names(TO_NT) = c("CODMUNRES","TO_NT")

base = merge(base, TO_NT, by = "CODMUNRES", all.x = TRUE)


# TO_NT_P - Total de óbitos neonatais precoces (0 a 6 dias)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" & dados_sim_2$IDADE >= 200 &
                                           dados_sim_2$IDADE <= 206], levels = base$CODMUNRES))

TO_NT_P = as.data.frame(tab)

names(TO_NT_P) = c("CODMUNRES","TO_NT_P")

base = merge(base, TO_NT_P, by = "CODMUNRES", all.x = TRUE)


# TO_NT_T - Total de óbitos neonatais tardios (7 a 27 dias)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 207 & dados_sim_2$IDADE <= 227], levels = base$CODMUNRES))

TO_NT_T = as.data.frame(tab)

names(TO_NT_T) = c("CODMUNRES","TO_NT_T")

base = merge(base, TO_NT_T, by = "CODMUNRES", all.x = TRUE)


# TO_PNT - Total de óbitos pós-neonatais (28 dias a 364 dias)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 228 & dados_sim_2$IDADE <= 311], levels = base$CODMUNRES))

TO_PNT = as.data.frame(tab)

names(TO_PNT) = c("CODMUNRES","TO_PNT")

base = merge(base, TO_PNT, by = "CODMUNRES", all.x = TRUE)


# TONT_B - Óbitos neonatais de raça/cor branca
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 200 & dados_sim_2$IDADE <= 227 & dados_sim_2$RACACOR == "Branca"], levels = base$CODMUNRES))

TONT_B = as.data.frame(tab)

names(TONT_B) = c("CODMUNRES","TONT_B")

base = merge(base, TONT_B, by = "CODMUNRES", all.x = TRUE)


# TONT_PT - Óbitos neonatais de raça/cor preta
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" & dados_sim_2$IDADE >= 200 &
                                           dados_sim_2$IDADE <= 227 & dados_sim_2$RACACOR == "Preta"], levels = base$CODMUNRES))

TONT_PT = as.data.frame(tab)

names(TONT_PT) = c("CODMUNRES","TONT_PT")

base = merge(base, TONT_PT, by = "CODMUNRES", all.x = TRUE)


# TONT_A - Óbitos neonatais de raça/cor amarela
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 200 & dados_sim_2$IDADE <= 227 & dados_sim_2$RACACOR == "Amarela"],
                   levels = base$CODMUNRES))

TONT_A = as.data.frame(tab)

names(TONT_A) = c("CODMUNRES","TONT_A")

base = merge(base, TONT_A, by = "CODMUNRES", all.x = TRUE)


# TONT_PD - Óbitos neonatais de raça/cor parda
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" &
                                           dados_sim_2$IDADE >= 200 & dados_sim_2$IDADE <= 227 &
                                           dados_sim_2$RACACOR == "Parda"], levels = base$CODMUNRES))

TONT_PD = as.data.frame(tab)

names(TONT_PD) = c("CODMUNRES","TONT_PD")

base = merge(base, TONT_PD, by = "CODMUNRES", all.x = TRUE)


# TONT_I - Óbitos neonatais de raça/cor indígena
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TIPOBITO == "Não fetal" & dados_sim_2$IDADE >= 200 &
                                           dados_sim_2$IDADE <= 227 & dados_sim_2$RACACOR == "Indígena"], levels = base$CODMUNRES))

TONT_I = as.data.frame(tab)

names(TONT_I) = c("CODMUNRES","TONT_I")

base = merge(base, TONT_I, by = "CODMUNRES", all.x = TRUE)


# TO_MT - Total de óbitos maternos - durante a gestação, parto, abortamento, até 42 dias ou tardio
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez","No parto",
                                                                       "No abortamento","Até 42 dias após o término do parto", "De 43 dias a 1 ano após o término da gestação")],
                   levels = base$CODMUNRES))

TO_MT = as.data.frame(tab)

names(TO_MT) = c("CODMUNRES","TO_MT")

base = merge(base, TO_MT, by = "CODMUNRES", all.x = TRUE)


# TO_MT_DG - Óbitos maternos durante a gestação
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO == "Na gravidez"],levels = base$CODMUNRES))

TO_MT_DG = as.data.frame(tab)

names(TO_MT_DG) = c("CODMUNRES","TO_MT_DG")

base = merge(base, TO_MT_DG, by = "CODMUNRES", all.x = TRUE)


# TO_MT_PT - Óbitos maternos no parto
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO == "No parto"], levels = base$CODMUNRES))

TO_MT_PT = as.data.frame(tab)

names(TO_MT_PT) = c("CODMUNRES","TO_MT_PT")

base = merge(base, TO_MT_PT, by = "CODMUNRES", all.x = TRUE)


# TO_MT_AB - Óbitos maternos no abortamento
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO == "No abortamento"],levels = base$CODMUNRES))

TO_MT_AB = as.data.frame(tab)

names(TO_MT_AB) = c("CODMUNRES","TO_MT_AB")

base = merge(base, TO_MT_AB, by = "CODMUNRES", all.x = TRUE)


# TO_MT_42 - Óbitos maternos até 42 dias após o parto
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO == "Até 42 dias após o término do parto"],
                   levels = base$CODMUNRES))

TO_MT_42 = as.data.frame(tab)

names(TO_MT_42) = c("CODMUNRES","TO_MT_42")

base = merge(base, TO_MT_42, by = "CODMUNRES", all.x = TRUE)


# TO_MT_43 - Óbitos maternos tardios (43 dias a 1 ano)
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO == "De 43 dias a 1 ano após o término da gestação"],
                   levels = base$CODMUNRES))

TO_MT_43 = as.data.frame(tab)

names(TO_MT_43) = c("CODMUNRES","TO_MT_43")

base = merge(base, TO_MT_43, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P - Total de óbitos maternos precoces
# Soma dos óbitos durante a gestação, parto, abortamento e até 42 dias após o parto
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                                                       "No abortamento", "Até 42 dias após o término do parto")], levels = base$CODMUNRES))

TO_MT_P = as.data.frame(tab)

names(TO_MT_P) = c("CODMUNRES","TO_MT_P")

base = merge(base, TO_MT_P, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_I - Total de óbitos maternos precoces de mulheres em idade fértil - Idade fértil: 15 a 49 anos
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                                                       "No abortamento", "Até 42 dias após o término do parto") & dados_sim_2$IDADE >= 415 &
                                           dados_sim_2$IDADE <= 449], levels = base$CODMUNRES))

TO_MT_P_I = as.data.frame(tab)

names(TO_MT_P_I) = c("CODMUNRES","TO_MT_P_I")

base = merge(base, TO_MT_P_I, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_ES - Óbitos maternos precoces de mulheres sem escolaridade
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez",
                                                                       "No parto", "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Sem escolaridade"], levels = base$CODMUNRES))

TO_MT_P_ES = as.data.frame(tab)

names(TO_MT_P_ES) = c("CODMUNRES","TO_MT_P_ES")

base = merge(base, TO_MT_P_ES, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_EFI - Óbitos maternos precoces de mulheres com Fundamental I
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez",
                                                                       "No parto", "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Fundamental I (1ª a 4ª série)"], levels = base$CODMUNRES))

TO_MT_P_EFI = as.data.frame(tab)

names(TO_MT_P_EFI) = c("CODMUNRES","TO_MT_P_EFI")

base = merge(base, TO_MT_P_EFI, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_EFII - Óbitos maternos precoces de mulheres com Fundamental II
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez",
                                                                       "No parto", "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Fundamental II (5ª a 8ª série)"], levels = base$CODMUNRES))

TO_MT_P_EFII = as.data.frame(tab)

names(TO_MT_P_EFII) = c("CODMUNRES","TO_MT_P_EFII")

base = merge(base, TO_MT_P_EFII, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_EM - Óbitos maternos precoces de mulheres com escolaridade média
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                                                       "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Médio (antigo 2º grau)"], levels = base$CODMUNRES))

TO_MT_P_EM = as.data.frame(tab)

names(TO_MT_P_EM) = c("CODMUNRES","TO_MT_P_EM")

base = merge(base, TO_MT_P_EM, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_ESI - Óbitos maternos precoces de mulheres com superior incompleto
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                                                       "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Superior incompleto"], levels = base$CODMUNRES))

TO_MT_P_ESI = as.data.frame(tab)

names(TO_MT_P_ESI) = c("CODMUNRES","TO_MT_P_ESI")

base = merge(base, TO_MT_P_ESI, by = "CODMUNRES", all.x = TRUE)


# TO_MT_P_ESC - Óbitos maternos precoces de mulheres com escolaridade superior completa
tab = table(factor(dados_sim_2$CODMUNRES[dados_sim_2$TPMORTEOCO %in% c("Na gravidez", "No parto",
                                                                       "No abortamento", "Até 42 dias após o término do parto") &
                                           dados_sim_2$ESC2010 == "Superior completo"],levels = base$CODMUNRES))

TO_MT_P_ESC = as.data.frame(tab)

names(TO_MT_P_ESC) = c("CODMUNRES","TO_MT_P_ESC")

base = merge(base, TO_MT_P_ESC, by = "CODMUNRES", all.x = TRUE)


# código da UF
linha_estado = data.frame(matrix(ncol = ncol(base), nrow = 1))
names(linha_estado) = names(base)

linha_estado[, -1] = colSums(base[, -1])

linha_estado$CODMUNRES = 43

# Banco de dados final para o Rio Grande do Sul
SIM_RS = rbind(linha_estado, base)

SIM_RS$NIVEL = c("UF", rep("MUNICIPIO", nrow(SIM_UF)-1))
SIM_RS$ANO = 2016

SIM_RS = SIM_RS[, c("ANO","NIVEL","CODMUNRES", names(SIM_UF)[!names(SIM_UF) %in% c("ANO","NIVEL","CODMUNRES")])]
SIM_RS$CODMUNRES = as.character(SIM_UF$CODMUNRES)

# Verificando o banco final
str(SIM_RS)
head(SIM_RS)
dim(SIM_RS)


# Tarefa 8. Exportar o banco de dados com o nome SIM_UF.csv (Exemplo: SIM_RJ.csv)
write.csv(SIM_RS, "SIM_RS.csv",  row.names = FALSE)

# Ao terminar a Tarefa 8 fazer um commit com o comentário "dados SIM_UF 2016 e script - SIM - tarefas 1 a 8"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 2: BANCO DE DADOS DO SINASC
####################################
# Você deve criar e estar na branch SINASC antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SINASC_2016 com 2857800 linhas e 61 colunas com o nome de dados_sinasc
dados_sinasc = read.csv(
  "SINASC_2016.csv",
  sep = ";",
  header = TRUE
)

# Verificar se a leitura foi feita corretamente e a estrutura dos dados
dim(dados_sinasc)

str(dados_sinasc)

# Por uma questão de padronização coloque todos os nomes das variáveis em letra maiúscula,
# usando o comando names(dados_sinasc) = toupper(names(dados_sinasc))
names(dados_sinasc) = toupper(names(dados_sinasc))

str(dados_sinasc)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINASC - tarefa 1" e envie para o repositório Projeto_BDEM_2016

# Tarefa 2. Reduzir dados_sinasc apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sinasc_1
# As colunas serão 3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37, 43, 47, 58, 59, 60, 61
# Nomes das respectivas variáveis: CODMUNNASC, LOCNASC, IDADEMAE, ESTCIVMAE, CODMUNRES, GESTACAO, GRAVIDEZ, PARTO, 
# SEXO, APGAR5, RACACOR, PESO, IDANOMAL, ESCMAE2010, RACACORMAE, SEMAGESTAC, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK, CONTADOR

dados_sinasc_1 = dados_sinasc[, c(
  3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21,
  22, 23, 34, 37, 43, 47, 58, 59, 60, 61
)]


#Verificando o que foi feito
names(dados_sinasc_1)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sinasc_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinasc_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF 


dados_sinasc_2 = dados_sinasc_1[
  substr(dados_sinasc_1$CODMUNRES, 1, 2) == "43",
]

# observar abaixo o número de nascimentos por UF de residência para certificar-se que seu banco de dados está correto
# 11: 26602     12: 15773     13: 76703     14: 11376     15: 137681    16: 15521      17: 23870
# 21: 110493    22: 46986     23: 126246    24: 45366     25: 56083     26: 130733     27: 48164     28: 32218     29: 199830
# 31: 253520    32: 53413     33: 219129    35: 601437     
# 41: 155066    42: 95313     43: 141411
# 50: 42432     51: 53531     52: 95563     53: 43340 

#Verificando o número de nascimentos
nrow(dados_sinasc_2)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sinasc_2 a frequência das categorias das seguintes variáveis: LOCNASC, ESTCIVMAE, GESTACAO, GRAVIDEZ, PARTO,
# SEXO, RACACOR, IDANOMAL, ESCMAE2010, RACACORMAE, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK

# LOCNASC
table(dados_sinasc_2$LOCNASC, useNA = "ifany")

# ESTCIVMAE
table(dados_sinasc_2$ESTCIVMAE, useNA = "ifany")

# GESTACAO
table(dados_sinasc_2$GESTACAO, useNA = "ifany")

# GRAVIDEZ
table(dados_sinasc_2$GRAVIDEZ, useNA = "ifany")

# PARTO
table(dados_sinasc_2$PARTO, useNA = "ifany")

# SEXO
table(dados_sinasc_2$SEXO, useNA = "ifany")

# RACACOR
table(dados_sinasc_2$RACACOR, useNA = "ifany")

# IDANOMAL
table(dados_sinasc_2$IDANOMAL, useNA = "ifany")

# ESCMAE2010
table(dados_sinasc_2$ESCMAE2010, useNA = "ifany")

# RACACORMAE
table(dados_sinasc_2$RACACORMAE, useNA = "ifany")

# TPAPRESENT
table(dados_sinasc_2$TPAPRESENT, useNA = "ifany")

# TPROBSON
table(dados_sinasc_2$TPROBSON, useNA = "ifany")

# PARIDADE
table(dados_sinasc_2$PARIDADE, useNA = "ifany")

# KOTELCHUCK
table(dados_sinasc_2$KOTELCHUCK, useNA = "ifany")

# Avalie também os valores das variáveis quantitativas de IDADEMAE, SEMAGESTAC, APGAR5 e PESO

# IDADEMAE
summary(dados_sinasc_2$IDADEMAE)

# SEMAGESTAC
summary(dados_sinasc_2$SEMAGESTAC)

# APGAR5
summary(dados_sinasc_2$APGAR5)

# PESO
summary(dados_sinasc_2$PESO)

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sinasc_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SINASC para identificar qual o código das categorias de cada variável
# KOTELCHUCK = 9 significa "Não informado"   TPROBSON = 11 significa "Não classificado por falta de informação"
# Em variáveis quantitativas como IDADEMAE verificar se existem valores como 9999 para NA

# Tarefa 5. Transformar categorias ignoradas/não informadas em NA

# LOCNASC
dados_sinasc_2$LOCNASC[dados_sinasc_2$LOCNASC == "9"] = NA

# ESTCIVMAE
dados_sinasc_2$ESTCIVMAE[dados_sinasc_2$ESTCIVMAE == "9"] = NA

# GESTACAO
dados_sinasc_2$GESTACAO[dados_sinasc_2$GESTACAO == "9"] = NA

# GRAVIDEZ
dados_sinasc_2$GRAVIDEZ[dados_sinasc_2$GRAVIDEZ == "9"] = NA

# PARTO
dados_sinasc_2$PARTO[dados_sinasc_2$PARTO == "9"] = NA

# SEXO
dados_sinasc_2$SEXO[dados_sinasc_2$SEXO == "0"] = NA

# RACACOR
dados_sinasc_2$RACACOR[dados_sinasc_2$RACACOR == "9"] = NA

# IDANOMAL
dados_sinasc_2$IDANOMAL[dados_sinasc_2$IDANOMAL == "9"] = NA

# ESCMAE2010
dados_sinasc_2$ESCMAE2010[dados_sinasc_2$ESCMAE2010 == "9"] = NA

# RACACORMAE
dados_sinasc_2$RACACORMAE[dados_sinasc_2$RACACORMAE == "9"] = NA

# SEMAGESTAC
dados_sinasc_2$SEMAGESTAC[dados_sinasc_2$SEMAGESTAC == "99"] = NA

# TPAPRESENT
dados_sinasc_2$TPAPRESENT[dados_sinasc_2$TPAPRESENT == "9"] = NA

# TPROBSON
dados_sinasc_2$TPROBSON[dados_sinasc_2$TPROBSON == "11"] = NA

# PARIDADE
dados_sinasc_2$PARIDADE[dados_sinasc_2$PARIDADE == "9"] = NA

# KOTELCHUCK
dados_sinasc_2$KOTELCHUCK[dados_sinasc_2$KOTELCHUCK == "9"] = NA

# IDADEMAE
dados_sinasc_2$IDADEMAE[dados_sinasc_2$IDADEMAE == "99"] = NA

# APGAR5
dados_sinasc_2$APGAR5[dados_sinasc_2$APGAR5 == "99"] = NA

# PESO
dados_sinasc_2$PESO[dados_sinasc_2$PESO == "9999"] = NA

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1,2,3,4,5), 
# labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado",  
# "Mais que adequado")

# ATENçÃO: 1. Na hora de escrever os labels, somente a primeira letra da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados

# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas

# LOCNASC
dados_sinasc_2$LOCNASC = factor(dados_sinasc_2$LOCNASC,
                                levels = c(1, 2, 3, 4, 5),
                                labels = c("Hospital",
                                           "Outros estabelecimentos de saúde",
                                           "Domicílio",
                                           "Outros",
                                           "Aldeia indígena"))

# ESTCIVMAE
dados_sinasc_2$ESTCIVMAE = factor(dados_sinasc_2$ESTCIVMAE,
                                  levels = c(1, 2, 3, 4, 5),
                                  labels = c("Solteira",
                                             "Casada",
                                             "Viúva",
                                             "Separada ou divorciada",
                                             "União estável"))

# GESTACAO
dados_sinasc_2$GESTACAO = factor(dados_sinasc_2$GESTACAO,
                                 levels = c(1, 2, 3, 4, 5, 6),
                                 labels = c("Menos de 22 semanas",
                                            "De 22 a 27 semanas",
                                            "De 28 a 31 semanas",
                                            "De 32 a 36 semanas",
                                            "De 37 a 41 semanas",
                                            "42 semanas ou mais"))

# GRAVIDEZ
dados_sinasc_2$GRAVIDEZ = factor(dados_sinasc_2$GRAVIDEZ,
                                 levels = c(1, 2, 3),
                                 labels = c("Única",
                                            "Dupla",
                                            "Tripla ou mais"))

# PARTO
dados_sinasc_2$PARTO = factor(dados_sinasc_2$PARTO,
                              levels = c(1, 2),
                              labels = c("Vaginal",
                                         "Cesáreo"))

# SEXO
dados_sinasc_2$SEXO = factor(dados_sinasc_2$SEXO,
                             levels = c(1, 2),
                             labels = c("Masculino",
                                        "Feminino"))

# RACACOR
dados_sinasc_2$RACACOR = factor(dados_sinasc_2$RACACOR,
                                levels = c(1, 2, 3, 4, 5),
                                labels = c("Branca",
                                           "Preta",
                                           "Amarela",
                                           "Parda",
                                           "Indígena"))

# IDANOMAL
dados_sinasc_2$IDANOMAL = factor(dados_sinasc_2$IDANOMAL,
                                 levels = c(1, 2),
                                 labels = c("Sim",
                                            "Não"))

# ESCMAE2010
dados_sinasc_2$ESCMAE2010 = factor(dados_sinasc_2$ESCMAE2010,
                                   levels = c(0, 1, 2, 3, 4, 5),
                                   labels = c("Sem escolaridade",
                                              "Fundamental I",
                                              "Fundamental II",
                                              "Ensino médio",
                                              "Superior incompleto",
                                              "Superior completo"))

# RACACORMAE
dados_sinasc_2$RACACORMAE = factor(dados_sinasc_2$RACACORMAE,
                                   levels = c(1, 2, 3, 4, 5),
                                   labels = c("Branca",
                                              "Preta",
                                              "Amarela",
                                              "Parda",
                                              "Indígena"))

# TPAPRESENT
dados_sinasc_2$TPAPRESENT = factor(dados_sinasc_2$TPAPRESENT,
                                   levels = c(1, 2, 3),
                                   labels = c("Cefálica",
                                              "Pélvica",
                                              "Transversa"))

# TPROBSON
dados_sinasc_2$TPROBSON = factor(dados_sinasc_2$TPROBSON,
                                 levels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
                                 labels = c("Grupo 1",
                                            "Grupo 2",
                                            "Grupo 3",
                                            "Grupo 4",
                                            "Grupo 5",
                                            "Grupo 6",
                                            "Grupo 7",
                                            "Grupo 8",
                                            "Grupo 9",
                                            "Grupo 10"))

# PARIDADE
dados_sinasc_2$PARIDADE = factor(dados_sinasc_2$PARIDADE,
                                 levels = c(0, 1),
                                 labels = c("Nulípara",
                                            "Multípara"))

# KOTELCHUCK
dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK,
                                   levels = c(1, 2, 3, 4, 5),
                                   labels = c("Não realizou pré-natal",
                                              "Inadequado",
                                              "Intermediário",
                                              "Adequado",
                                              "Mais que adequado"))



# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Categorizar as variáveis IDADEMAE, PESO e APGAR5 e criar variáveis referentes ao deslocamento materno (peregrinação) e estado civil
# nova variável: dados_sinasc_2$F_PESO com PESO: < 2500: Baixo peso, >=2500 e < 4000: Peso normal, >= 4000: Macrossomia
# nova variável dados_sinasc_2$F_IDADE com IDADEMAE: <15, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50+
# nova variável dados_sinasc_2$F_APGAR5 com APGAR5: < 7: Baixo, >= 7: Normal
# Atenção para casos de NA em IDADEMAE, PESO e APGAR5
# nova variável: dados_sinasc_2$PEREG: Não: CODMUNNASC igual a CODMUNRES, Sim: CODMUNNASC diferente de CODMUNRES
# nova variável: dados_sinasc_2$ESTCIV: Sem companheiro: ESTCIVMAE 1, 3 ou 4, Com companheiro: ESTCIVMAE 2 ou 5
# Ao categorizar as variáveis, garantir que sejam transformadas em tipo fator

# F_PESO
dados_sinasc_2$F_PESO = cut(
  dados_sinasc_2$PESO,
  breaks = c(-Inf, 2499, 3999, Inf),
  labels = c("Baixo peso", "Peso normal", "Macrossomia"),
  right = TRUE
)

# F_IDADE
dados_sinasc_2$F_IDADE = cut(
  dados_sinasc_2$IDADEMAE,
  breaks = c(-Inf, 14, 19, 24, 29, 34, 39, 44, 49, Inf),
  labels = c("<15", "15-19", "20-24", "25-29", "30-34",
             "35-39", "40-44", "45-49", "50+"),
  right = TRUE
)

# F_APGAR5
dados_sinasc_2$F_APGAR5 = cut(
  dados_sinasc_2$APGAR5,
  breaks = c(-Inf, 6, Inf),
  labels = c("Baixo", "Normal"),
  right = TRUE
)

# PEREG
dados_sinasc_2$PEREG = factor(
  ifelse(
    dados_sinasc_2$CODMUNNASC == dados_sinasc_2$CODMUNRES,
    "Não",
    "Sim"
  ),
  levels = c("Não", "Sim")
)

# ESTCIV
dados_sinasc_2$ESTCIV = factor(
  ifelse(
    dados_sinasc_2$ESTCIVMAE %in% c(1, 3, 4),
    "Sem companheiro",
    ifelse(
      dados_sinasc_2$ESTCIVMAE %in% c(2, 5),
      "Com companheiro",
      NA
    )
  ),
  levels = c("Sem companheiro", "Com companheiro")
)



# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Agregar ao banco de dados_sinasc_2 as informações PESO_P10 e PESO_P90 a partir de Tabela_PIG_Brasil.csv
# a Tabela PIG informa P10 e P90 dos pesos, de acordo com a idade gestacional

tabela_pig = read.csv2("Tabela_PIG_Brasil.csv",
                       header = TRUE)

head(tabela_pig)
str(tabela_pig)

dados_sinasc_2 = merge(
  dados_sinasc_2,
  tabela_pig,
  by = c("SEMAGESTAC", "SEXO"),
  all.x = TRUE
)

# Criar nova variável referente ao peso, de acordo com a idade gestacional, conforme indicado abaixo
# nova variável apenas para casos de GRAVIDEZ Única: dados_sinasc_2$F_PIG: PIG: PESO < PESO_P10, AIG: PESO_P10 <= PESO <= PESO_P90, GIG: PESO > PESO_P90
# Atenção para casos de NA em SEMAGESTAC, PESO ou SEXO. Lembre-se também que em dados_sinasc_2 SEXO está como fator com as categorias Feminino e Masculino.

# F_PIG
dados_sinasc_2$F_PIG = NA

dados_sinasc_2$F_PIG[
  dados_sinasc_2$GRAVIDEZ == "Única" &
    !is.na(dados_sinasc_2$PESO) &
    !is.na(dados_sinasc_2$PESO_P10) &
    !is.na(dados_sinasc_2$PESO_P90) &
    dados_sinasc_2$PESO < dados_sinasc_2$PESO_P10
] = "PIG"

dados_sinasc_2$F_PIG[
  dados_sinasc_2$GRAVIDEZ == "Única" &
    !is.na(dados_sinasc_2$PESO) &
    !is.na(dados_sinasc_2$PESO_P10) &
    !is.na(dados_sinasc_2$PESO_P90) &
    dados_sinasc_2$PESO >= dados_sinasc_2$PESO_P10 &
    dados_sinasc_2$PESO <= dados_sinasc_2$PESO_P90
] = "AIG"

dados_sinasc_2$F_PIG[
  dados_sinasc_2$GRAVIDEZ == "Única" &
    !is.na(dados_sinasc_2$PESO) &
    !is.na(dados_sinasc_2$PESO_P10) &
    !is.na(dados_sinasc_2$PESO_P90) &
    dados_sinasc_2$PESO > dados_sinasc_2$PESO_P90
] = "GIG"

dados_sinasc_2$F_PIG = factor(
  dados_sinasc_2$F_PIG,
  levels = c("PIG", "AIG", "GIG")
)



# Ao terminar a Tarefa 8 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 8" e envie para o repositório Projeto_BDEM_2016


# Tarefa 9. Criar um banco de dados, de nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 9 - SINASC.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada


# Variáveis utilizadas para calcular TNRCR

variaveis_TNRCR = c(
  "CODMUNNASC",
  "LOCNASC",
  "IDADEMAE",
  "ESTCIVMAE",
  "CODMUNRES",
  "GESTACAO",
  "GRAVIDEZ",
  "PARTO",
  "SEXO",
  "APGAR5",
  "RACACOR",
  "PESO",
  "IDANOMAL",
  "ESCMAE2010",
  "RACACORMAE",
  "SEMAGESTAC",
  "TPAPRESENT",
  "TPROBSON",
  "PARIDADE",
  "KOTELCHUCK",
  "CONTADOR"
)


# Função para calcular os indicadores da Tarefa 9

calcular_indicadores = function(d, d_original) {
  
  
  # Informações sobre os nascimentos
  
  TN = nrow(d)
  
  TNRC = sum(complete.cases(d_original))
  
  TNRCR = sum(complete.cases(d[, variaveis_TNRCR]))
  
  
  # Informações sobre as gestantes
  
  # Idade materna
  
  TGI_15 = sum(d$IDADEMAE < 15, na.rm = TRUE)
  
  TGI_15_19 = sum(
    d$IDADEMAE >= 15 &
      d$IDADEMAE <= 19,
    na.rm = TRUE
  )
  
  TGI_20_24 = sum(
    d$IDADEMAE >= 20 &
      d$IDADEMAE <= 24,
    na.rm = TRUE
  )
  
  TGI_25_29 = sum(
    d$IDADEMAE >= 25 &
      d$IDADEMAE <= 29,
    na.rm = TRUE
  )
  
  TGI_30_34 = sum(
    d$IDADEMAE >= 30 &
      d$IDADEMAE <= 34,
    na.rm = TRUE
  )
  
  TGI_35_39 = sum(
    d$IDADEMAE >= 35 &
      d$IDADEMAE <= 39,
    na.rm = TRUE
  )
  
  TGI_40_44 = sum(
    d$IDADEMAE >= 40 &
      d$IDADEMAE <= 44,
    na.rm = TRUE
  )
  
  TGI_45_49 = sum(
    d$IDADEMAE >= 45 &
      d$IDADEMAE <= 49,
    na.rm = TRUE
  )
  
  TGI_50 = sum(
    d$IDADEMAE >= 50,
    na.rm = TRUE
  )
  
  TGIF = sum(
    d$IDADEMAE >= 15 &
      d$IDADEMAE <= 49,
    na.rm = TRUE
  )
  
  
  # Estatísticas da idade materna
  
  IM_P25 = as.numeric(
    quantile(d$IDADEMAE, 0.25, na.rm = TRUE)
  )
  
  IM_P50 = as.numeric(
    quantile(d$IDADEMAE, 0.50, na.rm = TRUE)
  )
  
  IM_P75 = as.numeric(
    quantile(d$IDADEMAE, 0.75, na.rm = TRUE)
  )
  
  IM_MD = mean(
    d$IDADEMAE,
    na.rm = TRUE
  )
  
  IM_DP = sd(
    d$IDADEMAE,
    na.rm = TRUE
  )
  
  
  # Escolaridade materna
  
  EM_S = sum(
    d$ESCMAE2010 == "Sem escolaridade",
    na.rm = TRUE
  )
  
  EM_FI = sum(
    d$ESCMAE2010 == "Fundamental I",
    na.rm = TRUE
  )
  
  EM_FII = sum(
    d$ESCMAE2010 == "Fundamental II",
    na.rm = TRUE
  )
  
  EM_M = sum(
    d$ESCMAE2010 == "Ensino médio",
    na.rm = TRUE
  )
  
  EM_SI = sum(
    d$ESCMAE2010 == "Superior incompleto",
    na.rm = TRUE
  )
  
  EM_SC = sum(
    d$ESCMAE2010 == "Superior completo",
    na.rm = TRUE
  )
  
  
  # Raça/cor das gestantes
  
  TGRC_B = sum(
    d$RACACORMAE == "Branca",
    na.rm = TRUE
  )
  
  TGRC_PT = sum(
    d$RACACORMAE == "Preta",
    na.rm = TRUE
  )
  
  TGRC_A = sum(
    d$RACACORMAE == "Amarela",
    na.rm = TRUE
  )
  
  TGRC_PD = sum(
    d$RACACORMAE == "Parda",
    na.rm = TRUE
  )
  
  TGRC_I = sum(
    d$RACACORMAE == "Indígena",
    na.rm = TRUE
  )
  
  
  # Estado civil
  
  TGSC = sum(
    d$ESTCIV == "Sem companheiro",
    na.rm = TRUE
  )
  
  TGCC = sum(
    d$ESTCIV == "Com companheiro",
    na.rm = TRUE
  )
  
  
  # Paridade
  
  TGPRI = sum(
    d$PARIDADE == "Nulípara",
    na.rm = TRUE
  )
  
  TGNPRI = sum(
    d$PARIDADE == "Multípara",
    na.rm = TRUE
  )
  
  
  # Informações sobre as gestações
  
  TGU = sum(
    d$GRAVIDEZ == "Única",
    na.rm = TRUE
  )
  
  TGG = sum(
    d$GRAVIDEZ != "Única",
    na.rm = TRUE
  )
  
  
  # Duração da gestação
  
  TGD_22 = sum(
    d$SEMAGESTAC < 22,
    na.rm = TRUE
  )
  
  TGD_22_27 = sum(
    d$SEMAGESTAC >= 22 &
      d$SEMAGESTAC <= 27,
    na.rm = TRUE
  )
  
  TGD_28_31 = sum(
    d$SEMAGESTAC >= 28 &
      d$SEMAGESTAC <= 31,
    na.rm = TRUE
  )
  
  TGD_32_36 = sum(
    d$SEMAGESTAC >= 32 &
      d$SEMAGESTAC <= 36,
    na.rm = TRUE
  )
  
  TGD_37_41 = sum(
    d$SEMAGESTAC >= 37 &
      d$SEMAGESTAC <= 41,
    na.rm = TRUE
  )
  
  TGD_42 = sum(
    d$SEMAGESTAC >= 42,
    na.rm = TRUE
  )
  
  TGD_PRT = sum(
    d$SEMAGESTAC < 37,
    na.rm = TRUE
  )
  
  TGD_AT = sum(
    d$SEMAGESTAC >= 37 &
      d$SEMAGESTAC <= 41,
    na.rm = TRUE
  )
  
  TGD_PST = sum(
    d$SEMAGESTAC >= 42,
    na.rm = TRUE
  )
  
  
  # Estatísticas da duração da gestação
  
  DG_P25 = as.numeric(
    quantile(d$SEMAGESTAC, 0.25, na.rm = TRUE)
  )
  
  DG_P50 = as.numeric(
    quantile(d$SEMAGESTAC, 0.50, na.rm = TRUE)
  )
  
  DG_P75 = as.numeric(
    quantile(d$SEMAGESTAC, 0.75, na.rm = TRUE)
  )
  
  DG_MD = mean(
    d$SEMAGESTAC,
    na.rm = TRUE
  )
  
  DG_DP = sd(
    d$SEMAGESTAC,
    na.rm = TRUE
  )
  
  
  # Pré-natal
  
  TKC_NR = sum(
    d$KOTELCHUCK == "Não realizou pré-natal",
    na.rm = TRUE
  )
  
  TKC_ID = sum(
    d$KOTELCHUCK == "Inadequado",
    na.rm = TRUE
  )
  
  TKC_IT = sum(
    d$KOTELCHUCK == "Intermediário",
    na.rm = TRUE
  )
  
  TKC_AD = sum(
    d$KOTELCHUCK == "Adequado",
    na.rm = TRUE
  )
  
  TKC_MAD = sum(
    d$KOTELCHUCK == "Mais que adequado",
    na.rm = TRUE
  )
  
  
  # Informações sobre o parto
  
  # Peregrinação
  
  TGPRG_S = sum(
    d$PEREG == "Sim",
    na.rm = TRUE
  )
  
  TGPRG_N = sum(
    d$PEREG == "Não",
    na.rm = TRUE
  )
  
  
  # Tipo de parto
  
  TPV = sum(
    d$PARTO == "Vaginal",
    na.rm = TRUE
  )
  
  TPC = sum(
    d$PARTO == "Cesáreo",
    na.rm = TRUE
  )
  
  
  # Apresentação fetal
  
  TRAP_C = sum(
    d$TPAPRESENT == "Cefálica",
    na.rm = TRUE
  )
  
  TRAP_P = sum(
    d$TPAPRESENT == "Pélvica",
    na.rm = TRUE
  )
  
  TRAP_T = sum(
    d$TPAPRESENT == "Transversa",
    na.rm = TRUE
  )
  
  
  # Grupos de Robson
  
  TGROB_1 = sum(
    d$TPROBSON == "Grupo 1",
    na.rm = TRUE
  )
  
  TGROB_2 = sum(
    d$TPROBSON == "Grupo 2",
    na.rm = TRUE
  )
  
  TGROB_3 = sum(
    d$TPROBSON == "Grupo 3",
    na.rm = TRUE
  )
  
  TGROB_4 = sum(
    d$TPROBSON == "Grupo 4",
    na.rm = TRUE
  )
  
  TGROB_5 = sum(
    d$TPROBSON == "Grupo 5",
    na.rm = TRUE
  )
  
  TGROB_6 = sum(
    d$TPROBSON == "Grupo 6",
    na.rm = TRUE
  )
  
  TGROB_7 = sum(
    d$TPROBSON == "Grupo 7",
    na.rm = TRUE
  )
  
  TGROB_8 = sum(
    d$TPROBSON == "Grupo 8",
    na.rm = TRUE
  )
  
  TGROB_9 = sum(
    d$TPROBSON == "Grupo 9",
    na.rm = TRUE
  )
  
  TGROB_10 = sum(
    d$TPROBSON == "Grupo 10",
    na.rm = TRUE
  )
  
  
  # Local do nascimento
  
  TNLOC_H = sum(
    d$LOCNASC == "Hospital",
    na.rm = TRUE
  )
  
  TNLOC_ES = sum(
    d$LOCNASC == "Outros estabelecimentos de saúde",
    na.rm = TRUE
  )
  
  TNLOC_D = sum(
    d$LOCNASC == "Domicílio",
    na.rm = TRUE
  )
  
  TNLOC_O = sum(
    d$LOCNASC == "Outros",
    na.rm = TRUE
  )
  
  TNLOC_AI = sum(
    d$LOCNASC == "Aldeia indígena",
    na.rm = TRUE
  )
  
  
  # Informações sobre os recém-nascidos
  
  # Sexo
  
  TRS_M = sum(
    d$SEXO == "Masculino",
    na.rm = TRUE
  )
  
  TRS_F = sum(
    d$SEXO == "Feminino",
    na.rm = TRUE
  )
  
  
  # Raça/cor
  
  TRRC_B = sum(
    d$RACACOR == "Branca",
    na.rm = TRUE
  )
  
  TRRC_PT = sum(
    d$RACACOR == "Preta",
    na.rm = TRUE
  )
  
  TRRC_A = sum(
    d$RACACOR == "Amarela",
    na.rm = TRUE
  )
  
  TRRC_PD = sum(
    d$RACACOR == "Parda",
    na.rm = TRUE
  )
  
  TRRC_I = sum(
    d$RACACOR == "Indígena",
    na.rm = TRUE
  )
  
  
  # Peso
  
  TRP_BP = sum(
    d$PESO < 2500,
    na.rm = TRUE
  )
  
  TRP_N = sum(
    d$PESO >= 2500 &
      d$PESO < 4000,
    na.rm = TRUE
  )
  
  TRP_M = sum(
    d$PESO >= 4000,
    na.rm = TRUE
  )
  
  
  # Estatísticas do peso
  
  PESO_P25 = as.numeric(
    quantile(d$PESO, 0.25, na.rm = TRUE)
  )
  
  PESO_P50 = as.numeric(
    quantile(d$PESO, 0.50, na.rm = TRUE)
  )
  
  PESO_P75 = as.numeric(
    quantile(d$PESO, 0.75, na.rm = TRUE)
  )
  
  PESO_MD = mean(
    d$PESO,
    na.rm = TRUE
  )
  
  PESO_DP = sd(
    d$PESO,
    na.rm = TRUE
  )
  
  
  # Peso segundo idade gestacional
  
  TRPIG_P = sum(
    d$F_PIG == "PIG",
    na.rm = TRUE
  )
  
  TRPIG_A = sum(
    d$F_PIG == "AIG",
    na.rm = TRUE
  )
  
  TRPIG_G = sum(
    d$F_PIG == "GIG",
    na.rm = TRUE
  )
  
  
  # Apgar 5
  
  TRAPG5_B = sum(
    d$F_APGAR5 == "Baixo",
    na.rm = TRUE
  )
  
  TRAPG5_N = sum(
    d$F_APGAR5 == "Normal",
    na.rm = TRUE
  )
  
  APG5_MD = mean(
    d$APGAR5,
    na.rm = TRUE
  )
  
  APG5_DP = sd(
    d$APGAR5,
    na.rm = TRUE
  )
  
  
  # Anomalia congênita
  
  TRAC = sum(
    d$IDANOMAL == "Sim",
    na.rm = TRUE
  )
  
  TRSAC = sum(
    d$IDANOMAL == "Não",
    na.rm = TRUE
  )
  
  
  # Retornando os indicadores na ordem definida na Tarefa 9
  
  data.frame(
    TN,
    TNRC,
    TNRCR,
    TGI_15,
    TGI_15_19,
    TGI_20_24,
    TGI_25_29,
    TGI_30_34,
    TGI_35_39,
    TGI_40_44,
    TGI_45_49,
    TGI_50,
    TGIF,
    IM_P25,
    IM_P50,
    IM_P75,
    IM_MD,
    IM_DP,
    EM_S,
    EM_FI,
    EM_FII,
    EM_M,
    EM_SI,
    EM_SC,
    TGRC_B,
    TGRC_PT,
    TGRC_A,
    TGRC_PD,
    TGRC_I,
    TGSC,
    TGCC,
    TGPRI,
    TGNPRI,
    TGU,
    TGG,
    TGD_22,
    TGD_22_27,
    TGD_28_31,
    TGD_32_36,
    TGD_37_41,
    TGD_42,
    TGD_PRT,
    TGD_AT,
    TGD_PST,
    DG_P25,
    DG_P50,
    DG_P75,
    DG_MD,
    DG_DP,
    TKC_NR,
    TKC_ID,
    TKC_IT,
    TKC_AD,
    TKC_MAD,
    TGPRG_S,
    TGPRG_N,
    TPV,
    TPC,
    TRAP_C,
    TRAP_P,
    TRAP_T,
    TGROB_1,
    TGROB_2,
    TGROB_3,
    TGROB_4,
    TGROB_5,
    TGROB_6,
    TGROB_7,
    TGROB_8,
    TGROB_9,
    TGROB_10,
    TNLOC_H,
    TNLOC_ES,
    TNLOC_D,
    TNLOC_O,
    TNLOC_AI,
    TRS_M,
    TRS_F,
    TRRC_B,
    TRRC_PT,
    TRRC_A,
    TRRC_PD,
    TRRC_I,
    TRP_BP,
    TRP_N,
    TRP_M,
    PESO_P25,
    PESO_P50,
    PESO_P75,
    PESO_MD,
    PESO_DP,
    TRPIG_P,
    TRPIG_A,
    TRPIG_G,
    TRAPG5_B,
    TRAPG5_N,
    APG5_MD,
    APG5_DP,
    TRAC,
    TRSAC
  )
}


# Criando a linha referente ao estado do Rio Grande do Sul

indicadores_UF = calcular_indicadores(
  dados_sinasc_2,
  dados_sinasc
)

SINASC_UF = data.frame(
  ANO = 2016,
  NIVEL = "UF",
  CODMUNRES = 43,
  indicadores_UF
)


# Identificando os municípios do Rio Grande do Sul

municipios_RS = sort(
  unique(dados_sinasc_2$CODMUNRES)
)

length(municipios_RS)


# Criando banco agregado dos municípios

SINASC_MUNICIPIOS = data.frame()

for (municipio in municipios_RS) {
  
  # Dados do município no banco trabalhado
  
  d_municipio = dados_sinasc_2[
    dados_sinasc_2$CODMUNRES == municipio,
  ]
  
  
  # Dados do município no banco original
  
  d_municipio_original = dados_sinasc[
    dados_sinasc$CODMUNRES == municipio,
  ]
  
  
  # Calculando indicadores do município
  
  indicadores = calcular_indicadores(
    d_municipio,
    d_municipio_original
  )
  
  
  # Criando linha do município
  
  linha = data.frame(
    ANO = 2016,
    NIVEL = "MUNICIPIO",
    CODMUNRES = municipio,
    indicadores
  )
  
  
  # Adicionando linha ao banco municipal
  
  SINASC_MUNICIPIOS = rbind(
    SINASC_MUNICIPIOS,
    linha
  )
}


# Juntando UF e municípios

SINASC_RS = rbind(
  SINASC_UF,
  SINASC_MUNICIPIOS
)


# Conferindo dimensão da base

dim(SINASC_RS)


# Conferindo nomes e ordem das variáveis

names(SINASC_RS)


# Conferindo primeiros registros

head(SINASC_RS)


# Conferindo quantidade de registros por nível

table(SINASC_RS$NIVEL)



# Ao terminar a Tarefa 9 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 9" e envie para o repositório Projeto_BDEM_2016


# Tarefa 10. Exportar o banco de dados com o nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv)

write.csv2(
  SINASC_RS,
  "SINASC_RS.csv",
  row.names = FALSE
)

# Ao terminar a Tarefa 10 commit com o comentário "dados SINASC_UF 2016 e script - SIM - tarefas 1 a 10"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 3: BANCOS DE DADOS DO SIDRA
####################################
# Você deve criar e estar na branch SIDRA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# dados_sidra_1 para população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv
# dados_sidra_2 para população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv
# dados_sidra_3 para população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv
# dados_sidra_4 para população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv
# Atenção que agora os arquivos têm nomes e códigos (com 7 dígitos) dos municípios (e alguns UF)

# População residente estimada - UF e municípios - 2016
dados_sidra_1 = read.csv2(
  "população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv",
  header = TRUE
)

# População residente Censo 2010 - UF e municípios - total e por sexo
dados_sidra_2 = read.csv2(
  "população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv",
  header = TRUE
)

# População residente Censo 2010 - por faixa etária - UF
dados_sidra_3 = read.csv2(
  "população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv",
  header = TRUE
)

# População residente Censo 2010 - por faixa etária e sexo - municípios
dados_sidra_4 = read.csv2(
  "população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv",
  header = TRUE
)

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

# Dimensões dos bancos
dim(dados_sidra_1)
dim(dados_sidra_2)
dim(dados_sidra_3)
dim(dados_sidra_4)

# Nomes das variáveis
names(dados_sidra_1)
names(dados_sidra_2)
names(dados_sidra_3)
names(dados_sidra_4)

# Estrutura dos bancos
str(dados_sidra_1)
str(dados_sidra_2)
str(dados_sidra_3)
str(dados_sidra_4)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIDRA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Criar uma nova variável de nome CODUF com os códigos da UF nos bancos dados_sidra_1, dados_sidra_2, dados_sidra_4

# dados_sidra_1
dados_sidra_1$CODUF = substr(
  as.character(dados_sidra_1$CODMUNRES),
  1,
  2
)

# dados_sidra_2
dados_sidra_2$CODUF = substr(
  as.character(dados_sidra_2$CODMUNRES),
  1,
  2
)

# dados_sidra_4
dados_sidra_4$CODUF = substr(
  as.character(dados_sidra_4$CODMUNRES),
  1,
  2
)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Selecionar em dados_sidra_ 1 a dados_sidra_4 a UF de responsabilidade do aluno 
# e chamar os bancos de dados, respectivamente por sidra_1, sidra_2, sidra_3 e sidra_4

#sidra_1
sidra_1 = dados_sidra_1[
  dados_sidra_1$CODUF == "43",
]

#sidra_2
sidra_2 = dados_sidra_2[
  dados_sidra_2$CODUF == "43",
]

#sidra_3
sidra_3 = dados_sidra_3[
  dados_sidra_3$CODMUNRES == 43,
]

#sidra_4
sidra_4 = dados_sidra_4[
  dados_sidra_4$CODUF == "43",
]

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4: Criar um banco de dados, de nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 4 - SIDRA.pdf”


# Criando o banco inicial

SIDRA_RS = data.frame(
  ANO = 2016,
  NIVEL = ifelse(sidra_1$CODMUNRES == 43, "UF", "MUNICIPIO"),
  CODMUNRES = sidra_1$CODMUNRES,
  POPRE_T = as.numeric(sidra_1$POPRE_T)
)


# Adicionado a população do Censo 2010

SIDRA_RS = merge(
  SIDRA_RS,
  sidra_2[, c("CODMUNRES", "POPRC_T", "POPRC_M", "POPRC_F")],
  by = "CODMUNRES",
  all.x = TRUE,
  sort = FALSE
)


# Definindo os grupos de idade

faixas = c(
  "0 a 4 anos",
  "5 a 9 anos",
  "10 a 14 anos",
  "15 a 19 anos",
  "20 a 24 anos",
  "25 a 29 anos",
  "30 a 34 anos",
  "35 a 39 anos",
  "40 a 44 anos",
  "45 a 49 anos",
  "50 a 54 anos",
  "55 a 59 anos",
  "60 a 64 anos",
  "65 a 69 anos",
  "70 a 74 anos",
  "75 a 79 anos",
  "80 a 89 anos",
  "90 a 99 anos",
  "100 anos ou mais"
)

grupos = c(
  rep("15", 3),
  rep("15_49", 7),
  rep("50", 9)
)


# Reunindo os dados de idade da UF e dos municípios

idades = rbind(
  sidra_3[, c("CODMUNRES", "F_IDADE", "POP", "POPF")],
  sidra_4[, c("CODMUNRES", "F_IDADE", "POP", "POPF")]
)

# Associando cada faixa etária ao respectivo grupo

idades$GRUPO_IDADE = grupos[
  match(idades$F_IDADE, faixas)
]

# Desconsiderando os registros sem faixa etária definida

idades = idades[!is.na(idades$GRUPO_IDADE), ]


# Agregando as popilações por localidade e grupo de idade

pop_agregada = aggregate(
  cbind(POP, POPF) ~ CODMUNRES + GRUPO_IDADE,
  data = idades,
  FUN = sum
)


# Transformandoos grupos de idade em colunas

pop_total = reshape(
  pop_agregada[, c("CODMUNRES", "GRUPO_IDADE", "POP")],
  idvar = "CODMUNRES",
  timevar = "GRUPO_IDADE",
  direction = "wide"
)

pop_feminina = reshape(
  pop_agregada[, c("CODMUNRES", "GRUPO_IDADE", "POPF")],
  idvar = "CODMUNRES",
  timevar = "GRUPO_IDADE",
  direction = "wide"
)


# Renomeando as variáveis

names(pop_total) = sub(
  "^POP\\.",
  "POPRC_",
  names(pop_total)
)

names(pop_feminina) = sub(
  "^POPF\\.",
  "POPRC_F_",
  names(pop_feminina)
)


# Inserindo as populações ao banco final

SIDRA_RS = merge(
  SIDRA_RS,
  pop_total,
  by = "CODMUNRES",
  all.x = TRUE,
  sort = FALSE
)

SIDRA_RS = merge(
  SIDRA_RS,
  pop_feminina,
  by = "CODMUNRES",
  all.x = TRUE,
  sort = FALSE
)


# Organizando as linhas e colunas

SIDRA_RS = SIDRA_RS[
  order(SIDRA_RS$NIVEL != "UF", SIDRA_RS$CODMUNRES),
]

# Ordenando das variáveis

SIDRA_RS = SIDRA_RS[, c(
  "ANO",
  "NIVEL",
  "CODMUNRES",
  "POPRE_T",
  "POPRC_T",
  "POPRC_M",
  "POPRC_F",
  "POPRC_15",
  "POPRC_15_49",
  "POPRC_50",
  "POPRC_F_15",
  "POPRC_F_15_49",
  "POPRC_F_50"
)]

rownames(SIDRA_RS) = NULL

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5:Exportar o banco de dados com o nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv)

write.csv(
  SIDRA_RS,
  "SIDRA_RS.csv",
  row.names = FALSE
)

# Ao terminar a Tarefa 5 commit com o comentário "dados SIDRA_UF 2016 e script - SIDRA - tarefas 1 a 5"  e envie para o repositório Projeto_BDEM_2016


####################################
# ETAPA 4: BANCOS DE DADOS DO ATLAS
####################################
# Você deve criar e estar na branch ATLAS antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# codigos_IBGE_2010 para códigos dos municípios - 2010.csv
# dados_atlas_1 para IDHM - 2010 (CENSO) e 2016 (PNAD) - total e por sexo - UF - Atlas Brasil.csv
# dados_atlas_2 para IDHM - 2010 - municípios - Atlas Brasil.csv
# Atenção que agora alguns arquivos só têm os nomes dos municípios e das UFs, mas não têm os códigos


codigos_IBGE_2010 = read.csv(
  "códigos dos municípios - 2010.csv",
  sep = ";",
  fileEncoding = "UTF-8"
)

dados_atlas_1 = read.csv(
  "IDHM - 2010 (CENSO) e 2016 (PNAD) - total e por sexo - UF - Atlas Brasil.csv",
  sep = ";",
  fileEncoding = "latin1"
)

dados_atlas_2 = read.csv(
  "IDHM - 2010 - municípios - Atlas Brasil.csv",
  sep = ";",
  fileEncoding = "UTF-8"
)


# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

head(codigos_IBGE_2010)
head(dados_atlas_1)
head(dados_atlas_2)

str(codigos_IBGE_2010)
str(dados_atlas_1)
str(dados_atlas_2)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - ATLAS - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Manipular o banco de dados e criar o banco de dados ATLAS_UF

# Criar o banco UF_codigo tipo tabela de correspondência
UF_codigo = data.frame(
  UF = c("Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins",
         "Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba",
         "Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais",
         "Espírito Santo","Rio de Janeiro","São Paulo","Paraná",
         "Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul",
         "Mato Grosso","Goiás","Distrito Federal"),
  
  SIGLA = c("RO","AC","AM","RR","PA","AP","TO",
            "MA","PI","CE","RN","PB","PE","AL",
            "SE","BA","MG","ES","RJ","SP",
            "PR","SC","RS","MS","MT","GO","DF"),
  
  CODUF = c(11,12,13,14,15,16,17,
            21,22,23,24,25,26,27,
            28,29,31,32,33,35,
            41,42,43,50,51,52,53)
)

# Retirar de dados_atlas_1 a linha do Brasil e adicionar (com merge by UF) as colunas de UF_codigo

dados_atlas_1 = dados_atlas_1[
  dados_atlas_1$UF != "Brasil",
]

dados_atlas_1 = merge(
  dados_atlas_1,
  UF_codigo,
  by = "UF"
)

# Criar o banco linha_estado somente com as linhas da UF e com as seguintes colunas:
# ANO=2016, NIVEL=UF, CODMUNRES, IDHM_A, IDHM_CA, IDHM_CA_M e IDHM_CA_F 

linha_estado = data.frame(
  ANO = 2016,
  NIVEL = "UF",
  CODMUNRES = dados_atlas_1$CODUF,
  IDHM_A = dados_atlas_1$IDHM_2016,
  IDHM_CA = dados_atlas_1$IDHM_2010,
  IDHM_CA_M = dados_atlas_1$IDHM_2010_M,
  IDHM_CA_F = dados_atlas_1$IDHM_2010_F
)

# Selecionar de linha_estado a UF da responsabilidade do aluno por CODMUNRES

linha_estado = linha_estado[
  linha_estado$CODMUNRES == 43,
]

# Criar em dados_atlas_2 a coluna com UF

dados_atlas_2$UF = sub(
  ".*\\(([A-Z]{2})\\)$",
  "\\1",
  dados_atlas_2$município
)

# Retirar (UF) da variável município

dados_atlas_2$município = sub(
  " \\([A-Z]{2}\\)$",
  "",
  dados_atlas_2$município
)

# Acrescentar em codigos_IBGE_2010 a variável CODUF baseado nos dois primeiros dígitos de CODMUNRES


codigos_IBGE_2010$CODUF = as.numeric(
  substr(codigos_IBGE_2010$CODMUNRES, 1, 2)
)

# Acrescentar a codigos_IBGE_2010 as variáveis de UF_codigo (merge by CODUF)

codigos_IBGE_2010 = merge(
  codigos_IBGE_2010,
  UF_codigo,
  by = "CODUF"
)

# Associar dados_atlas_2 a codigos_IBGE_2010 e nomear o novo arquivo por atlas_municipio
# Neste caso o merge será by.x = c("município","UF") e by.y = c("município","SIGLA")

#Consertando o nome de um município
codigos_IBGE_2010$município[
  codigos_IBGE_2010$CODMUNRES == 3530805
] = "Mogi Mirim"


atlas_municipio = merge(
  dados_atlas_2,
  codigos_IBGE_2010,
  by.x = c("município", "UF"),
  by.y = c("município", "SIGLA")
)

# Remover de atlas_municipio a coluna UF.y criada no merge

atlas_municipio$UF.y = NULL

# Selecionar somente a UF de responsabilidade do aluno através dos dois primeiros dógitos de CODMUNRES

atlas_municipio = atlas_municipio[
  substr(atlas_municipio$CODMUNRES, 1, 2) == "43",
]

# Criar banco ATLAS_MUNICIPIO com as linhas dos municípios e com as seguintes variáveis:
# ANO=2016, NIVEL=MUNICIPIO, CODMUNRES, IDHM_A=NA, IDHM_CA, IDHM_CA_M=NA, IDHM_CA_F=NA

ATLAS_MUNICIPIO = data.frame(
  ANO = 2016,
  NIVEL = "MUNICIPIO",
  CODMUNRES = atlas_municipio$CODMUNRES,
  IDHM_A = NA,
  IDHM_CA = atlas_municipio$IDHM_2010,
  IDHM_CA_M = NA,
  IDHM_CA_F = NA
)

# Criar banco final ATLAS_UF "juntando" os bancos linha_estado e ATLAS_MUNICIPIO

ATLAS_UF = rbind(
  linha_estado,
  ATLAS_MUNICIPIO
)

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - ATLAS - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Exportar o banco de dados com o nome ATLAS_UF.csv (Exemplo: ATLAS_RJ.csv)

write.csv(
  ATLAS_UF,
  "ATLAS_RS.csv",
  row.names = FALSE,
  na = "NA"
)

# Ao terminar a Tarefa 3 commit com o comentário "dados ATLAS_UF 2016 e script - ATLAS - tarefas 1 a 3"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 5: BANCOS DE DADOS DO SINISA
####################################
# Você deve criar e estar na branch SINISA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler o bancos de dados abaixo listado com os respectivo nome
# dados_sinisa para agua e esgoto - município - 2016.csv
# Atenção que o arquivo tem códigos e nomes de municípios e muitos NAs. 
# Repare que os valores estão com o milhar indicado por ponto, o que não deve acontecer para o R não entender como decimal

dados_sinisa = read.csv2(file = "agua e esgoto - município - 2016.csv",
                        dec = ",",
                        fileEncoding = "latin1",
                        sep = ";")

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados
# Remover a pontuação de milhar e converter para formato numérico

head(dados_sinisa)
str(dados_sinisa)

#Removendo os pontos e transformando as colunas em formato numérico
dados_sinisa$POPR_RA = as.numeric(
  gsub(".", "", dados_sinisa$POPR_RA, fixed = TRUE)
)

dados_sinisa$POPR_RE = as.numeric(
  gsub(".", "", dados_sinisa$POPR_RE, fixed = TRUE)
)

str(dados_sinisa)

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINISA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sinisa apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinisa_1

dados_sinisa_1 = dados_sinisa[
  substr(dados_sinisa$CODMUNRES, 1, 2) == "43",
]

#Resetando a contagem de linhas
rownames(dados_sinisa_1) = NULL

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Criar um banco de dados, de nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 3 - SINISA.pdf”

#Criando a primeira linha, referente ao estado
linha_estado = data.frame(
  ANO = 2016,
  NIVEL = "UF",
  CODMUNRES = 43,
  POPR_RA = sum(dados_sinisa_1$POPR_RA, na.rm = TRUE),
  POPR_RE = sum(dados_sinisa_1$POPR_RE, na.rm = TRUE)
)

#Criando a base com as demais linhas, dos municípios
linhas_municipios = data.frame(
  ANO = dados_sinisa_1$Ano.de.Referência,
  NIVEL = "MUNICIPIO",
  CODMUNRES = dados_sinisa_1$CODMUNRES,
  POPR_RA = dados_sinisa_1$POPR_RA,
  POPR_RE = dados_sinisa_1$POPR_RE
)

#Juntando tudo
SINISA_RS = rbind(linha_estado, linhas_municipios)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Exportar o banco de dados com o nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv)

write.csv(
  SINISA_RS,
  "SINISA_RS.csv",
  row.names = FALSE,
  na = "NA"
)

# Ao terminar a Tarefa 4 commit com o comentário "dados SINISA_UF 2016 e script - SINISA - tarefas 1 a 4"  e enviar para o repositório Projeto_BDEM_2016



################################
# ETAPA 6: CRIAÇÃO DE BDEM_UF
################################
# Você deve estar agora em main e antes de inserir qualquer comando desta ETAPA
# deverá fazer os merges de cada uma das 5 branches. A cada merge pode fazer o comentário "merge da branch TAL"
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Agregar os arquivos SIDRA_UF, ATLAS_UF, SINASC_UF, SIM_UF, SINISA_UF no banco BDEM_UF (Exemplo: BDEM_RJ)
# Leitura dos 5 bancos de dados expeortados das etapas anteriores

SIDRA_RS = read.csv("SIDRA_RS.csv")
ATLAS_RS = read.csv("ATLAS_RS.csv")
SINASC_RS = read.csv("SINASC_RS.csv",
                     sep = ";")
SIM_RS = read.csv("SIM_RS.csv")
SINISA_RS = read.csv("SINISA_RS.csv")


# Agregação dos bancos
# Lembre-se que SIDRA e ATLAS tem CODMUNRES com 7 dígitos e SINASC, SIM e SINISA com 6 dígitos
# Além disso dentro do merge all = TRUE garante a manutenção de qualquer município presente em um dos bancos envolvidos no merge

#Padronizando os códigos de município
SIDRA_RS$CODMUNRES[-1] = as.numeric(
  substr(
    as.character(SIDRA_RS$CODMUNRES[-1]),
    1,
    nchar(as.character(SIDRA_RS$CODMUNRES[-1])) - 1
  )
)

ATLAS_RS$CODMUNRES[-1] = as.numeric(
  substr(
    as.character(ATLAS_RS$CODMUNRES[-1]),
    1,
    nchar(as.character(ATLAS_RS$CODMUNRES[-1])) - 1
  )
)

#Agregando os bancos de dados
BDEM_RS = merge(
  SIDRA_RS,
  ATLAS_RS[, !(names(ATLAS_RS) %in% c("ANO", "NIVEL"))],
  by = "CODMUNRES",
  all = TRUE
)

BDEM_RS = merge(
  BDEM_RS,
  SINASC_RS[, !(names(SINASC_RS) %in% c("ANO", "NIVEL"))],
  by = "CODMUNRES",
  all = TRUE
)

BDEM_RS = merge(
  BDEM_RS,
  SIM_RS[, !(names(SIM_RS) %in% c("ANO", "NIVEL"))],
  by = "CODMUNRES",
  all = TRUE
)

BDEM_RS = merge(
  BDEM_RS,
  SINISA_RS[, !(names(SINISA_RS) %in% c("ANO", "NIVEL"))],
  by = "CODMUNRES",
  all = TRUE
)

#Verificando a base agregada
dim(BDEM_RS)
head(BDEM_RS)
names(BDEM_RS)

#Corrigindo o município não identificado na base SIM
BDEM_RS$ANO[BDEM_RS$CODMUNRES == 430000] = 2016

BDEM_RS$NIVEL[BDEM_RS$CODMUNRES == 430000] = "MUNICIPIO"

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - BDEM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Inserir os seguintes indicadores epidemiológicos (com apenas dias casas decimais) no BDEM_UF:
# TFG: Taxa de fecundidade geral
# TMG: Taxa de mortalidade geral
# RMM: Razão de mortalidade materna
# TMM: Taxa de mortalidade materna
# TMM_P: Taxa de mortalidade materna em até 42 dias
# TMN: Taxa de mortalidade neonatal
# TMN_P: Taxa de mortalidade neonatal precoce
# TMN_T: Taxa de mortalidade neonatal tardia
# TMI: Taxa de mortalidade infantil

# Criando uma função para calcular as taxas dos indicadores
calcular_taxa = function(numerador, denominador, multiplicador) {
  resultado = rep(NA_real_, length(numerador))
  
  valido = !is.na(numerador) &
    !is.na(denominador) &
    denominador > 0
  
  resultado[valido] = round(
    numerador[valido] / denominador[valido] * multiplicador,
    2
  )
  
  resultado
}

# Taxa de fecundidade geral
BDEM_RS$TFG = calcular_taxa(
  BDEM_RS$TN,
  BDEM_RS$POPRC_F_15_49,
  1000
)

# Taxa de mortalidade geral
BDEM_RS$TMG = calcular_taxa(
  BDEM_RS$TO,
  BDEM_RS$POPRE_T,
  1000
)

# Razão de mortalidade materna
BDEM_RS$RMM = calcular_taxa(
  BDEM_RS$TO_MT_P,
  BDEM_RS$TN,
  100000
)

# Taxa de mortalidade materna
BDEM_RS$TMM = calcular_taxa(
  BDEM_RS$TO_MT,
  BDEM_RS$POPRC_F_15_49,
  100000
)

# Taxa de mortalidade materna precoce (até 42 dias)
BDEM_RS$TMM_P = calcular_taxa(
  BDEM_RS$TO_MT_P,
  BDEM_RS$POPRC_F_15_49,
  100000
)

# Taxa de mortalidade neonatal
BDEM_RS$TMN = calcular_taxa(
  BDEM_RS$TO_NT,
  BDEM_RS$TN,
  1000
)

# Taxa de mortalidade neonatal precoce
BDEM_RS$TMN_P = calcular_taxa(
  BDEM_RS$TO_NT_P,
  BDEM_RS$TN,
  1000
)

# Taxa de mortalidade neonatal tardia
BDEM_RS$TMN_T = calcular_taxa(
  BDEM_RS$TO_NT_T,
  BDEM_RS$TN,
  1000
)

# Taxa de mortalidade infantil
BDEM_RS$TMI = calcular_taxa(
  BDEM_RS$TO_NT + BDEM_RS$TO_PNT,
  BDEM_RS$TN,
  1000
)


# Conferir o banco BDEM_UF após inserção dos indicadores

dim(BDEM_RS)

names(BDEM_RS)[(ncol(BDEM_RS) - 8):ncol(BDEM_RS)]

head(BDEM_RS[, c(
  "CODMUNRES", "ANO", "NIVEL",
  "TFG", "TMG", "RMM", "TMM", "TMM_P",
  "TMN", "TMN_P", "TMN_T", "TMI"
)])

str(BDEM_RS[, c(
  "TFG", "TMG", "RMM", "TMM", "TMM_P",
  "TMN", "TMN_P", "TMN_T", "TMI"
)])

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - BDEM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3: Exportar o banco de dados com o nome BDEM_UF.csv (Exemplo: BDEM_RJ.csv)

write.csv(BDEM_RS, "BDEM_RS.csv",
          row.names = FALSE,
          na = "NA")

# Ao terminar a Tarefa 3 commit com o comentário "dados BDEM_UF 2016 e script - BDEM - tarefas 1 a 3"  e enviar para o repositório Projeto_BDEM_2016
 