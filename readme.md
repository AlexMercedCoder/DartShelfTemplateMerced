# Shelf Web Framework Template
##### by Alex Merced of AlexMercedCoder.com

## Cloning the Template

`git clone https://github.com/AlexMercedCoder/DartShelfTemplateMerced.git projectName`

or if you have NPM

`npx degit AlexMercedCoder/DartShelfTemplateMerced#main projectName`

**POSTGRES VERSION OF TEMPLATE**

https://github.com/AlexMercedCoder/DartShelfPostgresTemplate

## Folder Structure

- server.dart: the entry file that kick starts the server

- cors.dart: The cors header, add this into your responses like in the existing routes

- controllers: folder for holding routers, HomeController has the main router and you can following the patter display by TestController to mount additonal routers.

## Deployment to Heroku using Heroku CLI

- create a git repo and commit your project
    - `git init`
    - `git add .`
    - `git commit -m "first commit"`

- `heroku create projectName`

- `heroku config:set DART_SDK_URL=https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-x64-release.zip`

- `heroku config:add BUILDPACK_URL=https://github.com/igrigorik/heroku-buildpack-dart.git`

- `heroku config:set DART_BUILD_CMD="./dart-sdk/bin/dart compile exe web/server.dart"`

- `git push heroku master`

- API Deployed!!
