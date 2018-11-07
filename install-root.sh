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
WORKDIR="/opt"
VERSION=6-14-04
P_EXE="/usr/bin/python3"
P_INCLUDE="/usr/include/python3.4m"

################### Download compiled BIN for Python 2 ########################
#PKG="root_v${VERSION}.Linux-centos7-x86_64-gcc4.8.tar.gz"  
#REPO="https://root.cern.ch/download/"$PKG                  
#wget $REPO                                                 
#echo "----------DESCOMPRIMIENDO ROOT V${VERSION}----------"
#tar vzxf ./$PKG 
#sudo mv ./root /opt/                                      
##################################################################

if [ ! -d $WORKDIR/ROOT ]; then
echo "----------CREANDO CARPETA DE DESCARGA------------"
sudo mkdir $WORKDIR/ROOT    
else
echo ">> Listo ${WORKDIR}/ROOT"
cd $WORKDIR/ROOT
if [ ! -d $WORKDIR/ROOT/root ]; then
echo "----------DESCARGANDO ROOT V${VERSION}------------"
sudo git clone http://github.com/root-project/root.git
cd root
sudo git checkout -b v$VERSION v$VERSION  
fi
echo ">> Lista descarga ROOT V${VERSION}"
fi





if [ ! -d $WORKDIR/ROOT/build ]; then
echo "----------CREANDO CARPETA PARA COMPILADO------------"
sudo mkdir $WORKDIR/ROOT/build    
else
echo ">> Listo ${WORKDIR}/ROOT/build"
cd $WORKDIR/ROOT/build
fi

if [ ! -d $WORKDIR/ROOT/root ]; then
echo "No se encuentra archivos fuente en ${WORKDIR}/ROOT/ "
exit
else
echo ">> Listo ${WORKDIR}/ROOT/root"
echo "----------CONFIGURANDO------------"
sudo cmake3 ../root -DPYTHON_EXECUTABLE=$P_EXE -DPYTHON_INCLUDE_DIR=$P_INCLUDE -Dpython3=ON
fi

echo "----------COMPILANDO------------"
make -j8



echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "   No olvides ejecutar el comando     "
echo "  source /opt/ROOT/build/bin/thisroot.sh    "
echo " O agregarlo a tu configuracion bash  "
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"



