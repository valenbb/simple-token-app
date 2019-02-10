# Simple Token App <!-- omit in toc -->

A simple Flask app in Python that requires a correct token in order to return a PING status.

## Table of Contents <!-- omit in toc -->

- [Usage](#usage)
  - [Unauthorized Request without Token](#unauthorized-request-without-token)
  - [Unauthorized Request with Invalid Token](#unauthorized-request-with-invalid-token)
  - [Authorized Request with Valid Token](#authorized-request-with-valid-token)
- [Status Messages](#status-messages)
  - [PING_TOKEN is not set or invalid](#pingtoken-is-not-set-or-invalid)
  - [PING_TOKEN is set and valid with a PING response](#pingtoken-is-set-and-valid-with-a-ping-response)
  - [PING_TOKEN is set and valid without a PING response](#pingtoken-is-set-and-valid-without-a-ping-response)
- [License](#license)

## Usage

### Unauthorized Request without Token

1. `./run start`
2. Browse to http://127.0.0.1:5000

### Unauthorized Request with Invalid Token

1. `export PING_TOKEN=notCyberark1; ./run start`
2. Browse to http://127.0.0.1:5000

### Authorized Request with Valid Token

1. `export PING_TOKEN=Cyberark1; ./run start`
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
