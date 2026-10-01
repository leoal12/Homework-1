Análise Estatística: Sistema de Compartilhamento de Bicicletas (Homework 1)
Disciplina: Estatística para Engenharia Instituição: Universidade Federal do Ceará (UFC)

Descrição do Projeto
Este projeto realiza uma análise estatística descritiva completa sobre a utilização diária de um sistema de compartilhamento de bicicletas nos Estados Unidos, com base no ano de 2011.

O escopo do trabalho engloba a classificação de variáveis, o cálculo de medidas de tendência central e dispersão (médias, medianas, quartis, limites interquartis para deteção de outliers), além da análise de impacto de fatores climáticos e sazonais na demanda (usando variáveis como weathersit e season). A análise explora ainda a correlação linear entre a temperatura e o uso do sistema.

Metodologia de Amostragem
Conforme exigido pelo roteiro do projeto, não utilizamos o conjunto de dados completo. Isolamos uma amostra contínua de 300 dias baseada no maior número de matrícula do grupo (
M
).

Matrículas da equipe: 580988, 580201, 582280, 582416
Maior matrícula (
M
): 582416 (João Pedro)
Cálculo do ponto de partida (
r
): 
r
=
1
+
(
582416
(
mod
100
)
)
=
17
Escopo final da amostra: Linha 17 até a linha 316 (Período observado: 17/01/2011 a 12/11/2011).
Trecho de código utilizado para o recorte:

# Definição das matrículas e cálculo dos parâmetros
matriculas <- c(580988, 580201, 582280, 582416)
M <- max(matriculas)
r <- 1 + (M %% 100)

# Leitura e recorte (300 observações a partir de r)
dados_originais <- read.csv("HW1_bike_sharing.csv")
linha_final <- r + 299
data_group <- dados_originais[r:linha_final, ]

 Estrutura do Repositório
​Para garantir a reprodutibilidade e organização, os arquivos estão distribuídos da seguinte forma:
 homework-1-estatistica
 ┣  HW1_bike_sharing.csv     # Base de dados original completa (731 obs.)
 ┣  main.r                   # Script principal com todas as análises (Q1 a Q4)
 ┣  README.md                # Documentação e instruções de execução
 ┣  Relatorio_Final.pdf      # Documento consolidado com análises e interpretações
 ┗  graficos/                # Diretório autogerado com os gráficos (png) da execução

 Como Executar a Análise
​O script foi desenvolvido usando as bibliotecas nativas da linguagem R, dispensando a instalação de pacotes externos pesados (como ggplot2 ou dplyr).

1.Clone o repositório:
git clone [(https://github.com/leoal12/Homework-1)]
2.Abra o ambiente: Abra a pasta clonada no VS Code (com a extensão REditorSupport) ou no RStudio.
3.Verifique os arquivos: Certifique-se de que o arquivo HW1_bike_sharing.csv e o script main.r estão no mesmo diretório de trabalho.
4.Execute o código:
​No VS Code: Abra o arquivo main.r, selecione todo o texto (Ctrl + A) e pressione Ctrl + Enter para enviar ao terminal, ou clique no botão Source no canto superior direito.
5.Resultados: O terminal exibirá toda a parte numérica estruturada por questões. As visualizações (boxplots, histogramas e gráficos de dispersão) aparecerão na interface gráfica e serão salvas automaticamente na pasta /graficos/.
 Autores e Colaboração
​O trabalho foi desenvolvido de forma colaborativa. As metodologias matemáticas, convenções de quartis e interpretações lógicas foram debatidas por toda a equipe para garantir a consistência entre o código e o relatório escrito. A divisão principal de tarefas operacionais ocorreu da seguinte forma:
​Leonardo Alves Moreira & Noah Martins: Responsáveis pela formulação algorítmica, tratamento do conjunto de dados (data_group), desenvolvimento das análises em linguagem R, padronização visual das saídas de terminal e geração automatizada de gráficos.
​Gabriel Sampaio & João Pedro: Responsáveis pela interpretação estatística dos resultados, avaliação da influência das variáveis macroclimáticas sobre a demanda (total_user), cálculo manual de validação e redação técnica do relatório final em conformidade com as normas acadêmicas.
Deixe menos parecido com ia
