ARG HLF_VERSION=2.0

FROM hyperledger/fabric-peer:${HLF_VERSION}

RUN apk add --no-cache \
	bash \
	jq;

COPY core.yaml ${FABRIC_CFG_PATH}
COPY ./builders /builders/
