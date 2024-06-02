# Denna Dockerfil ställer upp en Python-miljö, installerar nödvändiga beroenden, kopierar projektfiler och kör en Django-server.


# Use the official Python image from the Docker Hub
# Måste köra den från python för att vi valde servern Django, vi väljer en specifik python-image som startpunkt for vår container
FROM python:3.10-slim

# Set the working directory inside the container
#När den bygger en container så bygger den en väg för containern att placeras i, alltså vart cotainern placeras
WORKDIR /app

# Copy the requirements file into the container
# (samma som json fast för python), punkten står för current directory, väljer kriterierna. kopierar filen requirements.txt från min lokala maskin till /app inne i containern. Punkten (.) betyder "nuvarande katalog," så filen går till arbetskatalogen som ställdes in tidigare
COPY requirements.txt .

# Install the dependencies
# Installerar de Python-paket som listas i requirements.txt med hjälp av pip, vilket är Pythons paketinstallationsprogram. --no-cache-dir-alternativet hjälper till att minska bildens storlek genom att inte cachea paketfilerna
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project into the container
# kopierar allt annat som ligger i filen, till app
COPY . .

# Expose the port the app runs on
# image/containern ser till att det hamnar på 
# talar om för Docker att containern kommer att lyssna på port 8000. Detta är användbart när du vill komma åt applikationen från utsidan av containern
EXPOSE 8000

# Command to run the Django server
# djangos start kommando: manage.py
# specificerar kommandot för att starta din applikation
CMD ["python", "blog_project/manage.py", "runserver", "0.0.0.0:8000"]
