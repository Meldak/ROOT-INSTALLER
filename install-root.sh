#!/bin/bash

################### INFO ########################
###         Irving Gabriel Ocampo             ###
###              OS Centos 7                  ###
###              Python 3.4                   ###
###             ROOT 6.14.04                  ###
###              06-11-2018                   ###
#################################################

while getopts v:p_exe:p_in: option
do
case "${option}"
in
v) VERSION=${OPTARG};;
p_exe) P_EXE=${OPTARG};;
p_in) P_INCLUDE=${OPTARG};;
esac
done

VERSION=6-14-04
P_EXE="/usr/bin/python3"
P_INCLUDE="/usr/include/python3.4m"


if [ ! -d ~/ROOT ]; then
echo "----------CREANDO CARPETA DE DESCARGA------------"
mkdir ~/ROOT    
else
echo ">> Listo ~/ROOT"
cd ~/ROOT
if [ ! -d ~/ROOT/root ]; then
echo "----------DESCARGANDO ROOT V${VERSION}------------"
git clone http://github.com/root-project/root.git
cd root
git checkout -b v$VERSION v$VERSION  
fi
echo ">> Lista descarga ROOT V${VERSION}"
fi


################### Download compiled BIN ########################
### PKG="root_v${VERSION}.Linux-centos7-x86_64-gcc4.8.tar.gz"  ###
### REPO="https://root.cern.ch/download/"$PKG                  ###
### wget $REPO                                                 ###
### echo "----------DESCOMPRIMIENDO ROOT V${VERSION}----------"###
### tar vzxf ./$PKG                                            ###
##################################################################


if [ ! -d ~/ROOT/build ]; then
echo "----------CREANDO CARPETA PARA COMPILADO------------"
mkdir ~/ROOT/build    
else
echo ">> Listo ~/ROOT/build"
cd ~/ROOT/build
fi

if [ ! -d ~/ROOT/root ]; then
echo "No se encuentra archivos fuente en ~/ROOT/ "
exit
else
echo ">> Listo ~/ROOT/root"
echo "----------CONFIGURANDO------------"
cmake3 ../root -DPYTHON_EXECUTABLE=$P_EXE -DPYTHON_INCLUDE_DIR=$P_INCLUDE -Dpython3=ON
fi



echo "----------COMPILANDO------------"
make -j8

sudo cp ~/ROOT/build /opt/root


echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "   No olvides ejecutar el comando     "
echo "  source /opt/root/bin/thisroot.sh    "
echo " O agregarlo a tu configuracion bash  "
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"



