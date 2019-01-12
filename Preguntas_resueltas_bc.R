"Pregunta b
Con las funciones entregadas anteriormente realice la extracción del título de la
noticia, y luego la noticia, separe las palabras y almacenarlas en una lista."

###################Extracción de titulo#################

#usando la libreria rvest
# install.packages("rvest"), para descargarla 

library("rvest")

#inicializando la variable archivo con el nombre de mi pagina
archivo<-"Tarea_5.html"

#leyendo el HTML del archivo
webpage <- read_html(archivo)

html_nodes(webpage,".naranjo")

#Extrayendo contenido en la clase naranjo
contenedor_titulo <- html_nodes(webpage,"h1")

#Pasando el titulo a texto 
titulo <- html_text(contenedor_titulo)
print(titulo)

#eliminando los \n , comilla ("), puntos (.) y comas (,) del texto 
titulo <- gsub("\n","", titulo)
titulo <- gsub("\t","", titulo)
titulo <- gsub("\r","", titulo)
print(titulo)

#Separando las palabras por espacio 
splitEspaciotitulo <- strsplit(titulo," ")[[1]]
print (splitEspaciotitulo)

#Almacer el titulo en una lista
unlisttitulo <- unlist (splitEspaciotitulo)
unlisttitulo
tablatitulo <-table(unlisttitulo)

#Pasando la info a un data frame
dfPalabrastitulo <- as.data.frame(tablatitulo)
dfPalabrastitulo

#Almacenamiento del titulo en CVS
write.csv(dfPalabrastitulo, file="Palabrastitulo.cvs")


##############################################################
#################Extracción de la noticia ####################
#############################################################

#inicializando la variable archivo con el nombre de mi pagina
archivo<-"Tarea_5final.html"

#leyendo el HTML del archivo
webpage <- read_html(archivo)

html_nodes(webpage,".justificado")

#Extrayendo contenido en la clase justificado
contenidoWebNoticia <- html_nodes(webpage,"h4")

#Pasando la noticia a texto 
textoNoticia <- html_text(contenidoWebNoticia)

#Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

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



"Pregunta C: Extraiga los datos de la tabla y almacénelos en una variable tipo data."

#######################################################
######Exraccion de informacion de la tabla#############
#######################################################

#inicializando la variable archivo con el nombre de mi pagina
archivo<-"Tarea_5final.html"

#leyendo el HTML del archivo
webpage <- read_html(archivo)


# Extrayendo los elementos que contienen las tablas
tablaProductos <- html_nodes(webpage, ".productos")

#Extrayendo el contenido de la tabla a traves de tag
contenedorDeTablas <- html_nodes(webpage, "table")

# Extraccion informacion tabla 1
tabla1<-html_table(contenedorDeTablas[1][[1]])

# Viendo el contenido de la posicion 1,2 de la tabla1
print(tabla1[1,2])

# Extraccion informacion tabla 2
tabla2<-html_table(contenedorDeTablas [2][[1]])

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


















