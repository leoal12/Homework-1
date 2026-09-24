# ==========================================
# QUESTÃO 1
# ==========================================

# 1. Carregar o arquivo original
# Certifique-se de que o arquivo .csv está na mesma pasta do script
dados_originais <- read.csv("HW1_bike_sharing.csv")

# 2. Definir as matrículas do grupo e calcular M e r
matriculas <- c(580988, 580201, 592280) # Leonardo, Gabriel e Noah
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
cat("   Noah Martins: 592280\n\n")

cat("2. Parâmetros da Amostra:\n")
cat("   Maior matrícula (M) = ", M, "\n")
cat("   Início da amostra (r) = ", r, "\n\n")

cat("3. Período Observado:\n")
cat("   Data inicial: ", data_group$dteday[1], "\n")
cat("   Data final: ", data_group$dteday[nrow(data_group)], "\n")

# ==========================================
# CÁLCULOS DAS 10 PRIMEIRAS OBSERVAÇÕES
# ==========================================

# 5. Isolar as 10 primeiras linhas da amostra do grupo
primeiras_10 <- data_group[1:10, ]

# Criar a variável total_user conforme exigido pelo roteiro
primeiras_10$total_user <- primeiras_10$casual + primeiras_10$registered

# 6. Gerar os resultados estatísticos no R para comparar com o cálculo manual
resumo_estatistico <- summary(primeiras_10$total_user)
print(resumo_estatistico)



# ==========================================
# QUESTÃO 2
# ==========================================

# Pré-requisito: Criar a variável total_user para TODAS as 300 linhas da amostra
data_group$total_user <- data_group$casual + data_group$registered

cat("\n========================= Segunda Questão =========================\n")

# ---------------------------------------------------------
# ITEM 2.1: Valores Ausentes
# ---------------------------------------------------------
cat("--- Item 2.1: Valores Ausentes ---\n")
total_na <- sum(is.na(data_group))
cat("Total de valores ausentes (NA) no conjunto de dados:", total_na, "\n\n")

# ---------------------------------------------------------
# ITEM 2.2: Medidas de Tendência Central
# ---------------------------------------------------------
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

# ---------------------------------------------------------
# ITEM 2.3: Quartis, Intervalo Interquartil e Valores Atípicos
# ---------------------------------------------------------
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

# ---------------------------------------------------------
# ITEM 2.4: Gráficos (Histograma e Boxplot)
# ---------------------------------------------------------
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

# ---------------------------------------------------------
# ITEM 2.5: Variável Binária (low_usage)
# ---------------------------------------------------------
cat("--- Item 2.5: Dias de Baixa Utilização (low_usage) ---\n")
# Criação da variável binária conforme a Equação 1 do enunciado
data_group$low_usage <- ifelse(data_group$total_user < Q1, 1, 0)

dias_baixa_utilizacao <- sum(data_group$low_usage)
proporcao_baixa <- dias_baixa_utilizacao / nrow(data_group)

cat("Critério Q1:", Q1, "\n")
cat("Número de dias com baixa utilização:", dias_baixa_utilizacao, "\n")
cat("Proporção de dias com baixa utilização:", proporcao_baixa * 100, "%\n")
cat("====================================================================\n")