FROM python:3.8-slim-buster

WORKDIR /www/html/epg

COPY . /www/html/epg

EXPOSE 8080
EXPOSE 8000

RUN apk update && apk --no-cache add openssl bash curl &&\
    chmod +x manage.py &&\
    chmod +x main.py &&\
    pip install -r requirements.txt
    
CMD ["python3", "/var/www/html/epg/manage.py runserver 0.0.0.0:8000"]
