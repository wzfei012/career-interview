#!/bin/sh

msg=`date "+%Y-%m-%d" `
msg+=" #${@-note}"

git add . 
git commit -m "${msg}"

git pull

git push