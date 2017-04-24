#!/bin/bash

cd /root/websites/therudes.com/ && \
bundle exec jekyll build --incremental && \
rsync -av _site/* odin.mattrude.com:/var/www/therudes.com/
