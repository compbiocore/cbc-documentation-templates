## Setting up your repo for the index website

The index website [https://compbiocore.github.io](https://compbiocore.github.io) is continuously deployed by Travis CI. In order to have a tile on the website with your project's info, create a YAML file called `ready.yml` in the root of your project:

```yaml
repo:             bioflows
site_name:        Bioflows
site_author:      Asshok Ragavendran
repo_url:         https://github.com/compbiocore/bioflows # not required if repo is part of compbiocore organization.
site_description: Short description of project, workshop, tutorial, or document.
site_url:         https://compbiocore.github.io/
doi: "10.1007/978-3-319-76207-4_15" # if the project has a related publication.
type:             software    # required. choose one of [software, tutorial, workshop, documentation]

```

Example of card generated from the

![Project card](assets/img/project_card.png)

That's it. Travis will run the script that gather that information from Github and update the index site.
