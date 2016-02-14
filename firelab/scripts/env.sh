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

