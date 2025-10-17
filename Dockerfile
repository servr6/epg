FROM python:3.10-alpine

WORKDIR /www/html/epg

COPY . .

EXPOSE 8080
EXPOSE 8000

RUN apk update && apk --no-cache add openssl bash curl &&\
    chmod +x manage.py &&\
    chmod +x main.py &&\
    pip install -r requirements.txt
    
CMD ["python3", "/var/www/html/epg/manage.py runserver 0.0.0.0:8000"]
