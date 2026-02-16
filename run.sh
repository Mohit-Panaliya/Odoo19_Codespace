#!/bin/bash
echo "🐘 Starting Services..."
sudo service postgresql start

# Create Odoo DB role
psql -h 127.0.0.1 -U postgres -c "CREATE USER odoo WITH PASSWORD 'odoo' SUPERUSER;" 2>/dev/null || \
psql -h 127.0.0.1 -U postgres -c "ALTER USER odoo WITH PASSWORD 'odoo' SUPERUSER;"

echo "🌐 Cleaning Port 8069..."
OS_PID=$(lsof -t -i:8069)
[ ! -z "$OS_PID" ] && kill -9 $OS_PID

# Force 'admin' password 
sed -i 's/^admin_passwd =.*/admin_passwd = admin/' odoo.conf

echo "🚀 Launching Odoo 19..."
echo "------------------------------------------------"
echo "MASTER PASSWORD: admin"
echo "URL: https://${CODESPACE_NAME}-8069.app.github.dev"
echo "------------------------------------------------"

./odoo-venv/bin/python odoo/odoo-bin -c odoo.conf "$@"
