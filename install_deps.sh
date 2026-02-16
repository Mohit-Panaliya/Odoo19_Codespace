#!/bin/bash
if [[ "$VIRTUAL_ENV" != *"odoo-venv"* ]]; then
    echo "❌ ERROR: Activate venv first: source odoo-venv/bin/activate"
    exit 1
fi

echo "🆙 Updating Pip and Build Tools..."
pip install --upgrade pip setuptools wheel

echo "🧹 Installing Odoo 19 Python Libraries..."
# Odoo 19 (Master) requirements are usually stable but heavy
pip install -r odoo/requirements.txt

# Ensure compatibility for the latest ORM changes
pip install psycopg2-binary python-ldap==3.4.4

echo "🚀 Python Environment for Odoo 19 Ready!"
