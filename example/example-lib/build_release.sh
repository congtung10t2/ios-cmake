#!/bin/bash
# Copyright (c) 2013-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
cd build
cmake --build . --config Release
cd ..
sh ./install_dependencies_release.sh
cd build
cmake --build . --config Release 