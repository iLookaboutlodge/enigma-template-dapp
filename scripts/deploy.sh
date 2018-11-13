#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [ -n 'engima-template-dapp' ];then 
  rm -rf enigma-template-dapp;
fi
git clone --single-branch -b millionaires_problem_demo https://github.com/iLookaboutlodge/enigma-template-dapp.git
cd enigma-template-dapp
npm install
darq-truffle migrate --reset --network development
cd enigma-template-app/client 
nohup npm run start &

