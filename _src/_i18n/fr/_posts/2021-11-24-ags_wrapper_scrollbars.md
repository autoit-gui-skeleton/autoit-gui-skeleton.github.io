---
layout: post
title: Simplifier l'utilisation de scrollbars avec <b>AGS-wrapper-scrollbars</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---


> AGS fournit le *wrapper* [@autoit-gui-skeleton/ags-wrapper-scrollbars](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-scrollbars) pour la librairie [GUIScrollbar_Ex and GUIScrollbars_Size](https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/) construite par Melba23.



<!--more-->


# Comment installer AGS-wrapper-scrollbars ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-wrapper-json, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké :

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-scrollbars --modules-folder vendor</code>
</pre>


Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. Pour l'utiliser dans son programme AutoIt, vous devez inclure cette bibliothèque avec l'instruction :

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/GUIScrollBars_Ex.au3'
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/GUIScrollBars_Size.au3'
```

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.


# Scrollbars

## Introduction

**GUIScrollbars_Ex.au3** - Cette librairie permet de créer des scrollbars selon votre GUI en une seule et simple commande, sans autres inclusions. La librairie est conçu pour simplifier le processus trop complexe pour créer des scrollbars dans AutoIt. Elle comprend également une commande pour vous permettre de faire défiler l'interface page par page, facilitant ainsi le défilement n'importe où sur l'interface graphique avec uniquement des calculs simples basés sur les valeurs que vous avez utilisées pour créer les interfaces graphiques. Les scrollbars sont également récalculées dans des interfaces graphiques redimensionnables.

**GUIScrollbars_Size.au3** - Calcule les nombres Page et Max que l'utilisateur doit alimenter dans les commandes _GUIScrollbar_SetScrollInfoPage/Max. Cette librairie s'adresse aux développeurs plus expérimenté, mais s'avère particulièrement utile lorsque vous avez une interface graphique avec une taille de défilement dynamique (c'est-à-dire en ajoutant ou en soustrayant des contrôles à la zone de défilement pendant l'exécution du script).

> Source de Melba23 : [https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/](https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/)

## Examples

### Simple usage

```autoit
#include <guiconstantsex.au3>
#include "GUIScrollbars_Ex.au3"

; Create GUI with red background
$hGUI = GUICreate("Test", 500, 500)
GUISetBkColor(0xFF0000, $hGUI)

; Create a 1000x1000 green label
GUICtrlCreateLabel("", 0, 0, 1000, 1000)
GUICtrlSetBkColor(-1, 0x00FF00)
GUISetState()

; Generate scrollbars
_GUIScrollbars_Generate($hGUI, 1000, 1000)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd
```

### Autres examples 

Voir plus d'[exemples](https://github.com/autoit-gui-skeleton/ags-wrapper-scrollbars/tree/master/Examples) dans le dépôt git du wrapper.


<br/>

> **Continue la lecture ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
