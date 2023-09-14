# zksummit_ios_workshop
Starter code for ZKSummit 10 iOS proving workshop. 

## Prerequisites (BEFORE cloning the repo): 

- Install [brew](https://brew.sh)
- Install `git-lfs` (`brew install git-lfs`)
- Download [Xcode](https://developer.apple.com/xcode/)
  
## Usage 
- To run in single threaded mode, rename `aleo_wasm_single.xcframework` to `aleo_wasm.xcframework`

  OR 

  To run in multi-threaded mode, rename `aleo_wasm_multi.xcframework` to `aleo_wasm.xcframework`

- Open `Demo.xcodeproj` inside `Demo/`
- Build and run
- Try out a sample program

## Notes 
- Types for number inputs must be specified, so if your aleo function takes an `i32` input, `3` must be formatted as `3i32` in the input field
