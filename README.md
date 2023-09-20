# zksummit_ios_workshop
Starter code for ZKSummit 10 iOS proving workshop. 

## Prerequisites (BEFORE cloning the repo): 

- Install [brew](https://brew.sh)
- Install `git-lfs` (`brew install git-lfs`)
- Download [Xcode](https://developer.apple.com/xcode/)
  
## Workshop 
1. Navigate to [ZKSummit token dapp](https://zksummit10.vercel.app)
2. Connect your wallet (install puzzle wallet if you don't have it already)
3. Grab some aleo credits via the faucet (or let one of us know and we can send you some!)
4. Clone the workshop repo 
5. Open `Demo.xcodeproj` inside `Demo/`
6. Add your private key and a record with credits to pay the fee at the top of `ContentView.swift`
7. Build and run (hit the play icon on the top bar) 
8. Execute with the following params (reference code for the program can be found [here](https://www.aleo.network/programs/zksummit_token_v10.aleo)):
  - Program name: `zksummit_token_v10.aleo`
  - Function: `mint_private`
  - Input 1: `your address`
  - Input 2: `a random amount, for example "100u64"`

9. Once execution completes successfully, navigate back to to the [ZKSummit token dapp](https://zksummit10.vercel.app) and view your new balance!
10. Try a transfer execution, or any aleo program you'd like!


## Notes 
- Types for number inputs must be specified, so if your aleo function takes an `i32` input, `3` must be formatted as `3i32` in the input field
