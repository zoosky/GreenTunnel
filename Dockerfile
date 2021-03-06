FROM mhart/alpine-node:12

ENV PORT 8000
ENV VERBOSE 'green-tunnel:*'
ENV SILENT false
ENV DNS_TYPE 'https'
ENV DNS_SERVER 'https://cloudflare-dns.com/dns-query'

WORKDIR /green-tunnel

COPY package*.json ./
RUN npm ci

COPY src ./src
COPY bin ./bin

EXPOSE 8000/tcp

CMD node ./bin/gt.js \
	--verbose $VERBOSE \
	--ip 0.0.0.0 \
	--port $PORT \
	--silent $SILENT \
	--system-proxy false \
	--dns-type $DNS_TYPE \
	--dns-server $DNS_SERVER
