
#set up environment, etc according to symscape

#get zlibdefs.h and put it in /usr/x86_64-w64-mingw32/include
#https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.7-4.6/+/refs/tags/android-sdk-adt_r20/sysroot/usr/include/zlibdefs.h

#-----------------------------------------------------
# set up msmpi 
#-----------------------------------------------------
cd /home/natalie/src/msmpi/Lib/amd64
gendef msmpi.dll #creates msmpi.def
x86_64-w64-mingw32-dlltool -d msmpi.def -l libmsmpi.a -D msmpi.dll #creates libmsmpi.a
#add #include <stdint.h> to /home/natalie/src/msmpi/Inc/mpi.h:127 to define __int64

#=====================================================

#-----------------------------------------------------
# get and patch OF 2.2.x
#-----------------------------------------------------
git clone http://github.com/firelab/OpenFOAM-2.2.x
cd OpenFOAM-2.2.x/
git checkout 8a983dba63b246772c69ed0fa9cc3b3e33a10f92
wget http://www.symscape.com/files/articles/openfoam22x-windows/v3-mingw-openfoam-2-2-x.patch.zip
unzip v3-mingw-openfoam-2-2-x.patch.zip
patch -p0 < v3-mingw-openfoam-2-2-x.patch
rm v3-mingw-openfoam-2-2-x.patch*

#-----------------------------------------------------
# set some env variables
#-----------------------------------------------------
#source the OpenFOAM MinGW-w64 environment variables
export FOAM_INST_DIR=$HOME/src/crosscompiled_openfoam; source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc WM_OSTYPE=MSwindows WM_COMPILER=mingw-w64 WM_ARCH_OPTION=64 WM_PRECISION_OPTION=DP WM_CC=x86_64-w64-mingw32-gcc WM_CXX=x86_64-w64-mingw32-g++ compilerInstall=system WM_MPLIB=MSMPI MPI_ARCH_PATH=$HOME/src/msmpi

#source the OpenFOAM native linux environment variables ??
source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc

#-----------------------------------------------------
# build wmake
#-----------------------------------------------------
cd $WM_PROJECT_DIR/wmake/src
make
ln -s $WM_PROJECT_DIR/wmake/platforms/linux64Gcc $WM_PROJECT_DIR/wmake/platforms/linux64mingw-w64

#-----------------------------------------------------
# get and build scotch
#-----------------------------------------------------
cd /home/nwagenbrenner/src/crosscompiled_openfoam/
wget https://sourceforge.net/projects/foam/files/foam/2.2.1/ThirdParty-2.2.1.tgz
tar xvf ThirdParty-2.2.1.tgz

ln -s ThirdParty-2.2.1 $WM_THIRD_PARTY_DIR
ln -s $WM_THIRD_PARTY_DIR/scotch_6.0.0 $WM_THIRD_PARTY_DIR/scotch
ln -s $WM_PROJECT_DIR/extra/scotch/src/Make.inc/Makefile.inc.mingw-w64 $WM_THIRD_PARTY_DIR/scotch/src/Makefile.inc

#put ptscotch.h in its proper place
cd $WM_THIRD_PARTY_DIR
./Allwmake #this is necessary to build dummysize

cp $WM_PROJECT_DIR/extra/scotch/src/libscotch/* $WM_THIRD_PARTY_DIR/scotch/src/libscotch/.

cd $WM_THIRD_PARTY_DIR/scotch/src
cp $WM_PROJECT_DIR/extra/scotch/src/Makefile .
make libscotch
mkdir -p $FOAM_LIBBIN
cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch
cp libscotch.* $FOAM_LIBBIN

#cp the libs over
cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch
cp libscotch.* $FOAM_LIBBIN

#-----------------------------------------------------
# build OF 
#-----------------------------------------------------
#source the OpenFOAM MinGW-w64 environment variables
export FOAM_INST_DIR=$HOME/src/crosscompiled_openfoam; source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc WM_OSTYPE=MSwindows WM_COMPILER=mingw-w64 WM_ARCH_OPTION=64 WM_PRECISION_OPTION=DP WM_CC=x86_64-w64-mingw32-gcc WM_CXX=x86_64-w64-mingw32-g++ compilerInstall=system WM_MPLIB=MSMPI MPI_ARCH_PATH=$HOME/src/msmpi

#build OpenFOAM
cd $WM_PROJECT_DIR
find . -name Allwmake -exec chmod +x '{}' \;
#chmod +x src/OSspecific/MSwindows/Allwmake
./Allwmake




