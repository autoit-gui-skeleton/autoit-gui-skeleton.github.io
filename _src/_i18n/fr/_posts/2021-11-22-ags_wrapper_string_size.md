---
layout: post
title: Calculer la taille requise par une chaîne de caractères pour l'inserer dans un label avec <b>AGS-wrapper-string-size</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---


> Pour calculer la taille ; largeur et hauteur ; requise par une chaine de caractères, AGS fournit le *wrapper* [@autoit-gui-skeleton/ags-wrapper-string-size](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-string-size) de la librairie [StringSize.au3](https://www.autoitscript.com/forum/topic/114034-stringsize-m23-new-version-16-aug-11/)



<!--more-->


# Comment installer AGS-wrapper-string-size ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-wrapper-json, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké :

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-string-size --modules-folder vendor</code>
</pre>

Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. Pour l'utiliser dans son programme AutoIt, vous devez inclure cette bibliothèque avec l'instruction :

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/StringSize.au3'
```

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.


# StringSize

## Introduction

La bibliothèque StringSize prend une chaîne de texte et calcule la taille de l'étiquette requise pour la contenir, ainsi que la mise en forme de la chaîne pour qu'elle s'adapte.

## Exemples

### Simple usage

```autoit
Local $stringSize = _StringSize($text, $fontsize, $fontweight, $fontattribute, $fontfamily, $GUI_width - $marginLeftRight*2)

If(Not @error) Then
      $label_TEXT_reformated = $stringSize[0]
      $label_WIDTH_calculated = $stringSize[2] ; ($stringSize[2] / $dpi)
      $label_HEIGHT_calculated = $stringSize[3] ; ($stringSize[3] / $dpi)
    
      GUISetFont($fontsize, $fontweight, $fontattribute, $fontfamily)
      GUICtrlSetData($label_ID, $label_TEXT_reformated)
      GUICtrlSetPos($label_ID, $marginLeftRight, $top, $label_WIDTH_calculated, $label_HEIGHT_calculated)
EndIf
```

### Reformaté une string dans un label 

```autoit
#include <GUIConstantsEx.au3>
#include "StringSize.au3"

$sText = " I am a very long line and I am not formatted in any way so that I will not fit within the width of the GUI that surrounds me!"

$hGUI = GUICreate("Test", 500, 500)

; A label with no width or height set
GUICtrlCreateLabel($sText, 10, 10)
GUICtrlSetBkColor(-1, 0xFF8080)

; A label with no height set
GUICtrlCreateLabel($sText, 10, 50, 200)
GUICtrlSetBkColor(-1, 0xC0C0FF)

; A label sized by StringSize
$aSize = _StringSize($sText, Default, Default, Default, "", 200)
GUICtrlCreateLabel($aSize[0], 10, 90, $aSize[2], $aSize[3])
GUICtrlSetBkColor(-1, 0x80FF80)

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd
```

### Calcul de la plus grande taille de police possible pour une largeur de label donné

```autoit
#include <GUIConstantsEx.au3>

#include "StringSize.au3"

; Declare arrays to hold parameters
Global $aFont[4] = ["Arial", "Tahoma", "Courier New", "Comic Sans MS"]
Global $aWeight[4] = [200, 400, 600, 800]
Global $aAttrib[4] = [0, 2, 4, 0]
Global $aColour[4] = [0xFFFFD0, 0xD0FFD0, 0xD0D0FF, 0xFFD0FF]

$sText = "The UDF will calculate the largest possible font size which will allow this text to fit in the randomly sized label.  " & _
    "Pressing the 'Increase' button will use the next size up so you can see how successful it was.  " & @CRLF & _
    "Note that the UDF is pessimistic and will leave small borders to the right and at the bottom of the text, so you might " & _
    "be able to go one size up in a few cases, although this risks clipping the trailing edges of italic letters or the tails of letters such as 'g'."

$hGUI = GUICreate("Test", 500, 500, 100, 100)

$hButton_Next = GUICtrlCreateButton("Next", 10, 10, 80, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$hLabel_Size = GUICtrlCreateLabel("", 100, 10, 40, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetFont(-1, 24)

$hButton_Increase = GUICtrlCreateButton("Increase", 150, 10, 80, 30)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

GUISetState()

While 1

    ; Choose parameter values

    $iX = 10 * Random(25, 50, 1)
    $iY = 10 * Random(10, 40, 1)
    $sFont = $aFont[Random(0, 3, 1)]
    $iWeight = $aWeight[Random(0, 3, 1)]
    $iAttrib = $aAttrib[Random(0, 3, 1)]
    $iColour = $aColour[Random(0, 3, 1)]

    WinMove($hGUI, "", 100, 100, $iX + 26, $iY + 85)
    $hLabel = GUICtrlCreateLabel("", 10, 50, $iX, $iY)
    GUICtrlSetBkColor(-1, $iColour)

    For $iSize = 5 To 50
        $aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
    If $aSize[3] > $iY Then
            $iSize -= 1
            ExitLoop
        EndIf
    Next

    GUICtrlSetData($hLabel_Size, $iSize)
    GUICtrlSetFont($hLabel, $iSize, $iWeight, $iAttrib, $sFont)
    $aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
    GUICtrlSetData($hLabel, $aSize[0])

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
            Case $hButton_Next
                GUICtrlDelete($hLabel)
                GUICtrlSetData($hLabel_Size, "")
                ExitLoop
            Case $hButton_Increase
                GUICtrlSetData($hLabel, "")
                $iSize += 1
                GUICtrlSetData($hLabel_Size, $iSize)
                GUICtrlSetFont($hLabel, $iSize, $iWeight, $iAttrib, $sFont)
                $aSize = _StringSize($sText, $iSize, $iWeight, $iAttrib, $sFont, $iX)
                GUICtrlSetData($hLabel, $aSize[0])
        EndSwitch
    WEnd

WEnd
```


<br/>

> **Continue Continue la lecture ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)

