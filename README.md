# fabric-builders

External builders and launchers for Hyperledger Fabric

## Testing

Requires [shellcheck](https://www.shellcheck.net/), and [bats-core](https://github.com/bats-core/bats-core):

```
shellcheck -x builders/**/*.sh builders/**/{detect,build,release,run}
```

```
docker run -it -v "$(pwd):/code" bats/bats:latest -r /code/test
```
