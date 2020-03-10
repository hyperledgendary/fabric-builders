# Prebuilt chaincode builder

This external builder should enable peers to launch chaincode which has already been built.

_Status: might work!_

## Package contents

This builder requires a `.tgz` package file with the following contents.

### `metadata.json` file

```
{
    "type": "prebuilt",
    "label": "..."
}
```

where `label` is suitable string to identify your chaincode.

### `code.tar.gz` archive

The `code.tar.gz` file should contain another archive, called `prebuilt.tgz`, with the necessary binary file(s), and a `start.sh` script to run the chaincode.

## Chaincode environment

The following environment variables will be available:

- `CORE_CHAINCODE_ID_NAME`
- `CORE_PEER_ADDRESS`
- `CORE_PEER_LOCALMSPID`
- `CORE_PEER_TLS_ENABLED`

The following environment variables will be available if `CORE_PEER_TLS_ENABLED` is `true`:

- `CORE_TLS_CLIENT_CERT_FILE`
- `CORE_TLS_CLIENT_KEY_FILE`
- `CORE_PEER_TLS_ROOTCERT_FILE`
