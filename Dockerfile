# Dockerfile
# Usa una imagen base de Python ligera
FROM python:3.9-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo de requerimientos primero (aprovecha el caché de Docker)
COPY requirements.txt requirements.txt

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código de la aplicación
COPY . .

# Expón el puerto en el que Gunicorn escuchará (Flask por defecto es 5000, Gunicorn a menudo 8000 o 5000)
# Gunicorn por defecto usa 8000, pero podemos decirle que use otro. Usemos 8080 como ejemplo.
EXPOSE 8080

# Comando para ejecutar la aplicación usando Gunicorn
# Escucha en todas las interfaces (0.0.0.0) en el puerto 8080
# 'main:app' le dice a Gunicorn que busque la instancia 'app' en el archivo 'main.py'
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
