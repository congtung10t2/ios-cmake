#!/bin/bash
# Copyright (c) 2013-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
copyall_depends()
{
    echo "copying dependencies...."
    find ${PWD}/libnunchuk/contrib/bitcoin/src/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    find ${PWD}/libnunchuk/contrib/bitcoin/depends/aarch64-apple-darwin14/lib/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    find ${PWD}/libnunchuk/contrib/bitcoin/src/crc32c/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    find ${PWD}/libnunchuk/contrib/bitcoin/src/crypto/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;

    find ${PWD}/libnunchuk/contrib/bitcoin/src/secp256k1/.libs/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;

    find ${PWD}/libnunchuk/contrib/bitcoin/src/leveldb/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    find ${PWD}/libnunchuk/contrib/bitcoin/src/univalue/.libs/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    find ${PWD}/libnunchuk/contrib/bitcoin/src/.libs/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;

    find ${PWD}/libnunchuk/contrib/ios_openssl/lib/ -iname \*.a -exec cp {} ${PWD}/depends/lib/ \;
    echo "done copying"
}
if [ -d ${PWD}/depends/lib/ ] 
then
    copyall_depends
else
    mkdir depends
    cd depends
    mkdir lib
    cd ..
    copyall_depends
  
fi
