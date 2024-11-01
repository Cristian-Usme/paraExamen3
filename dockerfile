# Usa una imagen ligera de Python
FROM python:3.8-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos HTML al contenedor
COPY app/static /app

# Expone el puerto 80
EXPOSE 80

# Ejecuta el servidor HTTP de Python
CMD ["python3", "-m", "http.server", "80"]