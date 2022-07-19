FROM nginx:latest

# Core of Nginx
COPY settings/sites-available/* /etc/nginx/sites-available/

# Params and additional resolvers
COPY settings/additional/* /etc/nginx/

RUN mkdir -p /etc/nginx/sites-enabled/ \
    && ln -s /etc/nginx/sites-available/core.conf /etc/nginx/sites-enabled/ \
    && rm /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
