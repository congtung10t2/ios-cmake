#ifndef hellocpp
#define hellocpp
#include <nunchuk.h>
using namespace  nunchuk;

class NunChukExample {
public:
    std::unique_ptr<Nunchuk> nu;
    std::vector<Wallet> wallets;
    void setupNunChuk();
    std::vector<Device> getDevices();
    void createNewMasterSigner();
    void createMultisigWallet();
    void importConfig(std::string path);
    void newRemoteSigner(std::string name, std::string xpub, std::string path, std::string print);
};
#endif
