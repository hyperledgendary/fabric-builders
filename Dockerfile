ARG HLF_VERSION=2.2

FROM hyperledger/fabric-peer:${HLF_VERSION}

RUN apk add --no-cache \
	bash \
	jq \
	npm;

COPY core.yaml ${FABRIC_CFG_PATH}
COPY ./builders /builders/
