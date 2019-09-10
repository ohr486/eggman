FROM lambci/lambda-base:build

RUN set -e && \
    yum -y install ncurses-devel

ARG OTP_VER="22.0.7"
RUN set -e && \
    OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VER}.tar.gz" && \
    OTP_DOWNLOAD_SHA256="04c090b55ec4a01778e7e1a5b7fdf54012548ca72737965b7aa8c4d7878c92bc" && \
    curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" && \
    echo "$OTP_DOWNLOAD_SHA256  otp-src.tar.gz" | sha256sum -c - && \
    export ERL_TOP="/usr/src/otp_src_${OTP_VERN%%@*}" && \
    mkdir -vp $ERL_TOP && \
    tar -xzf otp-src.tar.gz -C $ERL_TOP --strip-components=1 && \
    rm otp-src.tar.gz && \
    ( cd $ERL_TOP && \
      ./otp_build autoconf && \
      ./configure && \
      make -j$(nproc) && \
      make install ) && \
    find /usr/local -name examples | xargs rm -rf

CMD ["erl"]

ENV REBAR_VER="2.6.4"
RUN set -xe && \
    REBAR_DOWNLOAD_URL="https://github.com/rebar/rebar/archive/${REBAR_VER}.tar.gz" && \
    REBAR_DOWNLOAD_SHA256="577246bafa2eb2b2c3f1d0c157408650446884555bf87901508ce71d5cc0bd07" && \
    mkdir -p /usr/src/rebar-src && \
    curl -fSL -o rebar-src.tar.gz "$REBAR_DOWNLOAD_URL" && \
    echo "$REBAR_DOWNLOAD_SHA256 rebar-src.tar.gz" | sha256sum -c - && \
    tar -xzf rebar-src.tar.gz -C /usr/src/rebar-src --strip-components=1 && \
    rm rebar-src.tar.gz && \
    cd /usr/src/rebar-src && \
    ./bootstrap && \
    install -v ./rebar /usr/local/bin/ && \
    rm -rf /usr/src/rebar-src

ARG REBAR3_VER="3.12.0"
RUN set -xe && \
    REBAR3_DOWNLOAD_URL="https://github.com/erlang/rebar3/archive/${REBAR3_VER}.tar.gz" && \
    REBAR3_DOWNLOAD_SHA256="8ac45498f03e293bc6342ec431888f9a81a4fb9e1177a69965238d127c00a79e" && \
    mkdir -p /usr/src/rebar3-src && \
    curl -fSL -o rebar3-src.tar.gz "$REBAR3_DOWNLOAD_URL" && \
    echo "$REBAR3_DOWNLOAD_SHA256 rebar3-src.tar.gz" | sha256sum -c - && \
    tar -xzf rebar3-src.tar.gz -C /usr/src/rebar3-src --strip-components=1 && \
    rm rebar3-src.tar.gz && \
    cd /usr/src/rebar3-src && \
    HOME=$PWD ./bootstrap && \
    install -v ./rebar3 /usr/local/bin/ && \
    rm -rf /usr/src/rebar3-src

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ENV MIX_REBAR3=/usr/local/bin/rebar3
ENV MIX_REBAR=/usr/local/bin/rebar

ARG ELIXIR_VER=1.9.1
RUN set -xe && \
    ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VER}.tar.gz" && \
    ELIXIR_DOWNLOAD_SHA1="94daa716abbd4493405fb2032514195077ac7bc73dc2999922f13c7d8ea58777" && \
    curl -fsSL $ELIXIR_DOWNLOAD_URL -o elixir-src.tar.gz && \
    echo "$ELIXIR_DOWNLOAD_SHA1 elixir-src.tar.gz" | sha256sum -c - && \
    mkdir -p /usr/src/elixir-src && \
    tar -xzf elixir-src.tar.gz -C /usr/src/elixir-src --strip-components=1 && \
    rm elixir-src.tar.gz && \
    cd /usr/src/elixir-src && \
    make -j$(nproc) && \
    make install && \
    rm -rf /usr/src/elixir-src && \
    cd $HOME && \
    mix local.hex --force && \
    mix hex.info

CMD ["iex"]
