#!/bin/bash

read -p "Enter the key: " key
read -p "Enter the value: " value

base_url="http://localhost/api"

echo ""
echo "========================================"
echo "Storing value in Redis..."
echo "========================================"

curl -X POST \
  "${base_url}/cache?key=${key}&value=${value}"

echo ""
echo ""

echo "========================================"
echo "Retrieving value from Redis..."
echo "========================================"

curl \
  "${base_url}/cache?key=${key}"

echo ""
echo ""