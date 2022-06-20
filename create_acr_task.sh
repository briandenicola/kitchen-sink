#/bin/bash 

export ACR_NAME=bjd145
export GITHUB_REPO=https://github.com/briandenicola/kitchen-sink#main
export GITHUB_PAT_TOKEN=$1

az acr task create -t utils:{{.Run.ID}} \ 
    -n utils \
    -r ${ACR_NAME} \
    -c ${GITHUB_REPO} \
    -f Dockerfile \
    --commit-trigger-enabled true \
    --base-image-trigger-enabled true \
    --git-access-token ${GITHUB_PAT_TOKEN}
