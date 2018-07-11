<!-- Breadcrumb navigation -->
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="{{ site.url }}{{ site.baseurl }}/">Home</a></li>
    <li class="breadcrumb-item"><a href="{{ site.url }}{{ site.baseurl }}/documentation">Documentation</a></li>
    <li class="breadcrumb-item active" aria-current="page">Démarrer avec AGS</li>
  </ol>
</nav>


<!-- To be placed at the beginning of the post, it is where the table of content will be generated -->
* TOC
{:toc}


# AGS ?

AutoIt Gui Skeleton (AGS) fournit un environnement et des outils pour les développeurs, afin de faciliter la construction d'application AutoIt.

On se propose d'utiliser une organisation du code, des conventions et le modèle suivant pour développer et construire une application AutoIt avec une interface graphique (IHM).
 

# Architecture et vue d'ensemble d'un projet AGS

Un projet AGS respecte l'organisation suivante pour ses fichiers et répertoires.

<pre>
<code class="language-markup">Project root folder
|
|   myApplication.au3          # Main entry program
|   myApplication_GLOBAL.au3   # Centralized global variables declaration
|   myApplication_GUI.au3      # Main GUI handler
|   myApplication_LOGIC.au3    # Logic/Business code only
|   README.md                  # Cause We always need it
|  
+---assets                     # All applications assets
|   +---html
|   +---images
|   \---pdf
|
+---deployment                
|   \---releases               # Contains releases setup (zip and Windows setup files)
|   deployment.bat             # The orquestrator to pilot Windows setup creation
|   deploymeny.iss             # InnoSetup script use to generate Windows setup
|
+---vendor                     # All third-party code use in this project
|   \--- FolderVendor
|              
\---views                      # Views declaration
    View_About.au3
    View_Footer.au3
    View_Welcome.au3</code>
</pre>


## Répertoires et fichiers d'un projet AGS

On organise les fichiers dans des répertoires spécifiques.


### Répertoire `assets`

Ce répertoire contient les éléments utilisés dans l'application comme des images, des fichiers textes, pdf, html, css, javascript. Ce répertoire contient tous les fichiers locaux nécessaires à l'application.


### Répertoire `deployment`

Ce répertoire contient un batch Windows qui pilote la création d'un installeur Windows avec la solution InnoSetup. Pour faire fonctionner le batch, il est nécessaire que le compilateur d'InnoSetup et que 7zip soit installer sur le poste client. Si ce n'est pas le cas, je vous conseille d'utiliser le gestionnaire de package Windows Chocolatey pour les installer simplement :

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">choco install 7zip
choco install innosetup</code>
</pre>


### Répertoire `vendor`

Ce répertoire est l'endroit par convention où stocker le code développé par des tiers dans un projet.

Par exemple, dans ce projet (https://github.com/v20100v/autoit-gui-skeleton), nous avons inclus la bibliothèque GUICtrlOnHover v2.0 créée par G.Sandler a.k.a MrCreatoR dans ce répertoire.


### Répertoire `views`

Ce répertoire contient la définition de toutes les vues. Chaque vue est définie est gérée dans un fichier spécifique de ce répertoire. La séparation des vues dans chaque fichier, en simplifie grandement l'écriture et la maintenance par la suite.


## Vue d'ensemble de l'architecture d'AGS

![Vue d'ensemble de l'architecture d'AGS]({{ site.url }}{{ site.baseurl_root }}/assets/img/documentation/autoit-gui-skeleton_overview.png){:class="img-fancybox img-full"}

### Programme d'entrée principale

Le programme d'entrée principale sert de point d'entrée unique pour l'application AutoIt. C'est l'endroit où l'application démarre. Dans ce dernier, il est nécessaire d'inclure les autres libraires, de définir toutes les variables globales, l'interface graphique et le code métier de l'application.

L'application démarre avec le gestionnaire principal de l'IHM `_main_GUI()`.


### Gestionnaire principal de l'IHM

Ce gestionnaire contiens la méthode `_main_GUI()`. Elle est uniquement appellé par le programme d'entrée principal. Cette méthode a pour rôle de créer l'interface graphique (IHM) et de gérer toutes les interactions et évènements de l'utilisateur.


### Centraliser la déclaration des variables globales

Toutes les constantes et les variables globales sont définis en un seul endroit, dans le fichier `myProject_GLOBALS.au3`. À l'exception de toutes les variables globales des éléments graphiques qui elles, sont définies dans chaque fichier de vue spécifique. On rappelle que les constantes ne peuvent plus changer de valeur dans le temps, contrairement aux variables globales.

Par convention, toutes les variables globales doivent être écrites en majuscule avec un underscore qui sépare les mots. Par exemple : `Global Const $APP_EMAIL_CONTACT`


### Package et déploiement

Dans le but de faciliter le déploiement d'application Windows développé avec AutoIt, on propose d'utiliser un processus automatisée pour construire un installeur Windows avec la solution InnoSetup. Dans AGS, on utilise en plus un fichier batch Windows, appellé `deployment_autoit_application.bat` qui joue le rôle de chef d'orchestre dans la génération de l'installeur. Dans le répertoire `\Deployment`, il va créer le répertoire de sortie `\releases\vx.y.z\` où l'archive zip de l'application, ainsi que le programme d'installation -Windows seront construits.

Pour générer un installeur, il faut suivre plusieurs étapes, dont voici les principales :

- Assigner un numéro de version à l'application;
- Compiler l'application, c'est à dire compiler le programme d'entrée principale myProject.au3 avec le compilateur aut2exe;
- Copier les assets (images, files...) nécessaires au fonctionnement de l'application dans le répertoire de génération;
- Créer l'archive zip;
- Et finalement construire l'installeur Windows par la compilation du script InnoSetup associé.

Toutes ces étapes sont pilotées par le fichier batch Windows `deployment_autoit_application.bat`.

![Result of process to package AutoIt application and generate Windows installer in AGS]({{ site.url }}{{ site.baseurl_root }}/assets/img/documentation/AGS-package-and-deployment-result.png){:class="img-full"}

<br/>

> **Lecture associée**
>
> <a href="{{ site.url }}{{ site.baseurl }}/documentation/code-organization">Organisation du code d'un projet AGS</a>.