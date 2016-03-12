#!/bin/bash
export FOAM_INST_DIR="`dirname $PWD`";
export CFLAGS="-DSCOTCH_VERSION=6 -DSCOTCH_RELEASE=0 -DSCOTCH_PATCHLEVEL=0"
source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc
cd $WM_PROJECT_DIR/wmake/src
make
ln -s $WM_PROJECT_DIR/wmake/platforms/linux64Gcc \
      $WM_PROJECT_DIR/wmake/platforms/linux64mingw-w64

source $FOAM_INST_DIR/OpenFOAM-2.2.x/etc/bashrc \
       WM_OSTYPE=MSwindows \
       WM_COMPILER=mingw-w64 \
       WM_ARCH_OPTION=64 \
       WM_PRECISION_OPTION=DP \
       WM_CC=x86_64-w64-mingw32-gcc \
       WM_CXX=x86_64-w64-mingw32-g++ \
       compilerInstall=system \
       WM_MPLIB=MSMPI \
       MPI_ARCH_PATH=$FOAM_INST_DIR/OpenFOAM-2.2.x/firelab/msmpi

cd $WM_PROJECT_DIR &&
find . -name Allwmake -exec chmod +x '{}' \;
./Allwmake &&
cd $HOME/src/windninja/src/ninjafoam/ &&
wmake libso &&
cd $HOME/src/windninja/src/ninjafoam/utility/applyInit &&
wmake &&
cd $WM_PROJECT_DIR &&

# copy some stuff into the foam distribution folders.
cp /usr/lib/gcc/x86_64-w64-mingw32/4.8/libgcc_s_sjlj-1.dll \
   platforms/linux64mingw-w64DPOpt/lib/ &&
cp /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll \
   platforms/linux64mingw-w64DPOpt/lib/ &&
cp /usr/lib/gcc/x86_64-w64-mingw32/4.8/libstdc++-6.dll \
   platforms/linux64mingw-w64DPOpt/lib/ &&
cp firelab/msmpi/Lib/amd64/msmpi64.dll platforms/linux64mingw-w64DPOpt/lib &&
cp firelab/msmpi/Bin/mpiexec.exe platforms/linux64mingw-w64DPOpt/bin &&
#cp firelab/zlib-1.2.8/zlib1.dll platforms/linux64mingw-w64DPOpt/lib &&
cp platforms/linux64mingw-w64DPOpt/lib/msmpi/*.dll platforms/linux64mingw-w64DPOpt/lib &&
cp $FOAM_USER_LIBBIN/*.dll platforms/linux64mingw-w64DPOpt/lib/ &&
cp $FOAM_USER_APPBIN/*.exe platforms/linux64mingw-w64DPOpt/bin/ &&

cp $WM_THIRD_PARTY_DIR/scotch_6.0.0/src/libscotch/libscotch.dll platforms/linux64mingw-w64DPOpt/lib/

# zip etc
zip -r $PWD.zip etc/ &&

# zip all of the none-scotch dependant executables
for fname in "surfaceTransformPoints" \
             "surfaceCheck" \
             "moveDynamicMesh" \
             "topoSet" \
             "refineMesh" \
             "blockMesh" \
             "surfaceTransformPoints" \
             "surfaceCheck" \
             "checkMesh" \
             "applyInit" \
             "simpleFoam" \
             "sample" \
             "applyInit" \
             "decomposePar" \
             "reconstructParMesh" \
             "reconstructPar" \
             "renumberMesh" \
             "mpiexec";
do
    zip $PWD.zip platforms/linux64mingw-w64DPOpt/bin/${fname}.exe
done

# scotch

# zip the dlls that the executables depend on.  These were found using
# dependancy walker and trial and error.
for fname in "libOpenFOAM" \
             "libfiniteVolume" \
             "libgcc_s_sjlj-1" \
             "libstdc++-6" \
             "libmeshTools" \
             "libtriSurface" \
             "libdynamicFvMesh" \
             "libsampling" \
             "libPstream" \
             "libdynamicMesh" \
             "libblockMesh" \
             "libsurfMesh" \
             "libfvOptions" \
             "libincompressibleRASModels" \
             "libincompressibleTransportModels" \
             "libincompressibleTurbulenceModel" \
             "libgenericPatchFields" \
             "libwinpthread-1" \
             "libfileFormats" \
             "libextrudeModel" \
             "libconversion" \
             "liblagrangian" \
             "libcompressibleTurbulenceModel" \
             "libfluidThermophysicalModels" \
             "libspecie" \
             "libconversion" \
             "libsolidThermo" \
             "libreactionThermophysicalModels" \
             "libtwoPhaseMixture" \
             "libsolidSpecie" \
             "libfvMotionSolvers" \
             "libdecompositionMethods" \
             "librenumberMethods" \
             "libscotch*" \
             "msmpi64" \
             "libWindNinja";
do
    zip $PWD.zip platforms/linux64mingw-w64DPOpt/lib/${fname}.dll
done

