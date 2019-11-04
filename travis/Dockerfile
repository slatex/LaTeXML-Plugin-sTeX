# start with a dockerfile for the latexml test runtime
ARG PERL="5.28.0"
ARG TEXLIVE="texlive-2018"
FROM latexml/latexml-test-runtime:${PERL}_${TEXLIVE}

# install trang
RUN apt-get update && \
    apt-get -y install trang && \
    rm -rf /var/lib/apt/lists/*