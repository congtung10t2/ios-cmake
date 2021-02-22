#include "HelloWorld.hpp"
#include <nunchuk.h>
using namespace  nunchuk;
std::string HelloWorld::helloWorld()
{
    AppSettings settings;
    settings.set_chain(Chain::TESTNET);
    settings.set_hwi_path("bin/hwi");
    settings.enable_proxy(false);
    
    settings.set_testnet_servers({"127.0.0.1:50001"});

    auto nunchuk = MakeNunchuk(settings);
  return std::string("Hello World");
}
