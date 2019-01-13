" Pregunta d: 
Ahora escoja un sitio web, guardarlo localmente y extraiga la información con alguna
de las dos formas vistas anteriormente " 

#inicializando la variable archivo con el nombre de mi pagina
archivo<-"santa_juana.html"

#leyendo el HTML del archivo
webpage <- read_html(archivo)

html_nodes(webpage,".cmsms_project_title entry-title")

#Extrayendo el titulo que esta contenido en la clase anterior
titulo <- html_nodes(webpage,"h2")

#Pasando el titulo a texto
nombre_perro<- html_text(titulo)

#Viendo a priori la info en la variable nombre perro
print(nombre_perro)

#####Extrayendo el texto, es decir, la informacion de la perrita#######

html_nodes(webpage,".cmsms_project_content entry-content")

#Extrayendo la informacion que esta contenida en la clase anterior
informacion <- html_nodes(webpage,"div.cmsms_project_content.entry-content")

#Pasando la informacion a texto
informacion_perrita <- html_text(informacion)
print(informacion_perrita)

#limpiando la informacion de la perrita

informacion_perrita <- gsub("\n","", informacion_perrita)
informacion_perrita <- gsub(",","", informacion_perrita)
informacion_perrita <- gsub(";","", informacion_perrita)
informacion_perrita <- gsub("[.]","", informacion_perrita)
informacion_perrita <- gsub(",","", informacion_perrita)

#Viendo a priori la informacion en la variable informacion_perrita
print(informacion_perrita)

#Separando las palabras por espacio 
splitEspacioperrita <- strsplit(informacion_perrita," ")[[1]]
splitEspacioperrita

#Pasando todas las palabras a minusculas
splitEspacioperritaminuscula <-  tolower(splitEspacioperrita)
splitEspacioperritaminuscula

#Contando palabras 
unlistinformacion <- unlist(splitEspacioperritaminuscula)
unlistinformacion
tablaperrita <- table(unlistinformacion)

#Pasando la info a un data frame
df_perrita<- as.data.frame(tablaperrita)
df_perrita

#Almacenamiento de información en CVS
write.csv(df_perrita, file="Palabrasperrita.cvs")

