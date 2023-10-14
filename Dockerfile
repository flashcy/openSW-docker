#베이스 이미지 작성
FROM ubuntu:18.04

#install apache2 package
RUN apt-get update && \
 apt-get -y install apache2

#create base web page
RUN echo 'Docker Container Application.' > /var/www/html/index.html

#create working path needed.
RUN mkdir /webapp

#아파치2에 필요한 환경변수, 디렉터리, 서비스 실행 등의 정보를 셸 스크립트에 작성 및 권한 부여
RUN echo '. /etc/apache2/envvars' > /webapp/run_http.sh && \
 echo 'mkdir -p /var/run/apache2' >> /webapp/run_http.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /webapp/run_http.sh && \
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /webapp/run_http.sh && \
 chmod 744 /webapp/run_http.sh

#open port No.80
EXPOSE 80

#run shell scripts when the container RUN
CMD /webapp/run_http.sh
