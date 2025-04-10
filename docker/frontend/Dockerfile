FROM nginx:alpine

# Remove default Nginx site
RUN rm -rf /usr/share/nginx/html/*

# Copy your frontend files
COPY . /usr/share/nginx/html

EXPOSE 80

