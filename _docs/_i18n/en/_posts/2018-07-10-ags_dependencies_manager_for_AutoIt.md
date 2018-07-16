---
layout: post
title: AGS provides a fast dependencies manager for AutoIt with Yarn.
tags: [AGS]
feature-img: "assets/img/yarn.png"
thumbnail: "assets/img/yarn.png"
excerpt_separator: <!--more-->
---

> In order to simplify the management of the dependencies of an AutoIt project built with AGS, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository. 


<!--more-->


# Dependency manager for AutoIt 

What is a dependency? A Dependency is an external and standalone package (library) which have one or more files that performs a specific task. Dependency managers are software modules that coordinate the integration of external libraries or packages into larger application stack. Dependency managers use a configuration files to describe the project and its dependencies.

![AGS dependency manager AutoIt]({{ site.url }}{{ site.baseurl_root }}/assets/img/autoit_yarn.jpg)

AGS uses the Node.js ecosystem and its dependency manager npm and Yarn.



## Package AGS : *component* ou *wrapper*

All AGS packages hosted in npmjs.org repository belong to the [@autoit-gui-skeleton](https://www.npmjs.com/search?q=autoit-gui-skeleton) organization. And you can find two types of package hosted in this organization: 

- An **AGS-component** is an AutoIt library, that you can easy use in your AutoIt project built with the AGS framework. Take a look of [AGS-component http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request).
- An **AGS-wrapper** is a simple wrapper for an another library created by another team/developper. Take a look of [AGS-wrapper-json](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json)

 
## How to install an AGS package ?
 
To install an AGS component or wrapper in your project, just type in the root folder where the `package.json` is stored:
 
<pre class="command-line" data-prompt="C: \MyProject\>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-xxx --modules-folder vendor
yarn add @autoit-gui-skeleton/ags-wrapper-xxx --modules-folder vendor</code>
</pre>


## Describe an AGS project and its dependencies

To describe an AGS project and its dependencies we naturally use the `package.json` file, specific to the Node.js ecosystem. You can find more information about this file, and how to fill it here : [https://yarnpkg.com/lang/en/docs/package-json/](https://yarnpkg.com/lang/en/docs/package-json/).

```json
{
  "name": "ApplicationWithCheckUpdater",
  "version": "1.0.0",
  "description": "Example to implementation of AGS-component-check-updater",
  "AGS": {
    "framework": {
      "version": "1.0.0"
    },
    "AutoIt": {
      "version": "3.3.14.5"
    }
  },
  "author": "v20100v <v20100v@no-reply.com>",
  "license": "MIT License",
  "year": "2018",
  "private": true,
  "repository": {
    "url": "not-yet-git",
    "type": "git"
  },  
  "dependencies": {
    "@autoit-gui-skeleton/ags-component-check-updater": "^1.0.0"
  }
}
```

And finaly to install all the dependencies of a given project, you just have to launch this command:

<pre class="command-line" data-prompt="C: \>MyProject\">
<code class=" language-bash">yarn install --modules-folder vendor</code>
</pre> 

All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. If you add AutoIt library in the vendor directory, we recommend wrapping them so that they are also managed by the dependency manager, in the same way as [AGS-wrapper-json](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json)


To install AutoIt dependencies in the `./vendor` directory, and not in the default directory of Node.js `./node_modules`, you must add the `--modules-folder vendor` option. We force this choice to avoid any confusion with a Node.js project. Note that with an AGS project, it is not necessary to explicitly write this option on the command line, thanks to the `.yarnrc` file stored at the root of the project, ie in the same place as the` package.json` file. Yarn automatically use this file to add an additional configuration of options.

 ```text
 #./.yarnrc 
 --modules-folder vendor
 ```

So with this file you can run `yarn install` to install the dependencies directly into the appropriate `./vendor` directory.



<br/>

> **Links related**
>
> [View all published AGS package on npmjs.org](https://www.npmjs.com/search?q=autoit-gui-skeleton)

