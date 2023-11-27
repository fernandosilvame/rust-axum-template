# Build application
FROM rust:1.72.1 as APP_PLANNER
WORKDIR /usr/local/src
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM rust:1.72.1 as APP_CACHER
WORKDIR /usr/local/src
RUN cargo install cargo-chef
COPY --from=APP_PLANNER /usr/local/src/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

FROM rust:1.72.1 as APP_BUILDER
COPY . /usr/local/src
WORKDIR /usr/local/src
COPY --from=APP_CACHER /usr/local/src/target target
COPY --from=APP_CACHER $CARGO_HOME $CARGO_HOME
RUN cargo build --release

# Stitch everything together
FROM ubuntu:22.04
COPY --from=APP_BUILDER /usr/local/src/target/release/rust-axum-template /usr/local/bin/rust-axum-template
RUN useradd appuser && chown appuser /usr/local/bin/rust-axum-template
USER appuser

WORKDIR /usr/local/bin

# Launch application
ENTRYPOINT [ "./rust-axum-template" ]