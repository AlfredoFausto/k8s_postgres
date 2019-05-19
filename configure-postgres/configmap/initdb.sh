#!/bin/bash

su - postgres

psql -f /etc/config/createTable.sql workshop
