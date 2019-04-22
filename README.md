# Simple Token App <!-- omit in toc -->

A simple Flask app in Python that requires a correct token in order to return a PING status.

## Table of Contents <!-- omit in toc -->

- [Usage](#usage)
  - [Bash](#bash)
    - [Unauthorized Request without Token](#unauthorized-request-without-token)
    - [Unauthorized Request with Invalid Token](#unauthorized-request-with-invalid-token)
    - [Authorized Request with Valid Token](#authorized-request-with-valid-token)
  - [Docker](#docker)
    - [Pre-Requisites](#pre-requisites)
    - [Unauthorized Request without Token](#unauthorized-request-without-token-1)
    - [Unauthorized Request with Invalid Token](#unauthorized-request-with-invalid-token-1)
    - [Unauthorized Request without Token](#unauthorized-request-without-token-2)
- [Status Messages](#status-messages)
  - [PING_TOKEN is not set or invalid](#pingtoken-is-not-set-or-invalid)
  - [PING_TOKEN is set and valid with a PING response](#pingtoken-is-set-and-valid-with-a-ping-response)
  - [PING_TOKEN is set and valid without a PING response](#pingtoken-is-set-and-valid-without-a-ping-response)
- [License](#license)

## Usage

### Bash

#### Unauthorized Request without Token

1. `./run start`
2. Browse to http://127.0.0.1:5000

#### Unauthorized Request with Invalid Token

1. `export PING_TOKEN=notCyberark1; ./run start`
2. Browse to http://127.0.0.1:5000

#### Authorized Request with Valid Token

1. `export PING_TOKEN=Cyberark1; ./run start`
2. Browse to http://127.0.0.1:5000

### Docker

#### Pre-Requisites

1. Docker CE: `curl -fsSL get.docker.com | sh`
2. `docker build -t sta:latest .`

#### Unauthorized Request without Token

1. `docker run --name sta_notoken -d -p 5000:5000 sta:latest`
2. Browse to http://127.0.0.1:5000

#### Unauthorized Request with Invalid Token

1. `docker run --name sta_invalidtoken -d -e PING_TOKEN=notCyberark1 -p 5000:5000 sta:latest`
2. Browse to http://127.0.0.1:5000

#### Authorized Request with Valid Token

1. `docker run --name sta_validtoken -d -e PING_TOKEN=Cyberark1 -p 5000:5000 sta:latest`
2. Browse to http://127.0.0.1:5000

## Status Messages

### PING_TOKEN is not set or invalid

`Unauthorized Request`

### PING_TOKEN is set and valid with a PING response

`Network Active`

### PING_TOKEN is set and valid without a PING response

`Network Error`

## License

[MIT](LICENSE)
