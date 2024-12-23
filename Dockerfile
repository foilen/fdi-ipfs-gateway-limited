FROM ubuntu:24.04

RUN useradd -m -s /bin/bash ipfs

COPY _assets/usr/bin/ipfs-gateway-limited _assets/go-ipfs/ipfs /usr/bin/
RUN chmod 755 /usr/bin/ipfs-gateway-limited /usr/bin/ipfs

CMD /bin/bash
