FROM node

RUN npm -g install bower brunch

RUN adduser web
RUN mkdir -p /usr/share/nginx/www/ && \
    chown -R web /usr/share/nginx/www/

ADD . /opt/web
RUN chown -R web /opt/web
USER web
WORKDIR /opt/web

RUN npm install
RUN bower install
RUN brunch build --production --env production

VOLUME /usr/share/nginx/www/
CMD "/bin/true"
