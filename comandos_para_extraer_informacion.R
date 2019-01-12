#usando la libreria rvest
# install.packages("rvest"), para descargarla 

library("rvest")

#inicializando la variable archivo con el nombre de mi pagina
archivo<-"Tarea_5final.html"

#leyendo el HTML del archivo
webpage <- read_html(archivo)

html_nodes(webpage,".justificado")


#Extrayendo contenido en la clase h2
contenidoWebNoticia <- html_nodes(webpage,"h4")

#Pasando la info a texto 
textoNoticia <- html_text(contenidoWebNoticia)

#Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

#Pregunta: ¿Qué representa el \n?

#eliminando los \n , comilla ("), puntos (.) y comas (,) del texto 
textoNoticia <- gsub("\n","", textoNoticia)
textoNoticia <- gsub("\t","", textoNoticia)
textoNoticia <- gsub("\ta","", textoNoticia)
textoNoticia <- gsub("© ","", textoNoticia)
textoNoticia <- gsub("Ã ","", textoNoticia)
textoNoticia <- gsub("ã ","", textoNoticia)
textoNoticia <- gsub("\r","", textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)
textoNoticia <- gsub("&acute;","á",textoNoticia)

#Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

#Separando las palabras por espacio 
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]
splitEspacioNoticia

#Pasando todas las palabras a minusculas
splitEspacioNoticia <-  tolower(splitEspacioNoticia)
splitEspacioNoticia

#Contando palabras 
unlistNoticia <- unlist(splitEspacioNoticia)
unlistNoticia
tablaPalabras <- table(unlistNoticia)

#Pasando la info a un data frame
dfPalabrasNoticia <- as.data.frame(tablaPalabras)
dfPalabrasNoticia

#Almacenamiento de información en CVS
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.cvs")

#o en un txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")


######Exraccion de informacion de la tabla#############

# Extrayendo los elementos que contienen las tablas
tablaProductos <- html_nodes(webpage, ".productos")

#Extrayendo el contenido de la tabla a traves de tag
contenedorDeTablas <- html_nodes(webpage, "table")

# Extraccion informacion tabla 1
tabla1<-html_table(contenedoresTablas [1][[1]])

# Viendo el contenido de la posicion 1,2 de la tabla1
print(tabla1[1,2])

# Extraccion informacion tabla 2
tabla2<-html_table(contenedoresTablas [2][[1]])

# Viendo el contenido de la posicion 2,2 de la tabla2
print(tabla2[2,2])

# Limpiando $ comas y cambios de puntos por coma
tabla1$Precio <- gsub("\\$","",tabla1$Precio)
tabla1$Precio <- gsub("[.]","",tabla1$Precio)
tabla1$Precio <- as.numeric(gsub(",",".",tabla1$Precio))

tabla2$Precio <- gsub("\\$","",tabla2$Precio)
tabla2$Precio <- gsub("[.]","",tabla2$Precio)
tabla2$Precio <- as.numeric(gsub(",",".",tabla2$Precio))

# Combinando los dos data frames y creando un tercer data frame
tablaMerge <- rbind(tabla1,tabla2)

# Realizando una busqueda en el dataframe
elementosEncontrados <- tablaMerge[which(tablaMerge$Supermercado == "Sodimac"), ]

# Creando una tercera columna "ProductoSupermercado" con la 
# intenciÃ³n de generando nombres Ãºnicos, esto es para
# graficar el valor de cada producto en cada supermercado
tablaMerge$ProductoSupermercado <- paste(tablaMerge$Producto," ",tablaMerge$Supermercado) 

################### Graficando los productos
library('ggplot2')

# GrÃ¡fico Barra por producto concatenado con supermercado,
# respecto al costo
tablaMerge %>%
  ggplot() +
  aes(x = ProductoSupermercado, y = Precio) +
  geom_bar(stat="identity")

# GrÃ¡fico boxplot diferenciado por producto
tablaMerge %>%
  ggplot() +
  geom_boxplot(aes(x = ProductoSupermercado, y = Precio)) +
  theme_bw()







