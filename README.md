# Simple Token App

A simple Flask app in Python that requires a correct token in order to return a PING status.

## Usage

### Unauthorized Request without Token

1. `./run start`
2. Browse to http://127.0.0.1:5000

### Unauthorized Request with Invalid Token

1. `export PING_TOKEN=notCyberark1 && ./run start`
2. Browse to http://127.0.0.1:5000

### Authorized Request with Valid Token

1. `export PING_TOKEN=Cyberark1 && ./run start`
2. Browse to http://127.0.0.1:5000

## Status Messages

### PING_TOKEN is not set or invalid

`Unauthorized Request`

### PING_TOKEN is set and valid with a PING response

`Network Active`

### PING_TOKEN is set and valid without a PING response

`Network Inactive`

## License

[MIT](LICENSE)