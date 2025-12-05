FROM python:3.9

WORKDIR /www/html/epg

COPY . /www/html/epg
COPY ./nginx/epg.conf /etc/nginx/sites-enabled/epg.conf
COPY ./nginx/upstream-nginx.conf /etc/nginx/sites-enabled/upstream-nginx.conf
COPY ./uwsgi/epg.service /etc/systemd/system/epg.service

EXPOSE 8080
EXPOSE 8000

RUN apk update && apk --no-cache add openssl bash curl &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils &&\
    apk add --no-cache bash &&\
    chown -R www-data:www-data /var/www/html/epg &&\
    chmod -R 775 /var/www/html/epg &&\
    chmod +x manage.py &&\
    chmod +x main.py &&\
    pip install -r requirements.txt &&\
    systemctl start epg &&\
    systemctl enable epg
    
CMD ["python3", "/var/www/html/epg/manage.py runserver 0.0.0.0:8000"]
