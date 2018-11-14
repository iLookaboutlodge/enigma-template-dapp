#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

cd enigma-template-dapp
npm install
darq-truffle migrate --reset --network development
cd enigma-template-dapp/client 
npm install
nohup npm run start &

