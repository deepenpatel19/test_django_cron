FROM python:2.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
RUN apt-get update && apt-get purge nodejs && apt-get install -y --no-install-recommends gcc g++ default-libmysqlclient-dev libssl-dev libjpeg62-turbo-dev zlib1g-dev curl wget apt-transport-https gnupg2 nginx supervisor cron vim&& wget https://nodejs.org/dist/v6.4.0/node-v6.4.0-linux-x64.tar.xz && apt-get install -y xz-utils && tar -C /usr/local --strip-components 1 -xJf node-v6.4.0-linux-x64.tar.xz && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install -y yarn && sed '/st_mysql_options options;/a unsigned int reconnect;' /usr/include/mysql/mysql.h -i.bkp && apt-get clean && pip install Django==1.8 django-cron==0.5.0 uwsgi==2.0.18 django-common-helpers==0.9.2&& rm -rf /var/lib/apt/lists/*  && rm -rf /root/.cache
#RUN pip install Django==1.8 django-cron==0.5.0
ADD . /code/
#COPY . /code/
#EXPOSE 8081
#STOPSIGNAL SIGINT
#ENTRYPOINT ["python", "manage.py"]
#CMD ["runserver", "0.0.0.0:8081"]
RUN useradd --no-create-home nginx

RUN rm /etc/nginx/sites-enabled/default

RUN touch /var/log/cron.log

COPY nginx.conf /etc/nginx/
COPY django-site-nginx.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisor/

WORKDIR /code
EXPOSE 8081
CMD ["/usr/bin/supervisord"]
