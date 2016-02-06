#!/bin/bash
git checkout patched
export FOAM_INST_DIR="`dirname $PWD`";
source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc \
       WM_OSTYPE=MSwindows \
       WM_COMPILER=mingw-w64 \
       WM_ARCH_OPTION=64 \
       WM_PRECISION_OPTION=SP \
       WM_CC=x86_64-w64-mingw32-gcc \
       WM_CXX=x86_64-w64-mingw32-g++ \
       compilerInstall=system \
       WM_MPLIB=MSMPI \
       MPI_ARCH_PATH=$FOAM_INST_DIR/OpenFOAM-2.2.x/firelab/msmpi

source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc
cd $WM_PROJECT_DIR/wmake/src
make
ln -s $WM_PROJECT_DIR/wmake/platforms/linux64Gcc \
      $WM_PROJECT_DIR/wmake/platforms/linux64mingw-w64
./Allwmake
cd $WINDNINJA_HOME/src/ninjafoam/
./Allwmake
