FROM container-registry.oracle.com/os/oraclelinux:9 AS builder

RUN dnf config-manager --enable ol9_codeready_builder && \
    dnf update -y && dnf install -y protobuf-compiler rust-toolset cargo clang

WORKDIR /ztunnel
COPY . .
RUN cargo build --profile release

FROM container-registry.oracle.com/os/oraclelinux:9-slim

ARG istio_version

# COPY LICENSE NOTICE THIRD_PARTY_LICENSES.txt olm/SECURITY.md /usr/share/licenses/
COPY --from=builder /ztunnel/LICENSE /ztunnel/olm/SECURITY.md /ztunnel/THIRD_PARTY_LICENSES.txt /usr/share/licenses/
COPY --from=builder /ztunnel/out/rust/release/ztunnel /usr/local/bin/ztunnel

RUN microdnf update -y && \
    microdnf clean all && \
    rm -rf /var/cache/yum/* && \
    test -d /LICENSES || ln -s /usr/share/licenses /LICENSES

# USER nobody

# Environment variable indicating the exact build, for debugging
ENV ISTIO_META_ISTIO_VERSION=$istio_version
ENV ISTIO_VERSION=$istio_version

ENTRYPOINT ["/usr/local/bin/ztunnel"]
