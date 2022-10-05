#### Use latest Osgeo/gdal image
#FROM osgeo/gdal:latest
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntugis/ppa && apt-get update
RUN apt-get update
RUN apt-get install -y python3-pip gdal-bin libgdal-dev locales git
#RUN apt-get install -y python3-numpy 

# Set python aliases for python3
RUN echo 'alias python=python3' >> ~/.bashrc
RUN echo 'alias pip=pip3' >> ~/.bashrc

#--------------------------------------------------------                                                    
#               Python GDAL
#--------------------------------------------------------
# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal
# This will install GDAL
RUN pip install GDAL

#--------------------------------------------------------                                                    
#               wine
#--------------------------------------------------------
# #--- install wine ---
RUN dpkg --add-architecture i386
RUN apt-get update
#------------------------------------------------------------------------------------------------------------------------------
# install msodbcsql Ubuntu 20.04
RUN apt-get install -y gnupg curl git
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
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