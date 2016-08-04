# About this project

This app is a tryout to use [VIPER architecture](https://www.objc.io/issues/13-architecture/viper/), it is unfinished and not planned to be.

The idea was to have a list of words to remember and having the local notifications remind the user about the words to help him/her learn it. Also planned to derive the project to macOS as a terminal command.


## Misc

The `travis-private` is a example to have travis-ci clone a private repo on bitbucket and deploy the app to TestFlight without using a private Github account.

## Deployment

* increase build
* set bundle id to `com.fbenaiteau.bam.adhoc`
* `ipa build`
* `ipa distribute`
