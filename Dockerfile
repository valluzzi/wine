FROM valluzzi/gdal:latest
#FROM ubuntu:22.04
#--------------------------------------------------------                                                    
#               wine
#--------------------------------------------------------
# #--- install wine ---
RUN dpkg --add-architecture i386
RUN apt-get update
#------------------------------------------------------------------------------------------------------------------------------
# install msodbcsql Ubuntu 22.04
RUN apt-get install -y gnupg curl git
ENV ACCEPT_EULA=Y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN apt-get install -y msodbcsql18 winbind libodbc1 unixodbc 
RUN apt-get install --no-install-recommends --assume-yes wine-stable wine64 wine32 winetricks
ENV DISPLAY=:0.0
ENV LD_PRELOAD=
RUN winecfg

#--------------------------------------------------------                                                    
#               clean
#--------------------------------------------------------
ENV DEBIAN_FRONTEND=newt
ENV ACCEPT_EULA=N
#--------------------------------------------------------                                                    
#               the end
#--------------------------------------------------------