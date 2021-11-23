---
layout: post
title: How to create a new AGS wrapper ?
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---

> An AGS-wrapper is a simple wrapper for an another library created by another team/developper and which allows you to benefit from the advantages of a dependency manager.

<!--more-->


# How to create a new AGS wrapper ?

## Procedure

1. Create a new folder `./ags-wrapper-xxx`. Replace xxx with the name of the library to wrapped.<br/><br/>

2. Add a `package.json` at the root of this new folder, and fill properties with new values. When you fill this file, respect the AGS conventions.<br/><br/>

3. Add a `README.md` to describe the wrapper. Copy this document from another README wrapper (see https://github.com/autoit-gui-skeleton/ags-wrapper-json#readme).<br/><br/>

4. Add the files of library to wrapped, and fill the property `AGS.wrapper.main` with the name of main library. It can be usefull to create a new AutoIt fill in which we will add all the directives included in order to facilitate its inclusion. In other words by including this file, we will add all the elements of the library. Don't forget to add the `#include-once` directive.<br/><br/>

5. Create a local git repository with a remote origin on Github (or another).
    ```
    git init
    git add README.md
    git commit -m "Init repository"
    git remote add origin https://github.com/autoit-gui-skeleton/ags-wrapper-xxx.git
    git push -u orgin master
    ```

6. Commit and push another files and when the release is ready change the number version (in respect of Semantic versioning) in package.json, and add a git tag `1.x.x`.<br/><br/>

7. Finally publish the project with npm.
    ```
    npm login
    npm publish --access public
    ```

## AGS wrapper conventions

To describe an AGS wrapper and its dependencies we naturally use the `package.json` file, specific to the Node.js ecosystem. You can find more information about this file, and how to fill it here : https://yarnpkg.com/lang/en/docs/package-json/.

At the root of this new folder, add a `package.json` as follows.

```json
{
  "name": "@autoit-gui-skeleton/ags-wrapper-xxx",
  "version": "1.0.0",
  "description": "AGS package for the library xxx, created by ???. This library provides features to ...",
  "author": "v20100v <vb20100bv@gmail.com> (https://github.com/v20100v)",
  "contributors": [
    "v20100v <vb20100bv@gmail.com> (https://github.com/v20100v)"
  ],
  "license": "MIT",
  "keywords": [
    "AGS",
    "AutoIt",
    "AutoIt-GUI-Skeleton",
    "AGS-wrapper",
    "???"
  ],
  "homepage": "https://autoit-gui-skeleton.github.io/",
  "repository": {
    "url": "https://github.com/autoit-gui-skeleton/ags-wrapper-xxx.git",
    "type": "git"
  },
  "bugs": {
    "url": "https://github.com/autoit-gui-skeleton/ags-wrapper-xxx/issues"
  },
  "dependencies": {
    "@autoit-gui-skeleton/ags-wrapper-binary-call": "^1.0.2"
  },
  "AGS": {
    "framework": {
      "version": "1.0.0"
    },
    "AutoIt": {
      "version": "3.3.14.5"
    },
    "wrapper": {
      "main": "xxx.au3"
    }
  }
}
```

It is appreciable to add examples of uses in the dedicated directory `./examples`.

Do not forget to cite the main authors of the library which been wrapped.


## Add a main wrapper file

When we create a wrapper for a library, there is still not just one AutoIt file. In order to simplify, we can create a simple file in order to include all the files of the library in a single call of directive `#include`.

For example :

```autoit
; ./xxx.au3

#include-once

#include "File-one.au3"
#include "File-two.au3"
#include "File-three.au3"

(...)
```

## Check the library is available

In an empty folder, run the following command to test the install the wrapper :

```
yarn add @autoit-gui-skeleton/ags-wrapper-xxx --modules-folder vendor
```

When Yarn resolving packages, if the package is not available you get an unexpected error like this :

> *An unexpected error occurred: "https://registry.yarnpkg.com/@autoit-gui-skeleton%2fags-wrapper-xxx: Not found".*

And if the package is available, is installed into `vendor` folder with all its dependencies.

![AGS wrapper installed]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/ags-wrapper-installed.png){:class="img-full img-fancybox"}<br/><br/>


Here we go !


<br/>

> **Continue reading ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
