#!/bin/bash
# Copyright (c) 2013-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
build_bitcoin() {
    pushd libnunchuk/contrib/bitcoin
    sh ./autogen.sh
    cd depends
    ln -s /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs SDKs
    make HOST=aarch64-apple-darwin14 NO_QT=1 NO_UPNP=1
    cd ..
    sh ./configure --prefix=`pwd`/depends/aarch64-apple-darwin14 --without-gui --disable-zmq --with-miniupnpc=no --with-incompatible-bdb --disable-bench --disable-tests
    make HOST=aarch64-apple-darwin19 NO_QT=1 NO_ZMQ=1 NO_QR=1 NO_UPNP=1
    popd
}


generate_project() {
    if [ -d ${PWD}/build ] 
    then 
        cd build
        cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64
    else 
        mkdir build
        cd build
        cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64
    fi
}

if [ -d ${PWD}/depends/lib/ ] 
then 
    cd build
    cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64
    echo "Done generate project again"
else 
    if [ -d ${PWD}/libnunchuk ] 
    then
        build_bitcoin
        sh ./install_dependencies.sh
    else 
        git submodule add https://github.com/nunchuk-io/libnunchuk
        git submodule update --init --recursive
        build_bitcoin
        sh ./install_dependencies.sh
    fi
    generate_project
fi


