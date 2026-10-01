
# QUESTÃO 1


# 1. Carregar o arquivo original
# Certifique-se de que o arquivo .csv está na mesma pasta do script
dados_originais <- read.csv("HW1_bike_sharing.csv")

# 2. Definir as matrículas do grupo e calcular M e r
matriculas <- c(580988, 580201, 582280, 582416) # Leonardo, Gabriel, Noah e João Pedro
M <- max(matriculas)                    # Encontra a maior matrícula
r <- 1 + (M %% 100)                     # Operador %% calcula o módulo

# 3. Construir o data_group (300 observações a partir de r)
linha_final <- r + 299
data_group <- dados_originais[r:linha_final, ]

# 4. Obter as datas da primeira e da última observação para o relatório
primeira_data <- data_group$dteday[1]
ultima_data <- data_group$dteday[nrow(data_group)]

cat("1. Matrículas da Equipe:\n")
cat("   Leonardo Alves Moreira: 580988\n")
cat("   Gabriel Sampaio: 580201\n")
cat("   Noah Martins: 582280\n")
cat("   João Pedro: 582416\n\n")

cat("2. Parâmetros da Amostra:\n")
cat("   Maior matrícula (M) = ", M, "\n")
cat("   Início da amostra (r) = ", r, "\n\n")

cat("3. Período Observado:\n")
cat("   Data inicial: ", data_group$dteday[1], "\n")
cat("   Data final: ", data_group$dteday[nrow(data_group)], "\n")

# CÁLCULOS DAS 10 PRIMEIRAS OBSERVAÇÕES


# 5. Isolar as 10 primeiras linhas da amostra do grupo
primeiras_10 <- data_group[1:10, ]

# Criar a variável total_user conforme exigido pelo roteiro
primeiras_10$total_user <- primeiras_10$casual + primeiras_10$registered

# 6. Gerar os resultados estatísticos no R para comparar com o cálculo manual
resumo_estatistico <- summary(primeiras_10$total_user)
print(resumo_estatistico)



# QUESTÃO 2


# Pré-requisito: Criar a variável total_user para TODAS as 300 linhas da amostra
data_group$total_user <- data_group$casual + data_group$registered

cat("\n========================= Segunda Questão =========================\n")
# ITEM 2.1: Valores Ausentes
# ---------------------------------------------------------
cat("--- Item 2.1: Valores Ausentes ---\n")
total_na <- sum(is.na(data_group))
cat("Total de valores ausentes (NA) no conjunto de dados:", total_na, "\n\n")


# ITEM 2.2: Medidas de Tendência Central

cat("--- Item 2.2: Tendência Central (total_user) ---\n")
media_tu <- mean(data_group$total_user)
mediana_tu <- median(data_group$total_user)

# Função para calcular a moda (já que o R não tem uma nativa para isto)
calcula_moda <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
moda_tu <- calcula_moda(data_group$total_user)

cat("Média:", media_tu, "\n")
cat("Mediana:", mediana_tu, "\n")
cat("Moda:", moda_tu, "\n\n")

# ITEM 2.3: Quartis, Intervalo Interquartil e Valores Atípicos

cat("--- Item 2.3: Quartis e Outliers (total_user) ---\n")
quartis <- quantile(data_group$total_user)
Q1 <- quartis[2]
Q2 <- quartis[3]
Q3 <- quartis[4]
IQR_tu <- IQR(data_group$total_user)

limite_inferior <- Q1 - 1.5 * IQR_tu
limite_superior <- Q3 + 1.5 * IQR_tu

# Filtrar os outliers
outliers <- subset(data_group, total_user < limite_inferior | total_user > limite_superior)

cat("Q1 (25%):", Q1, "\n")
cat("Q2 (50% / Mediana):", Q2, "\n")
cat("Q3 (75%):", Q3, "\n")
cat("Intervalo Interquartil (IQR):", IQR_tu, "\n")
cat("Limites de Normalidade: [", limite_inferior, " a ", limite_superior, "]\n")
cat("Número de valores atípicos (outliers):", nrow(outliers), "\n")
if(nrow(outliers) > 0) {
  cat("Datas dos outliers:\n")
  print(outliers[, c("dteday", "total_user")])
}
cat("\n")

# ITEM 2.4: Gráficos (Histograma e Boxplot)

# O comando par(mfrow=c(1,2)) organiza a janela gráfica para mostrar os 2 gráficos lado a lado
par(mfrow=c(1,2)) 

hist(data_group$total_user, 
     main = "Distribuição: Total de Utilizadores", 
     xlab = "Total de Utilizadores", 
     ylab = "Frequência", 
     col = "lightblue", 
     border = "black")

boxplot(data_group$total_user, 
        main = "Boxplot: Total de Utilizadores", 
        ylab = "Total de Utilizadores", 
        col = "lightgreen")


# ITEM 2.5: Variável Binária (low_usage)

cat("--- Item 2.5: Dias de Baixa Utilização (low_usage) ---\n")
# Criação da variável binária conforme a Equação 1 do enunciado
data_group$low_usage <- ifelse(data_group$total_user < Q1, 1, 0)

dias_baixa_utilizacao <- sum(data_group$low_usage)
proporcao_baixa <- dias_baixa_utilizacao / nrow(data_group)

cat("Critério Q1:", Q1, "\n")
cat("Número de dias com baixa utilização:", dias_baixa_utilizacao, "\n")
cat("Proporção de dias com baixa utilização:", proporcao_baixa * 100, "%\n")
cat("====================================================================\n")

# QUESTÃO 3

cat("\n========================= Terceira Questão =========================\n")
 
# Rótulos para leitura (temp já é dado em [0,1]; season/weathersit são códigos)
data_group$season_label <- factor(data_group$season,
                                   levels = 1:4,
                                   labels = c("Primavera", "Verão", "Outono", "Inverno"))
 
data_group$weather_label <- factor(data_group$weathersit,
                                    levels = 1:4,
                                    labels = c("Céu limpo", "Nublado", "Chuva fraca", "Chuva forte"))
 

# ITEM 3.1: Utilização por Estação do Ano

cat("--- Item 3.1: total_user por Estação ---\n")
 
media_estacao   <- tapply(data_group$total_user, data_group$season_label, mean)
mediana_estacao <- tapply(data_group$total_user, data_group$season_label, median)
dp_estacao      <- tapply(data_group$total_user, data_group$season_label, sd)
prop_low_estacao <- tapply(data_group$low_usage, data_group$season_label, mean)
 
tabela_estacao <- data.frame(
  Media = round(media_estacao, 1),
  Mediana = mediana_estacao,
  DesvioPadrao = round(dp_estacao, 1),
  Prop_Low_Usage = round(prop_low_estacao * 100, 1)
)
print(tabela_estacao)
 
# Restaurando o layout gráfico para 1 imagem por vez
par(mfrow=c(1,1))

boxplot(total_user ~ season_label, data = data_group,
        main = "Total de Usuários por Estação do Ano",
        xlab = "Estação", ylab = "Total de Usuários",
        col = c("lightgreen", "khaki", "orange", "lightblue"))
 
 
# ITEM 3.2: Utilização por Condição Meteorológica

cat("\n--- Item 3.2: total_user por Condição Meteorológica ---\n")
 
media_clima <- tapply(data_group$total_user, data_group$weather_label, mean)
dp_clima    <- tapply(data_group$total_user, data_group$weather_label, sd)
prop_low_clima <- tapply(data_group$low_usage, data_group$weather_label, mean)
 
tabela_clima <- data.frame(
  Media = round(media_clima, 1),
  DesvioPadrao = round(dp_clima, 1),
  Prop_Low_Usage = round(prop_low_clima * 100, 1)
)
print(tabela_clima)
 
cat("\nContagem de dias por condição meteorológica:\n")
print(table(data_group$weather_label))
 
boxplot(total_user ~ weather_label, data = data_group,
        main = "Total de Usuários por Condição Meteorológica",
        xlab = "Condição", ylab = "Total de Usuários",
        col = c("lightblue", "gray80", "skyblue", "darkblue"))

# ITEM 3.3: Relação entre Temperatura e total_user

cat("\n--- Item 3.3: Temperatura x total_user ---\n")
 
correlacao <- cor(data_group$temp, data_group$total_user, method = "pearson")
cat("Coeficiente de correlação de Pearson:", round(correlacao, 3), "\n")
 
plot(data_group$temp, data_group$total_user,
     main = "Relação entre Temperatura e Total de Usuários",
     xlab = "Temperatura (normalizada)", ylab = "Total de Usuários",
     pch = 19, col = "steelblue")
abline(lm(total_user ~ temp, data = data_group), col = "red", lwd = 2)
 
cat("\n====================================================================\n")
 

# QUESTÃO 4

cat("\n========================= Quarta Questão =========================\n")
 

# ITEM 4.1: Série temporal de total_user 
cat("--- Item 4.1: Série Temporal de total_user ---\n")
 
data_group$dteday <- as.Date(data_group$dteday)
 
plot(data_group$dteday, data_group$total_user, type = "l",
     main = "Série Temporal do Total de Usuários",
     xlab = "Data", ylab = "Total de Usuários", col = "steelblue")
 
# Marca visualmente o dia de maior e o de menor utilização
dia_max <- data_group[which.max(data_group$total_user), ]
dia_min <- data_group[which.min(data_group$total_user), ]
points(dia_max$dteday, dia_max$total_user, col = "darkgreen", pch = 19)
points(dia_min$dteday, dia_min$total_user, col = "red", pch = 19)
 
cat("Dia de maior utilização:", as.character(dia_max$dteday), "-", dia_max$total_user, "usuários\n")
cat("Dia de menor utilização:", as.character(dia_min$dteday), "-", dia_min$total_user, "usuários\n")

# ---------------------------------------------------------
# ITEM 4.2: Retomando as duas características da Questão 3
# ---------------------------------------------------------
cat("\n--- Item 4.2: Associação de cada característica com total_user ---\n")

# Criar a pasta 'graficos' automaticamente se ela ainda não existir
if(!dir.exists("graficos")) {
  dir.create("graficos")
}
 
cat("\n[Estação]\n")
anova_estacao <- aov(total_user ~ season_label, data = data_group)
print(summary(anova_estacao))
png("graficos/4_2_A_boxplot_estacao.png", width = 800, height = 600)
boxplot(total_user ~ season_label, data = data_group,
        main = "Revisão: total_user por Estação",
        xlab = "Estação", ylab = "Total de Usuários")
dev.off()
 
cat("\n[Condição Meteorológica]\n")
anova_clima <- aov(total_user ~ weather_label, data = data_group)
print(summary(anova_clima))
png("graficos/4_2_B_boxplot_clima.png", width = 800, height = 600)
boxplot(total_user ~ weather_label, data = data_group,
        main = "Revisão: total_user por Condição Meteorológica",
        xlab = "Condição", ylab = "Total de Usuários")
dev.off()
 

# ITEM 4.3: Temperatura x total_user, distinguindo low_usage

cat("\n--- Item 4.3: Temperatura x total_user, por low_usage ---\n")
 
cores_low_usage <- ifelse(data_group$low_usage == 1, "red", "steelblue")
 
png("graficos/4_3_dispersao_temp_low_usage.png", width = 800, height = 600)
plot(data_group$temp, data_group$total_user,
     main = "Temperatura x Total de Usuários (por Nível de Utilização)",
     xlab = "Temperatura (normalizada)", ylab = "Total de Usuários",
     pch = 19, col = cores_low_usage)
legend("topleft", legend = c("Baixa utilização", "Utilização normal"),
       col = c("red", "steelblue"), pch = 19)
dev.off()
 
# Correlação separada para os dois grupos (ajuda a comparar no relatório)
cor_baixa <- cor(data_group$temp[data_group$low_usage == 1],
                  data_group$total_user[data_group$low_usage == 1])
cor_normal <- cor(data_group$temp[data_group$low_usage == 0],
                   data_group$total_user[data_group$low_usage == 0])
cat("Correlação temp x total_user (dias de baixa utilização):", round(cor_baixa, 3), "\n")
cat("Correlação temp x total_user (demais dias):", round(cor_normal, 3), "\n")
