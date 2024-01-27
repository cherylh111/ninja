# 使用基础镜像
FROM golang:alpine AS builder

# 安装必要的工具
RUN apk update && apk add --no-cache \
    curl \
    tar  \
    jq

# 创建新的工作目录
WORKDIR /app

RUN latest_url=https://github.com/gngpp/ninja/releases/download/v0.9.13/ninja-0.9.13-x86_64-unknown-linux-musl.tar.gz \
    && echo $latest_url \
    && curl -Lo ninjia.tar.gz $latest_url \
    && tar -xzf ninjia.tar.gz --strip-components=1 \
    && chmod 777 -R .

#    && rm ninjia.tar.gz 

#RUN rm config.json

# 获取config.json
#RUN --mount=type=secret,id=CONFIG_JSON,dst=/etc/secrets/CONFIG_JSON \
#    cat /etc/secrets/CONFIG_JSON > config.json
#RUN chmod 777 config.json
RUN ls -alh
RUN ls */ -alh
# 修改PandoraNext的执行权限
RUN chmod 777 ./ninja

# 创建全局缓存目录并提供最宽松的权限
RUN mkdir /.cache && chmod 777 /.cache

# 开放端口
EXPOSE 8080

RUN cat /proc/cpuinfo

RUN ls -alh

RUN uname -m

RUN arch

# 启动命令
CMD ["./ninja run"]
