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

Create a `connection.json` file, for example:

```
{
  "address": "fabcar.humboldt.example.com:9999",
  "dial_timeout": "10s",
  "tls_required": "false"
}
```

See the [Chaincode as an external service](https://hyperledger-fabric.readthedocs.io/en/release-2.0/cc_service.html) documentation for additional attributes if you want to use TLS.

Create a `metadata.json` file, for example:

```
{
  "type": "external",
  "label": "fabcar"
}
```

"Package" the sample fabcar external service chaincode metadata to install:

```
tar cfz code.tar.gz connection.json
tar cfz fabcar-pkg.tgz metadata.json code.tar.gz
```

Install the fabcar-pkg.tgz chaincode.

...to be continued
