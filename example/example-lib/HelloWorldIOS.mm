#import "HelloWorldIOS.h"
#import "HelloWorldCPP.h"
@implementation HelloWorldIOS
NunChukExample * example;
@synthesize delegate; //synthesise  MyClassDelegate delegate
- (void) importWallet:(NSBundle*) bundle
{
    NSString *filePath = [bundle pathForResource:@"config" ofType:@"txt"];
    std::string path = [filePath UTF8String];
    example->importConfig(path);
}

- (void) setupNunchuk {
    example = new NunChukExample();
    example->setupNunChuk();
    example->nu->AddBalanceListener([self](std::string wid, Amount amount) {
        printf("---------------------- worked");
        [self.delegate loadedAmounts:amount];
    });
}

- (void) updateWallet {
    [self.delegate loadedWallet:example->nu->GetWallets()[0].get_balance()];
}
@end
