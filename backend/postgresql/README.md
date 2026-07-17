# PostgreSQL integration

PostgreSQL 17 remains on the host. The pgAdmin container provides the browser administration surface at `/postgresql/` and receives a pre-registered host connection from `servers.json`.

The PostgreSQL password is never stored in `servers.json`. pgAdmin will ask for it when the server is opened; the value may be saved in pgAdmin's private Docker volume if the user chooses.
