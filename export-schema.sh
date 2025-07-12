#!/bin/bash
# Schema export script for database changes
# Run this after making any database changes

echo "Exporting current database schema..."
PGPASSWORD=dipra3223 pg_dump --schema-only -h localhost -U postgres litloom > database/dipra-schema.sql

echo "Schema exported to database/dipra-schema.sql"
echo "Commit this file to git for your collaborator to import manually"