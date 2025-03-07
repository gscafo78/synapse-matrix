# Synapse - Matrix

This repository contains the configuration and setup for a Synapse Matrix server with PostgreSQL, Traefik, and Coturn.

## Prerequisites

- Docker
- Docker Compose

## Setup

1. Clone the repository:
    ```sh
    git clone https://github.com/gscafo78/synapse-matrix.git
    cd synapse-matrix
    ```

2. Copy the example environment file and update it with your configuration:
    ```sh
    cp .env_example .env
    nano .env
    ```

3. Initialize the Synapse configuration:
    ```sh
    ./init.sh
    ```

4. Start the services:
    ```sh
    docker-compose up -d
    ```

5. Register user:
    ```sh
    python add-user.py -n <FirstName> -s <LastName> -p <Password> -H <MatrixHost>
    ```

## Services

- **Traefik**: Reverse proxy and load balancer.
- **PostgreSQL**: Database for Synapse.
- **Synapse**: Matrix homeserver.
- **Element**: Web client for Matrix.
- **Coturn**: TURN server for media relay.

## Configuration Files

- `docker-compose.yml`: Docker Compose configuration for all services.
- `homeserver.template.yaml`: Template for Synapse configuration.
- `element-config.template.json`: Template for Element configuration.
- `coturn/turnserver.template.conf`: Template for Coturn configuration.
- `postgres-config/postgresql.conf`: PostgreSQL configuration.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

