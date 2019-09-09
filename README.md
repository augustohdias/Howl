# Haskell Owl (Howl)

Tiny CLI for fake APIs

## Wut

Howl implements a fake API that runs locally. It basically reads a JSON sample and provides a new one at `localhost:7676`. So, when you `GET localhost:7676`, you will find a randomized JSON.

## Why Haskell?

I like Haskell.

## Why 7676?

I like 7676.

## Usage

It's quite simple:

```
howl read <sample path>
```

## UNIX systems installation

### case stackInstalled of: False ->

1. Install [stack](https://docs.haskellstack.org/en/stable/README/). 
2. Run the commands below.

### case stackInstalled of: True ->

```
git clone https://github.com/augustohdias/Howl.git
cd Howl
stack setup
stack install
```

Make sure `~/.local/bin` is on your `PATH`.

## Windows installation

I don't care about Windows.
