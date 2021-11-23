AGS website documentation
=========================

> The webiste [https://autoit-gui-skeleton.github.io/](https://autoit-gui-skeleton.github.io/) is built with Jekyll and deploy on Github Pages.


<br/>

## Github Pages with Jekyll

Jekyll is a simple, blog-aware, static site generator perfect for personal, project, or organization sites. Think of it like a file-based CMS, without all the complexity. Jekyll takes your content, renders Markdown and Liquid templates, and spits out a complete, static website ready to be served by Apache, Nginx or another web server. Jekyll is the engine behind GitHub Pages, which you can use to host sites right from your GitHub repositories.

> More information about [Jekyll](https://jekyllrb.com) 

GitHub Pages is a static site hosting service designed to host your personal, organization, or project pages directly from a GitHub repository. For the AGS website documentation, we use Jekyll as a static site generator with GitHub Pages. In addition to supporting regular HTML content, GitHub Pages supports Jekyll.

> More information about [Jekyll support on Github Pages](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll).

## Developement

### How to run website localy ?

We have different option :

```batch
λ ./_bin/serve.bat

λ jekyll serve
λ jekyll serve --watch
λ jekyll serve --watch --incremental
λ jekyll serve --watch --incremental --livereload
```

The local website is available on http://localhost:4000/.

### How to build static site ?

To build the site, only run this batch: 

```batch
λ ./_bin/build.bat
```

You can see the built of the static site in the folder `./_src/_site/`. The website support two languages, and you can see the result of the french version into the folder `./_src/_site/fr/`. 

### How to publish AGS website on its Github pages ?

To publish the site, commit and push this local repository to the remote (origin). After a short latence, you can see result on [https://autoit-gui-skeleton.github.io/](https://autoit-gui-skeleton.github.io/).

```batch
λ ./_bin/publish.bat
```

## About

### Support

AGS is free and available as open source under the terms of the [MIT License](./LICENSE.md), but if you want to support me, you can [buy me a coffee here](https://www.buymeacoffee.com/vincent.blain) !

### Contributing

Bug reports, reports a typo in documentation, comments, pull-request & Github stars are always welcome !

### License

Release under [MIT License](./LICENSE.md).

Copyright (c) 2020 by 2o1oo vb20100bv@gmail.com