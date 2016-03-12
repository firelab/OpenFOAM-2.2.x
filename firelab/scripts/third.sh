export FOAM_INST_DIR="`dirname $PWD`";
source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc

cd ../
tar -xvf ThirdParty-2.2.1.tgz

ln -s ThirdParty-2.2.1 $WM_THIRD_PARTY_DIR
ln -s $WM_THIRD_PARTY_DIR/scotch_6.0.0 $WM_THIRD_PARTY_DIR/scotch
ln -s $WM_PROJECT_DIR/extra/scotch/src/Make.inc/Makefile.inc.mingw-w64 $WM_THIRD_PARTY_DIR/scotch/src/Makefile.inc

cd $WM_THIRD_PARTY_DIR 
./Allwmake

cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch
make
#there might be errors, but just check that the dummysize executable built

cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch 
rm -rf *.o

#make libscotch.so (needed to build the dll??)
cd $WM_THIRD_PARTY_DIR/scotch/src
cp -rf $WM_PROJECT_DIR/extra/scotch/src/libscotch/* $WM_THIRD_PARTY_DIR/scotch/src/libscotch/
cp $WM_PROJECT_DIR/extra/scotch/src/Makefile .
make libscotch

cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch
rm -rf *.o

cd $WM_THIRD_PARTY_DIR/scotch/src
rm -rf Makefile.inc
ln -s $WM_PROJECT_DIR/extra/scotch/src/Make.inc/Makefile.inc.mingw-w64 $WM_THIRD_PARTY_DIR/scotch/src/Makefile.inc
make libscotch
mkdir -p $FOAM_LIBBIN
cp $WM_THIRD_PARTY_DIR/scotch/src/libscotch/libscotch.* $FOAM_LIBBIN/
