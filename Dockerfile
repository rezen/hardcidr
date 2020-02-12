FROM ubuntu:18.04
RUN apt-get update -y && apt-get install -y dnsutils curl ipcalc netcat
RUN mkdir /app
WORKDIR /app

COPY ./src/LICENSE ./src/hardCIDR.sh ./src/lacnicdb.txt ./

RUN cat hardCIDR.sh | sed -r 's/read -e ([a-z]+)/\1=\"$\{ARG_\U\1\}"/g' > hardCIDR_env.sh && chmod +x hardCIDR_env.sh
RUN sed -i '2a [ $(printenv | grep ARG_ | grep -v -E "\=$" | wc -l) -eq 5 ] || { echo "Missing ARG_*" && exit 1; }' hardCIDR_env.sh && \
    sed -i '3a echo "[i] Using args"' hardCIDR_env.sh && \
    sed -i '4a echo "--------------------------"' hardCIDR_env.sh && \
    sed -i '5a printenv | grep ARG_' hardCIDR_env.sh && \
    sed -i '6a echo "--------------------------"' hardCIDR_env.sh

ENV ARG_ORGINPUT ""
ENV ARG_EMAILDOMAIN "example.com"
ENV ARG_CCUSED "N"
ENV ARG_CCPOS ""
ENV ARG_OVERWRITE "Y"

CMD ["./hardCIDR_env.sh", "-h"]
