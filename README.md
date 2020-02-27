# fabric-builders

External builders and launchers for Hyperledger Fabric

## Development

It would be better to generate _core.yaml_ from [the copy in Hyperledger Fabric](https://github.com/hyperledger/fabric/blob/master/sampleconfig/core.yaml), i.e. add the external builder configuration, instead of having an out of date copy here.

## Testing

Requires [shellcheck](https://www.shellcheck.net/), and [bats-core](https://github.com/bats-core/bats-core):

```
shellcheck -x builders/**/*.sh builders/**/{detect,build,release,run}
```

```
docker run -it -v "$(pwd):/code" bats/bats:latest -r /code/test
```

## Usage

**Note:** None of the builders are finished yet!

Build a peer image configured to use the new builders:

```
docker build -t hyperledgendary/fabric-builder-peer .
```
