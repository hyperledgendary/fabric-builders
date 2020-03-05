# fabric-builders

External builders and launchers for Hyperledger Fabric

See [wiki](https://github.com/hyperledgendary/fabric-builders/wiki) for more information

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

**Note:** The `external` builder _might_ work but none of the other builders are finished yet!

Build a peer image configured to use the new builders:

```
docker build -t hyperledgendary/fabric-builder-peer .
```

Start a fabric network using the new peer image. For example, edit docker-compose.yaml file to use the extended peer image:

```
    image: hyperledgendary/fabric-builder-peer:latest
```
