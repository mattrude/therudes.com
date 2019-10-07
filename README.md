# Source Repository for therudes.com - [![Build Status](https://travis-ci.org/mattrude/therudes.com.svg?branch=master)](https://travis-ci.org/mattrude/therudes.com) [![GitHub license](https://img.shields.io/github/license/mattrude/therudes.com.svg)](https://github.com/mattrude/therudes.com/blob/master/LICENSE) [![Open Issues](https://img.shields.io/github/issues-raw/mattrude/therudes.com.svg)](https://github.com/mattrude/therudes.com/issues) [![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)](http://github.com/mattrude/therudes.com)

This is the source repository for the website `therudes.com`.  This is a static site, built using the [Jekyll](https://jekyllrb.com/) scripting language.  The server is only required to server staic files.

## Table of Content

* [Modifying the site](#modifying-the-site)
 * [Changing the Front Page](#changing-the-front-page)
 * [Changing Members Content](#changing-members-content)
* [Building the Site](#building-the-site)
 * [Installing required software](#installing-required-software)
 * [Downloading the source code](#downloading-the-source-code)
 * [Compiling the site](#compiling-the-site)
* [Serving the site](#serving-the-site)
 * [Letsencrypt Build](#letsencrypt-build)
 * [Nginx Full Config](#nginx-full-config)
* [License](#license)

## Modifying the site

### Changing the Front Page

### Changing Members Content

## Building the site

This site may be build on one system, then transferred to another system to be served.  This document will walk you threw installing this site on a [Ubuntu](https://www.ubuntu.com) server, but that does not mean it will not work on other system.

### Installing required software

Before starting, you must installed the below required packages. 

    apt update && apt -y install git ruby ruby-dev

Then install the necessary Ruby Gem's

    gem install rouge
    gem install json
    gem install bundler
    gem install kramdown
    gem install therubyracer
    gem install jekyll
    gem install jekyll-sitemap

### Downloading the source code

After downloading the required packages, you must install the git repository.

    git clone https://github.com/mattrude/therudes.com.git
    cd therudes.com

### Compiling the site

Once you have everything, you must build the site.

    bundle exec jekyll build

The Current config will put the finished site in `/var/www/therudes.com/`

## Serving the site

Since this is a static site, only a simple web server is required to correctly server this site.  The site is currently set to link to TLS `https` encrypted pages, you may disable this function via the `url` item in the `_config.yml` file.

### Letsencrypt Build

To server this site, you first must install the necessary packets.

    apt -y install nginx letsencrypt

And start nginx

    service nginx start

Then add the below into your `nginx.conf` file.

    #----------------------------------------------------------------------
    # therudes.com
    #----------------------------------------------------------------------

    server {
        listen 80;
        listen [::]:80;
        server_name therudes.com;
        server_name www.therudes.com;

        location '/.well-known/acme-challenge' {
            default_type "text/plain";
            root /var/www/therudes.com;
        }

        location / {
            return              301 https://$server_name$request_uri;
        }
    }

And reload the `nginx` config file.

    nginx -s reload

After nginx has reloaded, and the site has been built, using the above setup, you need to create a new SSL key and request a certificate vi `letsencrypt`.

    letsencrypt certonly --webroot -w /var/www/therudes.com -d therudes.com -d www.therudes.com

After successfully creating your new SSL Key and Certificate, you need to add the reset of the config to your `nginx.conf` file.

Add the below section to just below the previously added section to your `nginx.conf` file.

    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name therudes.com;
        server_name www.therudes.com;
        root /var/www/therudes.com;
        index index.html;

        ssl_certificate         /etc/letsencrypt/live/therudes.com/fullchain.pem;
        ssl_certificate_key     /etc/letsencrypt/live/therudes.com/privkey.pem;
        ssl_stapling on;

        error_page 404 /404.html;
    }

And once again reload the `nginx` config file.

    nginx -s reload

### Nginx Full Config

Add the below to your [nginx](https://nginx.org) config file, and reload your config.

    #----------------------------------------------------------------------
    # therudes.com
    #----------------------------------------------------------------------

    server {
        listen 80;
        listen [::]:80;
        server_name therudes.com;
        server_name www.therudes.com;

        location '/.well-known/acme-challenge' {
            default_type "text/plain";
            root /var/www/therudes.com;
        }

        location / {
            return              301 https://$server_name$request_uri;
        }
    }

    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name therudes.com;
        server_name www.therudes.com;
        root /var/www/therudes.com;
        index index.html;

        ssl_certificate         /etc/letsencrypt/live/therudes.com/fullchain.pem;
        ssl_certificate_key     /etc/letsencrypt/live/therudes.com/privkey.pem;
        ssl_stapling on;

        error_page 404 /404.html;
    }

## License

    The Source Repository for therudes.com
    Copyright (C) 2016-2019 - Matt Rude <matt@mattrude.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
