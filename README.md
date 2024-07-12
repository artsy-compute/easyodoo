# EasyOdoo Setup Docker

Welcome to EasyOdoo Setup Docker! This repository provides a simple and quick way to set up Odoo using Docker. It's perfect for beginners or anyone looking for a straightforward Odoo installation.

## Features

- **Easy Setup**: Minimal configuration required.
- **Pre-configured Volumes**: Persist your data, configuration, and custom addons.
- **Environment Variables**: Easily configure Odoo and PostgreSQL settings.
- **Automatic Dependency Management**: Ensure Odoo connects to PostgreSQL with the correct credentials.
- **Customizable Ports**: Expose Odoo services on custom ports.

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Getting Started

### Create an \`.env\` File

The basic Docker setup includes default values for environment variables. If you want to customize these values, you can create an .env file in the root of the repository or specify them via the command line.

### Configure Docker Compose

The provided Docker Compose file includes the essential configurations required to get started. You can customize it further to suit your specific requirements.

### Custom Entrypoint Script

The entrypoint script (\`entrypoint.sh\`) is designed to configure Odoo to connect to PostgreSQL with the correct credentials. Ensure this script is executable.

The entrypoint.sh script configures Odoo to connect to PostgreSQL with the correct credentials. Ensure this script is executable. The following environment variables can be configured:

* PASSWORD_FILE: Path to a file containing the PostgreSQL password.
* HOST: The database host (default: 127.0.0.1). 
* PORT: The database port (default: 5432). 
* USER: The PostgreSQL user (default: odoo). 
* PASSWORD: The PostgreSQL password (default: odoo). 
* ODOO_CMD_ARGS: Additional command-line arguments for Odoo.

### Build and Run

Build and run the Docker containers with Docker Compose.

```sh
docker-compose up --build
```

### Access Odoo

Once the containers are up and running, you can access Odoo at the following URL (replace \`localhost\` with your server's IP if not running locally):

- Odoo Web Interface: \`http://localhost:8069\`
- Odoo HTTPS Interface: \`https://localhost:8071\`
- Odoo Longpolling Interface: \`http://localhost:8072\`

## Customization

### Volumes

- **./config**: Odoo configuration directory.
- **./addons**: Custom addons directory.
- **./entrypoint.sh**: Entrypoint script.

### Environment Variables

- **ODOO_CMD_ARGS**: Command-line arguments for Odoo.
- **POSTGRES_PASSWORD**: Password for PostgreSQL.
- **ODOO_PORT**: Port for Odoo web interface (default: 8069).
- **ODOO_HTTPS_PORT**: Port for Odoo HTTPS interface (default: 8071).
- **ODOO_LONGPOLL_PORT**: Port for Odoo longpolling interface (default: 8072).

## Troubleshooting

- Ensure Docker and Docker Compose are installed and running.
- Check container logs for any errors:

```sh
docker-compose logs app
docker-compose logs db
```

- Ensure environment variables are correctly set in the \`.env\` file.

## Contributing

Feel free to submit issues, fork the repository, and send pull requests!

## License

This project is licensed under the MIT License.

---

Happy Odooing! 🚀
