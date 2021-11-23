---
layout: post
title: AGS facilite la création d'installeur Windows (setup) d'application AutoIt
tags: [AGS, InnoSetup]
feature-img: "assets/img/pixabay/jigsaw-puzzle-712465_1920.jpg"
thumbnail: "assets/img/pixabay/jigsaw-puzzle-712465_1920.jpg"
excerpt_separator: <!--more-->
---

> AGS fournit un processus et d'autres fonctionnalités pour faciliter la création d'un installeur Windows (setup) d'une application AutoIt.

<!--more-->


# Fonctionnalités pour faciliter le déploiement d'application d'AutoIt

Voici quelques nouvelles fonctionnalités avec le couple AGS et InnoSetup:

- Générer un package (archive zip) et un installeur Windows.
- Soutenir l'internationalisation (i18n).
- Vérifier si l'application est déjà installée.
- Configurer des messages supplémentaires dans la configuration comme: contrat de licence, prérequis et projet d'historique.
- Ajouter l'application dans le menu Démarrer de Windows.
- Lancer une commande personnalisée après la fin de l'installation.
- Personnaliser et modifier les éléments graphiques du programme d'installation de Windows.


# AGS utilise un batch Windows pour automatiser la génération du setup

Dans AGS on utilise un batch Windows qui joue le rôle de chef d'orchestre, pour générer le setup.

![AGS GUI package and deployment process]({{ site.url }}{{ site.baseurl_root }}/assets/img/documentation/AGS-package-and-deployment-process.gif){:class="img-full img-fancybox"}


<br/>

> **Lire la documentation AGS**
>
> [Création d'installeur - setup Windows - pour des applications AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/creating-setup-package-autoit-application)
 