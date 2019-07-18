# An introduction to retrospectives

These are the slides for a short presentation to BE tribe introducing using Terrform with Ansible to provision Heroku (& AWS) apps

## Dependencies

* [cleaver](https://github.com/jdan/cleaver) - for slides.
* (semi-optional) [pandoc](https://pandoc.org/) - for a PDF version of the speaker notes.
* (optional) [nvm](https://github.com/nvm-sh/nvm) - for managing node version used. Built with version in .nvmrc but will probably work with many other.

`make setup` can install dependencies.

## Usage

Releases will include built versions of the slides.

The instructions to build your own follow.

### Slides for browser user
```bash
make slides.html
open slides.html
```

### Printer friendly version of slides
```bash
make printable-slides.html
open printable-slides.html
```
The releases also contain a PDF version of these printer-friendly slides.

### Speaker notes as PDF
```bash
make speaker-notes.pdf
open speaker-notes.pdf
```
