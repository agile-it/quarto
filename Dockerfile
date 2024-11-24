FROM  ubuntu:latest

ARG TARGETARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    texlive \
    texlive-lang-german \
    texlive-latex-extra \
    texlive-formats-extra \
    texlive-luatex \
    texlive-xetex \
    texlive-fonts-extra \
    adduser \
    parallel

RUN curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-${TARGETARCH}.deb" \
    && dpkg -i ./quarto-1.5.57-linux-${TARGETARCH}.deb \
    && apt-get install -f \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /work \
    && adduser --home /work --disabled-password quarto \
    && chown quarto /work

WORKDIR /work

VOLUME [ "/work" ]
USER quarto
# RUN init-usertree

CMD ["quarto --help"]