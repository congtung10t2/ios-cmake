#include "NunchukBridge.h"
#include <utils/loguru.hpp>

#include <vector>
#include <iostream>
#include <iomanip>
#include <regex>
#include <nunchuk.h>
using namespace  nunchuk;

void NunChukExample::setupNunChuk() {
    AppSettings settings;
    settings.set_chain(Chain::TESTNET);
    settings.set_hwi_path("bin/hwi");
    settings.enable_proxy(false);
    std::vector<std::string> vector;
    vector.push_back("testnet.nunchuk.io:50001");
    settings.set_testnet_servers(vector);
    settings.set_backend_type(BackendType::ELECTRUM);
    
    this->nu = MakeNunchuk(settings);
    this->wallets = nu->GetWallets();
    
}
void NunChukExample::importConfig(std::string path) {
    auto wallet = this->nu->ImportWalletConfigFile(path);
}
std::vector<Device> NunChukExample::getDevices() {
    return this->nu->GetDevices();
}

void NunChukExample::createNewMasterSigner() {
    auto master_signer = this->nu->CreateMasterSigner(
                                                      "signer_name", getDevices()[0], [](int percent) {
            // libnunchuk caches xpubs when adding a new master signer, so this method will take some time
            // Use this callback to check on the progress
            return true;
        });
}

void NunChukExample::createMultisigWallet() {
    AddressType address_type = AddressType::NATIVE_SEGWIT;

    // Nunchuk supports multisig, singlesig and escrow wallets
    WalletType wallet_type = WalletType::MULTI_SIG;

    // Get a list of master signers that we manage
    auto master_signers = this->nu->GetMasterSigners();

    // Create 2 signers from the first 2 master signers
    auto signer0 = this->nu->GetUnusedSignerFromMasterSigner(
        master_signers[0].get_id(), wallet_type, address_type);
    auto signer1 = this->nu->GetUnusedSignerFromMasterSigner(
        master_signers[1].get_id(), wallet_type, address_type);

    // Create a multisig (2/2) wallet
    auto wallet = this->nu->CreateWallet("wallet_name", 2, 2,
        {signer0, signer1}, address_type, false);
}
