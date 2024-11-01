# Usa una imagen ligera de Python
FROM python:3.8-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos HTML al contenedor
COPY app/static /app


EXPOSE 80


CMD ["python3", "-m", "http.server", "80"]
