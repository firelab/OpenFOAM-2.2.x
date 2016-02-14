
cd $WM_PROJECT_DIR/..
#wget "http://downloads.sourceforge.net/project/foam/foam/2.2.1/ThirdParty-2.2.1.tgz"
tar -xvf ThirdParty-2.2.1.tgz
ln -s ThirdParty-2.2.1 $WM_THIRD_PARTY_DIR
ln -s $WM_THIRD_PARTY_DIR/scotch_6.0.0 $WM_THIRD_PARTY_DIR/scotch
ln -s $WM_PROJECT_DIR/extra/scotch/src/Make.inc/Makefile.inc.mingw-w64 $WM_THIRD_PARTY_DIR/scotch/src/Makefile.inc
cp $WM_PROJECT_DIR/extra/scotch/src/libscotch/* $WM_THIRD_PARTY_DIR/scotch/src/libscotch/.
cd $WM_THIRD_PARTY_DIR/scotch/src
cp $WM_PROJECT_DIR/extra/scotch/src/Makefile .
make -k libscotch
mkdir -p $FOAM_LIBBIN
cd $WM_THIRD_PARTY_DIR/scotch/src/libscotch
cp libscotch.* $FOAM_LIBBIN

