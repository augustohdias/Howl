# Haskell Owl (Howl)
## Tiny CLI for fake APIs
[![Linux Build Status](https://travis-ci.com/augustohdias/Howl.svg?branch=master)](https://travis-ci.com/augustohdias/Howl)
## Wut

Howl implements a fake API that runs locally. It basically reads a JSON sample and provides a new one at `localhost:7676`. So, when you `GET localhost:7676`, you will be served with a randomized JSON.

## Why Haskell?

I like Haskell.

## Why 7676?

I like 7676.

## Usage

It's quite simple:

```
howl read <sample path>
```

## Installation

You can compile or get the [pre-built releases](https://github.com/augustohdias/Howl/releases).

### Compile on linux

You will need ncurses and ncurses-compat-libs installed. If you are smart and uses Arch or Manjaro distros, you can get it on AUR.

**yay example**
```
yay -Syu ncurses ncurses-compat-libs
```

After you get both, you're ready to compile.

1. Install [stack](https://docs.haskellstack.org/en/stable/README/).
2. Run the commands below.
  ```
  git clone https://github.com/augustohdias/Howl.git
  cd Howl
  stack setup
  stack install
  ```
 
Make sure `~/.local/bin` is on your `PATH`.


### Windows installation

I recommend the pre-built releases for Windows users, but you can compile it with stack as explained above.
