# This is the Source Repository for therudes.com website

[![Build Status](https://travis-ci.org/mattrude/therudes.com.svg?branch=master)](https://travis-ci.org/mattrude/therudes.com)

This site is built using the [Jekyll](https://jekyllrb.com/) scripting language.

## Building the site

This document will walk you threw installing this site on a [Ubuntu](https://www.ubuntu.com) server, but that does not mean it will not work on other system.

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
    cd therudes-site

### Compiling the site

Once you have everything, you must build the site.

    bundle exec jekyll build

The Current config will put the finished site in `/var/www/therudes.com/`

## License

    The Source Repository for therudes.com
    Copyright (C) 2016-2017 - Matt Rude <matt@mattrude.com>

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
