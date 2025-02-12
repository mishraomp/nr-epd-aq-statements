# Releasing an Advisory

## Process Overview

1. This repository, `nr-epd-aq-statements` comprises a Quarto application that will collate and render documents in
   Markdown format, producing a complete website with navigation and several automatically-generated lists (for example,
   current Smoky Skies Bulletins, and historical advisories).
2. The resulting website is published on [Github pages](https://bcgov.github.io/nr-epd-aq-statements/). It is a static
   website, and must be rebuilt from scratch each time content changes. It must also be rebuilt to recompute lists (for
   example, those that rely on dates, like the
   list of active bulletins). It should ideally be rebuilt daily to remain current.
3. To contribute a new Smoky Skies Bulletin or Advisory, use the companion Shiny application. This application will
   produce three output files when run. Those three files should be submitted to this repository in the form of a
   pull-request.
4. When the pull-request is merged, the site will begin to rebuild. You can view the status of the build process
   in [Github Actions](https://github.com/bcgov/nr-epd-aq-statements/actions). Once the action completes, the new
   content will be available on the public [Github pages](https://bcgov.github.io/nr-epd-aq-statements/) site
   immediately.

<img src="Contribution Flow.svg" width=600 alt='Contribution Workflow'/>

## Pull Request Details

- The pull request should be created against the `main` branch. This can be accomplished by either checking out the
  repository locally and making changes with the `git` command line or desktop tools, or via Github's web interface
  using the [upload tool](https://github.com/bcgov/nr-epd-aq-statements/upload/main).
- Regardless of the method for creating the pull request, it should include three files:
  - `map.html`
  - dated markdown file (eg `2025-02-06_Smoky-Skies_Issue.md`)
  - corresponding PDF file (eg `2025-02-06_Smoky-Skies_Issue.pdf`)
- The files should be contributed to the project in the directory `frontend/statements/YYYY-MM/DD`. Separating the files
  in this way ensures that `map.html` is not overwritten (since each statement has a corresponding map file and its name
  is not easily changed).
- If more than one statement is created on a given day, consider creating them in further subfolders with a meaninful
  name, such as the region or the hour of issue.

