Homework 1: Estatística para Engenharia (UFC)
Análise de Dados - Sistema de Compartilhamento de Bicicletas
Este repositório guarda o nosso primeiro trabalho prático de Estatística. A ideia aqui foi pegar os dados de aluguel de bicicletas de uma cidade dos EUA em 2011 e entender como a demanda funciona na prática. Ao longo do projeto, classificamos variáveis, calculamos as medidas de tendência central e dispersão (médias, medianas, quartis, outliers) e cruzamos tudo isso com o clima (temperatura, estação do ano, chuvas) para ver o que realmente impacta o uso do sistema.
A Nossa Amostra
Seguindo o roteiro da professora, não usamos as 731 linhas da base original. O nosso recorte de 300 dias foi calculado usando a matrícula mais alta do grupo (M).
 * Nossas matrículas: 580988, 580201, 582280, 582416
 * Maior matrícula (M): 582416 (João Pedro)
 * Onde a amostra começa (r): 1 + (582416 \pmod{100}) = 17
 * Nosso período: Da linha 17 até a 316 (que cobre de 17/01/2011 a 12/11/2011).
O trecho do código que faz esse recorte é bem direto:
# Puxando as matrículas e definindo os parâmetros da amostra
matriculas <- c(580988, 580201, 582280, 582416)
M <- max(matriculas)
r <- 1 + (M %% 100)

# Lendo o CSV original e cortando as 300 linhas exatas
dados_originais <- read.csv("HW1_bike_sharing.csv")
linha_final <- r + 299
data_group <- dados_originais[r:linha_final, ]

O que tem aqui
Organizamos os arquivos da seguinte forma para facilitar a execução e a correção:
 * HW1_bike_sharing.csv: A base de dados completa original.
 * main.r: O script principal que resolve e imprime as questões de 1 a 4.
 * README.md: Este guia que você está lendo.
 * Relatorio_Final.pdf: O documento oficial com as análises, cálculos manuais e conclusões.
 * graficos/: Uma pasta criada automaticamente pelo script na hora de salvar os gráficos (boxplots, histogramas e dispersão).
Como rodar o código
Fizemos questão de usar apenas o R base. Você não vai precisar instalar nenhum pacote extra pesado, como ggplot2 ou dplyr.
 * Faça o clone do repositório: git clone [https://github.com/leoal12/Homework-1](https://github.com/leoal12/Homework-1)
 * Abra a pasta do projeto no VS Code (recomendamos a extensão REditorSupport) ou no RStudio.
 * Confira se o arquivo HW1_bike_sharing.csv e o main.r estão soltos na mesma pasta.
 * No VS Code, abra o main.r, selecione todo o texto (Ctrl + A) e mande para o terminal (Ctrl + Enter), ou simplesmente clique no botão "Source" no canto superior direito.
 * Pronto! O terminal vai cuspir os resultados numéricos divididos por questão. Os gráficos vão abrir na sua tela e também serão salvos sozinhos dentro da pasta /graficos/.
Quem fez o que
O trabalho foi feito a oito mãos. Todo mundo bateu cabeça junto para alinhar a matemática, a lógica dos quartis e as interpretações, garantindo que o código e o relatório escrito falassem a mesma língua. A divisão do trabalho pesado ficou assim:
 * Leonardo Alves Moreira & Noah Martins: Cuidaram da programação no R. Montaram a lógica do script, trataram a amostra (data_group), organizaram os prints limpos no terminal e automatizaram a exportação das imagens.
 * Gabriel Sampaio & João Pedro: Ficaram com a parte analítica e a redação. Fizeram os cálculos manuais de validação, analisaram como o clima e as estações afetam os aluguéis (total_user) e escreveram o relatório técnico final dentro das normas acadêmicas.
