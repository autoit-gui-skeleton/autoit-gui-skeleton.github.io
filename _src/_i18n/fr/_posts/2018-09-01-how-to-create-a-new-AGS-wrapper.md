---
layout: post
title: Comment créer un nouveau AGS-wrapper ?
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---

> Un AGS-wrapper est une simple enveloppe d’une bibliothèque AutoIt développé par un tiers, et qui permet de bénéficier des avantages d’un gestionnaire de dépendances.

<!--more-->


# Comment créer un nouveau AGS-wrapper ?

## Procedure

1. Créer un nouveau répertoire `./ags-wrapper-xxx`. Remplacer **xxx** avec le nom de la librairie à encapsuler.<br/><br/>

2. Ajouter un fichier `package.json` à la racine du répertoire, et remplacer les propriétés en respectant les conventions AGS.<br/><br/>

3. Ajouter un fichier `README.md` pour décrire le wrapper. Vous pouvez le copier depuis un autre projet pour garder la même structure de document (see https://github.com/autoit-gui-skeleton/ags-wrapper-json#readme).<br/><br/>

4. Ajouter les fichiers de la libraire à encapsuler et remplir correctement la propriété `AGS.wrapper.main`. Il peut être utile de créer un nouveau fichier AutoIt dans lequel nous ajouterons toutes les directives #include des fichiers de la libraire pour faciliter son utilisation. Autrement dit en incluant ce fichier, nous ajouterons tous les éléments de la bibliothèque. N'oubliez pas d'ajouter la directive `# include-once`.<br/><br/>

5. Créer un dépot git dans Github (ou autre).
    ```
    git init
    git add README.md
    git commit -m "Init repository"
    git remote add origin https://github.com/autoit-gui-skeleton/ags-wrapper-xxx.git
    git push -u orgin master
    ```

6. Commit et push les autres fichiers, et lorsque la realse est prete, changer le numéro de version en respect du Semantic Versioning dans le fichier package.json. Ajouter également un git tag `1.x.x`.<br/><br/>

8. Finalement publier le projet avec npm.
    ```
    npm login
    npm publish --access public
    ```

## Conventions AGS d'un wrapper

Pour décrire un wrapper AGS et ses dépendances nous utilisons naturellement le fichier `package.json`, spécifique à l'écosystème Node.js. Vous pouvez trouver plus d'informations sur ce fichier, et comment le remplir ici : https://yarnpkg.com/lang/en/docs/package-json/.

À la racine de ce nouveau dossier, ajoutez un `package.json` comme suit.

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

Il est appréciable d'ajouter des exemples d'utilisations dans le répertoire dédié `./examples`.

N'oubliez pas de citer les principaux auteurs de la bibliothèque qui a été encapsulée.


## Ajouter un fichier wrapper principal

Lorsque nous créons un wrapper pour une bibliothèque, il n'y a toujours pas un seul fichier AutoIt. Afin de simplifier, nous pouvons créer un fichier simple afin d'inclure tous les fichiers de la bibliothèque dans un seul appel de la directive `#include`.

Par exemple :

```autoit
; ./xxx.au3

#include-once

#include "File-one.au3"
#include "File-two.au3"
#include "File-three.au3"

(...)
```

## Vérifiez que la bibliothèque est disponible

Dans un dossier vide, exécutez la commande suivante pour tester l'installation du wrapper :

```
yarn add @autoit-gui-skeleton/ags-wrapper-xxx --modules-folder vendor
```

Lors de la résolution des packages de fil, si le package n'est pas disponible, vous obtenez une erreur comme celle-ci :

> *An unexpected error occurred: "https://registry.yarnpkg.com/@autoit-gui-skeleton%2fags-wrapper-xxx: Not found".*

Et si le package est disponible, il est installé dans le dossier `./vendor` avec toutes ses dépendances.

![AGS wrapper installed]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/ags-wrapper-installed.png){:class="img-full img-fancybox"}<br/><br/>


Here we go !


<br/>

> **Continue la lecture ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
