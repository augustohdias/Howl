![Linux](https://travis-ci.com/augustohdias/Howl.svg?branch=master)
![Windows](https://ci.appveyor.com/api/projects/status/github/augustohdias/Howl?svg=true&passingText=Windows%20Build:%20OK)

# Haskell Owl (Howl)
I like owls.

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

### Linux

#### Dependencies

If you're going to compile it on Ubuntu, you will need to install ltinfo: 

```
sudo apt install ltinfo-dev
```

#### Compilation guide

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


### Windows

I still don't care about Windows.

#### Compilation guide

1. Install [stack](https://docs.haskellstack.org/en/stable/README/).
2. Clone this repo.
3. Open the repo folder on PowerShell, or whatever other Windows bizarre console.
4. Run the commands below:
 
```
  stack setup
  stack install
```
