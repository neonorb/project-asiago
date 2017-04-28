# Contributing
1. Join the Telegram [chat](https://t.me/joinchat/AAAAAEF_t3aEpuC9QxJ5MQ), this is where we discuss different ideas and concepts about Project Asiago. Also, checkout the issue pages for each project.
1. You will need a GPG key to sign your commits with, there is a great tutorial over [here](http://blog.dpg.io/articles/gpg-linux) to get you started. You will also want to [add it to your GitHub account](https://help.github.com/articles/adding-a-new-gpg-key-to-your-github-account/).
1. Fork the desired repository on GitHub and update the upstream url: `make init GIT_ROOT=git@github.com:<username>/`. We use the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model, so you'll need to checkout the `develop` branch: `make checkout develop`. You may also want to install `git-flow`.
1. Once you make your desired changes, write any necessary unit tests and run them. Although it *should* be automatic, **make sure you sign the commit(s)**.
1. Submit a pull request.

## Code Style Guide
Try to keep the style similar to what we have already, but stick to these:
 - braces on same line
 - tabs > spaces
 - classes: `MyHttpClass`
 - variables: `myVariable`
 - constants: `MY_CONSTANT`
 - functions: `myFunction()`
 - use namespaces

## Updating
The main repo is updated regularly. To retrieve updates, run `make pull-upstream`. Then rebuild whatever project you want.