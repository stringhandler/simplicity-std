FROM mcr.microsoft.com/devcontainers/rust:1-bookworm

# Install SimplicityHL (simc)
RUN git clone https://github.com/BlockstreamResearch/SimplicityHL.git /tmp/SimplicityHL \
    && cd /tmp/SimplicityHL \
    && cargo build --release \
    && cp /tmp/SimplicityHL/target/release/simc /usr/local/bin/simc \
    && rm -rf /tmp/SimplicityHL

# Install GHC for the Haskell code generator (codegen/Main.hs)
RUN apt-get update && apt-get install -y ghc && rm -rf /var/lib/apt/lists/*
