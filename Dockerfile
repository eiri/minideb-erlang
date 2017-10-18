FROM bitnami/minideb:stretch

MAINTAINER Eric Avdey <eiri@eiri.ca>

ARG erl_version=20.1

ENV TERM=xterm \
    CFLAGS="-s -O3 -m64" \
    KERL_CONFIGURE_OPTIONS="--enable-hipe \
--enable-builtin-zlib \
--enable-dynamic-ssl-lib \
--enable-threads \
--without-asn1 \
--without-compiler \
--without-common_test \
--without-cosEvent \
--without-cosEventDomain \
--without-cosFileTransfer \
--without-cosNotification \
--without-cosProperty \
--without-cosTime \
--without-cosTransactions \
--without-debugger \
--without-dialyzer \
--without-diameter \
--without-edoc \
--without-eldap \
--without-erl_docgen \
--without-et \
--without-eunit \
--without-ic \
--without-inets \
--without-megaco \
--without-mnesia \
--without-observer \
--without-orber \
--without-os_mon \
--without-otp_mibs \
--without-parsetools \
--without-reltool \
--without-runtime_tools \
--without-snmp \
--without-ssh \
--without-syntax_tools \
--without-termcap \
--without-tools \
--without-wx \
--without-xmerl"

RUN install_packages \
        curl \
        git \
        make \
        g++ \
        libssl-dev \
        openssl \
        ca-certificates && \
    mkdir -p /opt/erlang/ && \
    curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl && \
    chmod a+x kerl && \
    mv kerl /usr/local/bin/kerl && \
    kerl update releases && \
    kerl build ${erl_version} ${erl_version} && \
    kerl install ${erl_version} /opt/erlang/${erl_version} && \
    kerl delete build ${erl_version} && \
    rm -rf ~/.kerl/archives/* && \
    apt-get purge -y --auto-remove \
        curl \
        git \
        make \
        g++ \
        libssl-dev && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    useradd -ms /bin/bash erlanger

USER erlanger

ENV HOME=/home/erlanger

WORKDIR $HOME

RUN echo "source /opt/erlang/${erl_version}/activate" >> ~/.bashrc

CMD ["/bin/bash"]
