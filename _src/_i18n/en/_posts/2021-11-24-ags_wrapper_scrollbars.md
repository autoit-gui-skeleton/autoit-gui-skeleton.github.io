---
layout: post
title: Simplify the use of scrollbars with <b>AGS-wrapper-scrollbars</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---


> AGS provides the *wrapper* [@autoit-gui-skeleton/ags-wrapper-scrollbars](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-scrollbars) for the library [GUIScrollbar_Ex and GUIScrollbars_Size](https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/) built by Melba23.



<!--more-->


# How to install AGS-wrapper-scrollbars ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/). To install this package you can use the dependencies manager for AutoIt provides in AGS. So just type in the root folder of your project where the `package.json` is stored:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-scrollbars --modules-folder vendor</code>
</pre>


All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. To use it in your AutoIt program, you need to include with this instruction :

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/GUIScrollBars_Ex.au3'
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/GUIScrollBars_Size.au3'
```

All AGS packages hosted in this npmjs repository belong to the organization [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). Indeed in order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository.


# Scrollbars

## Introduction

**GUIScrollbars_Ex.au3** - This gives you scrollbars sized to your GUI in one simple command - with no other includes or commands needed. The UDF is designed for those who would not normally use scrollbars because the whole process looks too complicated. It also includes a command to enable you to scroll page by page, thus making it easy to scroll to anywhere on the GUI with only simple calulations based on the values you used to create the GUIs. It have ability to have recalculated scrollbars on resizeable GUIs.

**GUIScrollbars_Size.au3** - This calculates the Page and Max numbers for the user to feed into the _GUIScrollbar_SetScrollInfoPage/Max commands. The UDF is aimed at the more experienced user and is particularly useful when you have a GUI with a dynamic scroll size (i.e. adding or subtracting controls to the scrollable area as the script runs).

> Source from Melba23's notes : [https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/](https://www.autoitscript.com/forum/topic/113723-scrollbars-made-easy-bugfix-version-2-may-21/)

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

### Another examples 

See more [examples](https://github.com/autoit-gui-skeleton/ags-wrapper-scrollbars/tree/master/Examples) in git repository.


<br/>

> **Continue reading ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
