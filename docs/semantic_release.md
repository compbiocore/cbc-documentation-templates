## Introduction

**semantic-release** is used to automate the package release workflow. It determines the next version number, generates the release notes and publishes the package.

**semantic-release** uses the commit messages to determine the type of changes in the codebase. Following formalized conventions for commit messages, semantic-release automatically determines the next semantic version number (major.minor.patch), creates a tag and a release on GitHub, generates a changelog, and publishes the release.

## Conventional Commit Messages
The commit messages need to be standard, we use the [Angular Commit Message Conventions][acmc]. To enforce these rules, we use the package [commitizen][cmtz].
To install commitizen:
```shell
pip install commitizen
```
To use it:
```shell
git add .
cz commit #this replaces the usual git commit -m
```
Then, follow the CLI instructions using the up/down arrows to create your commit message.
```shell
 ❯ feat: A new feature
   fix: A bug fix
   docs: Documentation only changes
   style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
   refactor: A code change that neither fixes a bug nor adds a feature
   perf: A code change that improves performance
   test: Adding missing or correcting existing tests
   chore: Changes to the build process or auxiliary tools and libraries such as documentation generation, ci, etc
```
After selecting the type of change you'll be prompted to type the scope, title, body, and footer for the commit message.
Make sure to read the [Angular Commit Message Conventions][acmc] and [Conventional Commits][cc] for a more in depth explanation and examples.

!!! Important
    It's important to note that this practice works best with the [GitFlow][gf] branching model for Git. semantic-release will try to create a new version whenever the master branch is updated.
## Project Set Up

### setup.cfg
In the `setup.cfg`, add:
```toml
[semantic_release]
version_variable=project_name/__init__.py:__version__
```
This will allow semantic-release to find the version number for the project, and updated that file when a new release is created.

!!! Note
    This is language and project specific. So make sure you change that to reflect your project.

For julia projects, create a `setup.cfg` file:
```toml
[semantic-release]
version_variable=Project.toml:version
```

### Travis CI

**semantic-release** works best when integrated with a CI service. To set up your package for semantic-release, add an environment variable to Travis' settings with a Github token called `GH_TOKEN`, and add the following block to your `.travis.yml`:

!!! Important
    For Python packages that are published on pypi.org, add the variables `PYPI_USERNAME` and `PYPI_PASSWORD` to the Travis environment.
    In addition, the README should be in `.rst` instead of `.md`, or it won't show up correctly on pypi.org.

If using the matrix set up:  
!!! Note
    semantic-release and commitizen are Python packages, but this set-up is helpful for packages developed in other languages.
```yaml
matrix:
  include:
    - stage: semantic release
      language: python
      os: linux
      python: 3.6
      install:
        - pip install typing
        - pip install python-semantic-release
      script:
        - git config --global user.name "semantic-release (via TravisCI)"
        - git config --global user.email "semantic-release@travis"
        - semantic-release --patch publish
```
Or, if the package is in Python, add an `after_success`.  

!!! Attention
    If your package does not support Python 3.6, the previous set up is preferred.
```yaml
after_success:
  - git config --global user.name "semantic-release (via TravisCI)"
  - git config --global user.email "semantic-release@travis"
  - pip install typing
  - pip install python-semantic-release
  - semantic-release --patch publish
```

[acmc]:https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines
[cmtz]:https://pypi.org/project/commitizen/
[gf]:https://datasift.github.io/gitflow/IntroducingGitFlow.html
[cc]:https://www.conventionalcommits.org/en/v1.0.0-beta.2/
