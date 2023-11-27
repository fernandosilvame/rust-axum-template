# rust-axum-template

Base project template for API using Rust Axum

## To initialize the environment variables with default:

cp .env.template .env

## To run locally:

cargo build

cargo run

## To create docker image (replace the repository with your own):

docker build -t <repository>/rust-axum-template .

## To run using port 80 (http):

docker run --name rust-axum-template -p <external_port>:<internal_port> <repository>/rust-axum-template:latest
