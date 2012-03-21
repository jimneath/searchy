# Searchy

## Introduction

Searchy is the simplest search gem available. It will search all `string` and `text` fields of a model for the given keyword/s. Searchy returns a `ActiveRecord::Relation`, so may be chained with other scopes.

## Caveats

Only tested on MySQL and Ruby 1.9.3

## Usage

    User.search('jim').limit(10)
    
## Credits

Jim Neath