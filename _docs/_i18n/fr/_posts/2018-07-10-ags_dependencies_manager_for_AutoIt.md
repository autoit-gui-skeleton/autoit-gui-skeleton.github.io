---
layout: post
title: AGS fournit un gestionnaire de dépendances rapide pour AutoIt avec Yarn.
tags: [AGS]
feature-img: "assets/img/yarn.png"
thumbnail: "assets/img/yarn.png"
excerpt_separator: <!--more-->
---

> Pour simplifier la gestion des dépendances d'un projet AutoIt construit avec AGS, nous avons détourné de son usage initial le gestionnaire de dépendances npm, et son évolution Yarn. Ce qui nous permet de gérer les dependances d'un projet AGS avec d'autres librairies AutoIt, et de partager ces packages AutoIt depuis le depôt npmjs.org.


<!--more-->


# Gestionnaire de dépendances pour AutoIt
 
Une dépendance ? C'est un package externe et autonomie (librairie) qui contient un ou plusieurs fichiers, et qui exécute une tâche spécifique. Les gestionnaires de dépendances sont des programmes qui coordonnent l'integration de bibliothèques ou de packages externes dans un projet d'application. Les gestionnaires de dépendances utilisent un fichier de configuration pour décrire le projet et ses dépendances.

![AGS dependency manager AutoIt]({{ site.url }}{{ site.baseurl_root }}/assets/img/autoit_yarn.jpg)

AGS utilise l'écosystème Node.js et son gestionnaire de dépendances npm et Yarn.


## Package AGS : *composant* ou *wrapper*

Tous les paquets AGS hébergés dans le réferentiel npmjs.org appartiennent à l'organisation [@autoit-gui-skeleton](https://www.npmjs.com/search?q=autoit-gui-skeleton). Et vous pouvez y trouver deux types de paquets hébergés dans cette organisation.

- Un **AGS-component** est une bibliothèque AutoIt, que vous pouvez utiliser facilement dans votre projet Autoit construit avec le framework AGS. Jetez un coup d'œil à ce composant [AGS-component http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request).
- Un **AGS-wrapper** est une simple enveloppe d'une bibliothèque AutoIt développé par un tiers. Ce qui permet de beneficier des avantages d'un gestionnaire de dépendances. Jetez un coup d'œil à cet exemple [AGS-wrapper-json](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json) qui encapsule le projet JSON.au3 conçu par Ward.

 
## Comment installer un package AGS ?

Pour installer un composant AGS ou un wrapper dans son projet, il suffit de taper dans le repertoire racine, où le fichier `package.json` est stocké:

<pre class="command-line" data-prompt="C: \MyProject\>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-xxx --modules-folder vendor
yarn add @autoit-gui-skeleton/ags-wrapper-xxx --modules-folder vendor</code>
</pre>


### Décrire un projet AGS et ses dépendances

Pour décrire un projet AGS et ses dependances, on utilise naturellement le fichier `package.json` propre à l'écosystème Node.js. Vous pouvez trouvez plus d'information sur ce fichier ici [https://yarnpkg.com/lang/en/docs/package-json/](https://yarnpkg.com/lang/en/docs/package-json/). 

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

Et finallement pour installer toutes les dépendances d'un projet donné, il suffit alors de lancer cette commande:

<pre class="command-line" data-prompt="C: \>MyProject\">
<code class=" language-bash">yarn install --modules-folder vendor</code>
</pre> 

Toutes les dependances du projet, ainsi que les dépendances filles des dependances mères, sont installés dans le répertoire `./vendor/@autoit-gui-skeleton/`. Si vous avez ajouter des libraires AutoIt dans le repertoire vendor, nous vous conseillons de les "wrapper", afin qu'elles soient aussi gérés par le gestionnaire de dépendances, de la même manière qu'avec [AGS-wrapper-json](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json).

Pour que les dépendances AutoIt s'installent dans le répertoire `./vendor`, et pas dans le répertoire par defaut de Node.js `./node_modules`, il faut ajouter l'option `--modules-folder vendor`. Nous forçons ce choix pour éviter toute confusion avec un projet Node.js. Remarquons qu'avec un projet AGS, il n'est pas nécessaire d'écrire explicitement cet option en ligne de commande grace au fichier `.yarnrc` stocké à la racine du projet, i.e. au même endroit que le fichier `package.json`. Yarn regarge automatiquement dans ce fichier pour ajouter une configuration d'options supplémentaire.

 ```text
 #./.yarnrc 
 --modules-folder vendor
 ```
 
 Ainsi avec ce fichier vous pouvez lancer `yarn install` pour installer les dépendances directement dans le répertoire approprié `./vendor`.



<br/>

> **Liens connexes**
>
> [Voir tous les packages publiées sur npmjs.org](https://www.npmjs.com/search?q=autoit-gui-skeleton)

