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

Build a peer image configured to use the new builders:

```
docker build -t hyperledgendary/fabric-builder-peer .
```

Start a fabric network using the new peer image. For example, edit docker-compose.yaml file to use the extended peer image:

```
    image: hyperledgendary/fabric-builder-peer:latest
```

Package chaincode for required builder:

- [external](./builders/external/README.md)
- [prebuilt](./builders/prebuilt/README.md)

## Useful links

### Articles

- [Setting Up the External Chaincode Builder and Launcher in Hyperledger Fabric 2.0](https://medium.com/@robinklemens/setting-up-the-external-chaincode-builder-and-launcher-in-hyperledger-fabric-2-0-b17f43a3d8ed)
- [How to implement Hyperledger Fabric External Chaincodes within a Kubernetes cluster](https://medium.com/@pau.aragones/how-to-implement-hyperledger-fabric-external-chaincodes-within-a-kubernetes-cluster-fd01d7544523)

### Documentation

- [External Builders and Launchers](https://hyperledger-fabric.readthedocs.io/en/release-2.0/cc_launcher.html)
- [Chaincode as an external service](https://hyperledger-fabric.readthedocs.io/en/release-2.0/cc_service.html)
- [Using the Fabric test network](https://hyperledger-fabric.readthedocs.io/en/release-2.0/test_network.html)

### Samples

- [FabCar external service sample](https://github.com/jt-nti/fabric-samples/tree/external-fabcar/chaincode/fabcar/external)

### Other

See [wiki](https://github.com/hyperledgendary/fabric-builders/wiki) for more information
