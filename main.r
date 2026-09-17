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