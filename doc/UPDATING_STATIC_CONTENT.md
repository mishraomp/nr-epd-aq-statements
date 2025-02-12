# Updating Static Content

## Content

There are four pages that provide base content for the static site. They are:

- `index.qmd` - the home page
- `measuring.qmd` - 'Measuring air quality' document
- `shortcode_demos.qmd` (provided as an example)
- `statements.qmd` - A dynamic list of historic statements. Contents are generated automatically based on the contents
  of the preamble ([Quarto Custom Listings](https://quarto.org/docs/websites/website-listings-custom.html))

These four documents are written in QMD format and can be edited via Github Pull Request against the `main` branch.

You can add or remove content as required to edit the static content of the site. Create, edit, or delete files with
a `.qmd` extension in the `frontend` directory. Any file whose name starts with an underscore `_` will be ignored by
Quarto during the rendering step.

## Navigation

You may wish to add, remove, or reorder the contents of the site navigation top bar or sidebar. They will not be updated
automatically if you add or delete static content files. These elements are defined in the
file `_extensions/bcds/_extension.yaml` under the key `contributes.project.website`.
