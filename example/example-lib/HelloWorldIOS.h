#import <Foundation/Foundation.h>
@protocol WalletDelegate <NSObject>   //define delegate protocol
    - (void) loadedAmounts: (int) balance;  //define delegate method to be implemented within another class
    - (void) loadedWallet: (int) balance;  //define delegate method to be implemented within another class
@end //end protocol


@interface HelloWorldIOS : NSObject
@property (nonatomic, weak, nullable) id <WalletDelegate> delegate;
- (void) importWallet:(NSBundle*_Nonnull) bundle;
- (void) updateWallet;
- (void) setupNunchuk;
@end
