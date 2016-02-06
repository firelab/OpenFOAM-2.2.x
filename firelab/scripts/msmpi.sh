#!/bin/bash

mkdir msmpi && cd msmpi
wget -O msmpi64.msi "https://download.microsoft.com/download/A/1/3/A1397A8C-4751-433C-8330-F738C3BE2187/mpi_x64.Msi"
7z e msmpi64.msi
#need sed command to add stdint to line 127 in mpi.h
#we make Lib/i386, but don't use it.  We'd have to handle the 32/64 split.
mkdir -p Bin Inc Lib/amd64 Lib/i386
mv *.exe Bin
mv *.man Bin
mv *.h Inc
mv *.f90 Inc
mv *.dll Lib/amd64
mv *.lib Lib/amd64
cd Lib/amd64
gendef msmpi64.dll
x86_64-w64-mingw32-dlltool -d msmpi64.def -l libmsmpi.a -D msmpi64.dll

