FROM python:3.9

WORKDIR /var/www/html/epg

COPY . /var/www/html/epg
COPY ./nginx/epg.conf /etc/nginx/sites-enabled/epg.conf
COPY ./nginx/upstream-nginx.conf /etc/nginx/sites-enabled/upstream-nginx.conf
COPY ./uwsgi/epg.service /etc/systemd/system/epg.service

EXPOSE 8080
EXPOSE 8000

RUN chown -R www-data:www-data /var/www/html/epg
RUN chmod +x /var/www/html/manage.py
RUN chmod +x /var/www/html/main.py
RUN pip install -r requirements.txt
RUN systemctl start epg
RUN systemctl enable epg
    
CMD ["python3", "/var/www/html/epg/manage.py runserver 0.0.0.0:8000"]
