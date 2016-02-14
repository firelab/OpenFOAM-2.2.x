#!/bin/bash
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
cd $WM_PROJECT_DIR
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
./Allwmake
cd $HOME/src/windninja/src/ninjafoam/
wmake libso
cd $HOME/src/windninja/src/ninjafoam/utility/applyInit
wmake
cd $WM_PROJECT_DIR
# copy some stuff into the dist
cp /usr/lib/gcc/x86_64-w64-mingw32/4.8/libgcc_s_sjlj-1.dll \
   platforms/linux64mingw-w64SPOpt/lib/
cp /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll \
   platforms/linux64mingw-w64SPOpt/lib/
cp /usr/lib/gcc/x86_64-w64-mingw32/4.8/libstdc++-6.dll \
   platforms/linux64mingw-w64SPOpt/lib/
cp platforms/linux64mingw-w64SPOpt/lib/msmpi/*.dll platforms/linux64mingw-w64SPOpt/lib
cp $FOAM_USER_LIBBIN/*.dll platforms/linux64mingw-w64SPOpt/lib/
cp $FOAM_USER_APPBIN/*.exe platforms/linux64mingw-w64SPOpt/bin/
zip -r $PWD.zip etc/ \
                platforms/linux64mingw-w64SPOpt/lib/*.dll \
                platforms/linux64mingw-w64SPOpt/bin/*.exe
