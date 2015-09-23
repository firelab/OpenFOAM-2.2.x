export FOAM_INST_DIR=$PWD; source $FOAM_INST_DIR/etc/bashrc WM_OSTYPE=MSwindows WM_COMPILER=mingw-w64 WM_ARCH_OPTION=64 WM_PRECISION_OPTION=SP WM_CC=x86_64-w64-mingw32-gcc WM_CXX=x86_64-w64-mingw32-g++ compilerInstall=system
cd $WM_PROJECT_DIR/wmake/src; make
ln -s $WM_PROJECT_DIR/wmake/platforms/linux64Gcc $WM_PROJECT_DIR/wmake/platforms/linux64mingw-w64
source the OpenFOAM MinGW-w64 environment variables
cd $WM_PROJECT_DIR;./Allwmake

