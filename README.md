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

## How it works?

Suppose the following JSON model:

##### model.json
```
{
    "posts": [
        {
            "id": "string",
            "likes": 0,
            "shares": 0,
            "comments_count": 0,
            "text": "string",
            "comments": [
                {
                    "id": "string",
                    "text": "string"
                }
            ]
        }
    ]
}
```

Run the following command:

```
./howl read model.json
```

It should outputs:
```
Spock is running on port 7676
```
Peform `GET localhost:7676/` and you should get something like this:

```
{
	"posts": [
		{
			"text": "nhuobgqusv",
			"comments_count": 4,
			"id": "amcafrigas",
			"comments": [
				{
					"text": "bqqbytkyte",
					"id": "irtiupsseg"
				},
				{
					"text": "yeoegopqrr",
					"id": "tyrbmqhste"
				},
				{
					"text": "gxhjkjalhy",
					"id": "cbujcdqvjc"
				},
				{
					"text": "mzuvtkevcw",
					"id": "fwvmeihrkl"
				},
				{
					"text": "uqcfoucviw",
					"id": "cprndydwip"
				},
				{
					"text": "gcqmlzpnxt",
					"id": "rihpetpncz"
				},
				{
					"text": "zcxcghbodl",
					"id": "wqrjzupiun"
				},
				{
					"text": "dvgboirfxu",
					"id": "xtrrdsiiri"
				},
				{
					"text": "yxyvexmfoo",
					"id": "dqsgizkckx"
				},
				{
					"text": "gxphhhxaju",
					"id": "cfunzjibpw"
				}
			],
			"likes": 52,
			"shares": 16
		},
		{
			"text": "zjqymuqndc",
			"comments_count": 91,
			"id": "dffwntkjjo",
			"comments": [
				{
					"text": "jecplcvoyf",
					"id": "mknyawgovd"
				},
				{
					"text": "wjutnpecey",
					"id": "xiiydfkmgo"
				},
				{
					"text": "mytdrjylts",
					"id": "lfmndtsycr"
				},
				{
					"text": "rqojegqinp",
					"id": "kpclebznkq"
				},
				{
					"text": "cxuqoxgzvm",
					"id": "rcxltrofwm"
				},
				{
					"text": "zpyojkdhar",
					"id": "gfjgtvbdjd"
				},
				{
					"text": "phpiojnnxv",
					"id": "hfvorsccqn"
				},
				{
					"text": "atnhshevzv",
					"id": "fdcbyryetx"
				},
				{
					"text": "hpgplhjndb",
					"id": "xtngfpymbe"
				},
				{
					"text": "vczbdjnfbv",
					"id": "idneqzfcql"
				}
			],
			"likes": 46,
			"shares": 76
		},
		{
			"text": "ahzfqaqfdf",
			"comments_count": 89,
			"id": "zpisjrlklw",
			"comments": [
				{
					"text": "ipalyoxkpd",
					"id": "madgqsjbsx"
				},
				{
					"text": "imoodmzctb",
					"id": "mylfxxixbl"
				},
				{
					"text": "ztrfylboue",
					"id": "gfuinaranr"
				},
				{
					"text": "fmmiyhbsqa",
					"id": "nedetrttwv"
				},
				{
					"text": "ldduptxjwm",
					"id": "spvzrlcqzq"
				},
				{
					"text": "llmauqfkpw",
					"id": "bgrdxmumkn"
				},
				{
					"text": "udthvecrhm",
					"id": "vikygiwcfy"
				},
				{
					"text": "lwekspwgko",
					"id": "ksrrjavebh"
				},
				{
					"text": "hpykkmgnel",
					"id": "gpygxmrztp"
				},
				{
					"text": "hrfsgjzpqx",
					"id": "iequhaptcv"
				}
			],
			"likes": 39,
			"shares": 72
		}
	]
}

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
