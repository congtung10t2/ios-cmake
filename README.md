
### NEW!
ios-cmake custom to generate framework project. (Still in stupid phase)
=========

[![Build Status](https://travis-ci.org/leetal/ios-cmake.svg?branch=master)](https://travis-ci.org/leetal/ios-cmake)

Tested with the following combinations:
* XCode 8.3, iOS SDK 10.3
* XCode 9.4, iOS SDK 11.4
* XCode 10.2, iOS SDK 12.2
* XCode 11.1, iOS SDK 13.1
* XCode 11.3, iOS SDK 13.3
* XCode 12.2, iOS SDK 14.2

# Example usage 
**NOTE: The below commands will build for 64-bit device only. Change the `-DPLATFORM` to the applicable value if targeting another platform.**

```bash
cd example/example-lib
mkdir build
cd build
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64
```
refer to this link for original cmake

https://github.com/congtung10t2/ios-cmake


---------------
Build bitcoin core

https://github.com/congtung10t2/bitcoin/tree/feature/iOSWalletBuild

cd depends

ln -s /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs SDKs
make HOST=aarch64-apple-darwin14 NO_QT=1 NO_ZMQ=1 NO_QR=1 NO_UPNP=1

configure: 

./configure --prefix=`pwd`/depends/aarch64-apple-darwin14 --without-gui --disable-zmq --with-miniupnpc=no --with-incompatible-bdb --disable-bench --disable-tests

make HOST=aarch64-apple-darwin19 NO_QT=1 NO_ZMQ=1 NO_QR=1 NO_UPNP=1

-----------------

for generate project: 
go to example-lib: 
mkdir build 
cd build 
cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64
