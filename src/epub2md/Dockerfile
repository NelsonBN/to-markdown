FROM pandoc/core:latest

RUN apk add --no-cache bash

WORKDIR /data

COPY convert.sh /usr/local/bin/convert.sh
RUN chmod +x /usr/local/bin/convert.sh

ENTRYPOINT ["/usr/local/bin/convert.sh"]
