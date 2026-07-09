<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Apache 2.0 License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">SOCKS-over-SSH Proxy</h3>

  <p align="center">
    A minimal Docker-based SOCKS5 proxy tunnel over SSH using <code>autossh</code>
    <br />
    <a href="https://github.com/capcom6/socks-over-ssh-proxy"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/capcom6/socks-over-ssh-proxy">View on GitHub</a>
    &middot;
    <a href="https://github.com/capcom6/socks-over-ssh-proxy/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    &middot;
    <a href="https://github.com/capcom6/socks-over-ssh-proxy/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
- [About The Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
- [Usage](#usage)
  - [Environment Variables](#environment-variables)
  - [Docker Secrets](#docker-secrets)
  - [Docker Compose](#docker-compose)
  - [Build from Source](#build-from-source)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)




<!-- ABOUT THE PROJECT -->
## About The Project

A minimal Docker image that establishes a SOCKS5 proxy tunnel over SSH using [autossh](https://www.harding.motd.ca/autossh/). It automatically reconnects on connection failure, providing a reliable SOCKS proxy for routing traffic through a remote SSH server.

Key features:

- **Auto-reconnecting** — uses `autossh` to monitor and restart the SSH tunnel on failure
- **Minimal footprint** — built on Alpine Linux
- **Convenience** — runs as a non-root user, accepts SSH host keys automatically for hassle-free first connection
- **Docker-native** — configure via environment variables and Docker secrets

> **Host key verification**: The container uses `StrictHostKeyChecking=accept-new` and stores known hosts in `/tmp/known_hosts`, so host keys are auto-accepted on first connection but not persisted across restarts. To pin a known host key, mount a pre-populated `known_hosts` file:
> ```sh
> -v ~/.ssh/known_hosts:/tmp/known_hosts:ro
> ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Alpine Linux](https://img.shields.io/badge/Alpine_Linux-0D597F?style=for-the-badge&logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
* [autossh](https://www.harding.motd.ca/autossh/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

- Docker
- An SSH server with key-based authentication configured and accessible from your host
- A private SSH key (without passphrase) for connecting to the remote server

### Quick Start

```sh
docker run -d \
  -p 1080:1080 \
  -e SSH_HOST=example.com \
  -e SSH_USER=proxyuser \
  -v $HOME/.ssh/id_rsa:/run/secrets/socks_ssh_key:ro \
  ghcr.io/capcom6/socks-over-ssh-proxy:latest
```

This starts a SOCKS5 proxy on `localhost:1080` that tunnels traffic through `example.com`. Configure your browser or application to use `localhost:1080` as a SOCKS5 proxy.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE -->
## Usage

### Environment Variables

| Variable   | Required | Description                      | Default |
| ---------- | -------- | -------------------------------- | ------- |
| `SSH_HOST` | Yes      | Remote SSH server hostname or IP | —       |
| `SSH_USER` | Yes      | SSH username                     | —       |
| `SSH_PORT` | No       | Remote SSH server port           | `22`    |

### Docker Secrets

Mount your private SSH key at `/run/secrets/socks_ssh_key` using a bind mount. The key must not have a passphrase.

```sh
docker run -d \
  -p 1080:1080 \
  -e SSH_HOST=example.com \
  -e SSH_USER=proxyuser \
  -v $HOME/.ssh/id_rsa:/run/secrets/socks_ssh_key:ro \
  ghcr.io/capcom6/socks-over-ssh-proxy:latest
```

### Docker Compose

```yaml
services:
  socks-proxy:
    image: ghcr.io/capcom6/socks-over-ssh-proxy:latest
    ports:
      - "1080:1080"
    environment:
      SSH_HOST: example.com
      SSH_USER: proxyuser
    secrets:
      - socks_ssh_key

secrets:
  socks_ssh_key:
    file: ./path/to/private_key
```

### Build from Source

```sh
docker build -t socks-over-ssh-proxy .
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Initial release — basic SOCKS5 tunnel via autossh
- [ ] Add health check endpoint
- [ ] Multi-architecture builds (arm64, amd64)
- [ ] Configurable SOCKS bind address

See the [open issues](https://github.com/capcom6/socks-over-ssh-proxy/issues) for a full list of proposed features and known issues.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the Apache License 2.0. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/capcom6/socks-over-ssh-proxy](https://github.com/capcom6/socks-over-ssh-proxy)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [autossh](https://www.harding.motd.ca/autossh/)
* [Alpine Linux](https://alpinelinux.org/)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/capcom6/socks-over-ssh-proxy.svg?style=for-the-badge
[contributors-url]: https://github.com/capcom6/socks-over-ssh-proxy/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/capcom6/socks-over-ssh-proxy.svg?style=for-the-badge
[forks-url]: https://github.com/capcom6/socks-over-ssh-proxy/network/members
[stars-shield]: https://img.shields.io/github/stars/capcom6/socks-over-ssh-proxy.svg?style=for-the-badge
[stars-url]: https://github.com/capcom6/socks-over-ssh-proxy/stargazers
[issues-shield]: https://img.shields.io/github/issues/capcom6/socks-over-ssh-proxy.svg?style=for-the-badge
[issues-url]: https://github.com/capcom6/socks-over-ssh-proxy/issues
[license-shield]: https://img.shields.io/github/license/capcom6/socks-over-ssh-proxy.svg?style=for-the-badge
[license-url]: https://github.com/capcom6/socks-over-ssh-proxy/blob/master/LICENSE
