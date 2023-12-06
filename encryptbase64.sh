#!/bin/bash

phrase="this is a test"
encryptedphrase=$(echo $phrase | base64)

echo $phrase
echo $encryptedphrase
echo
echo "decoding..."
echo $encryptedphrase | base64 --decode
