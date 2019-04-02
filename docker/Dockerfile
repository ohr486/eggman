FROM lambci/lambda-base:build

RUN set -e && \
    yum -y install ncurses-devel

ARG OTP_VER="21.1.1"

RUN set -e && \
    OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VER}.tar.gz" && \
    OTP_DOWNLOAD_SHA256="a6588243e9659960e184083f49b15ea37890e4cd9bb8aef84ba4180db68befc3" && \
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
