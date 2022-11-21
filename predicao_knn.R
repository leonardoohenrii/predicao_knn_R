library(class)

# Carrega dataset
dataset_cancer <- read.csv2("D:/green_lake/Projetos/cancer/dataset/Breast_cancer_data.csv", sep = ",")
dataset_cancer[, 1:6] <- sapply(dataset_cancer, as.numeric)

# Separa as linhas até a ultima coluna
row.labels = dataset_cancer[, 6]


# transformacao em matriz
dataset_cancer[, 1:5] <- scale(dataset_cancer[,1:5])

set.seed(01)

# passa como parametro 100% das linhas do dataset
tamanho <- floor(1 * nrow(dataset_cancer))

# Indicador valores para treino
indicador_treino <- sample(seq_len(nrow(dataset_cancer)), size = tamanho)

# Treino Classificação
class_treino <- dataset_cancer[indicador_treino,6]

# Teste Classificação
class_teste <- row.labels[indicador_treino]

# data.frame Treino
dataset_cancer_treino <- dataset_cancer[indicador_treino,1:5]

# data.frame teste
dataset_cancer_teste <- dataset_cancer[indicador_treino,1:5]

# Rodando o modelo
predicao <- knn(train = dataset_cancer_treino,
                test = dataset_cancer_teste,
                cl = class_treino,
                k = round(sqrt(nrow(dataset_cancer_treino))))

# Transforma a predição em um Data Frame
predicao <- data.frame(predicao)

# aplica o resultado ao Data Frame Original 
resultado <- cbind(dataset_cancer, predicao)

# Exporta para CSV
write.csv2(resultado, file = "D:/green_lake/Projetos/cancer/resultado/predicao_cancer.csv", row.names = FALSE, na = "") #nolint