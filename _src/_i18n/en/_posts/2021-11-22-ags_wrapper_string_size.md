---
layout: post
title: Calculates the size of label required for a given text string with <b>AGS-wrapper-string-size</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---


> StringSize takes a text string and calculates the size of label required to hold it as well as formatting the string to fit. AGS provides the *wrapper* [@autoit-gui-skeleton/ags-wrapper-string-size](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-string-size) from library of Melba23 [StringSize.au3](https://www.autoitscript.com/forum/topic/114034-stringsize-m23-new-version-16-aug-11/)



<!--more-->


# How to install AGS-wrapper-string-size ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/), and to install this package AGS-wrapper-json, you can use the dependencies manager for AutoIt provides in AGS. So just type in the root folder of your project where the `package.json` is stored:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-string-size --modules-folder vendor</code>
</pre>


All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. To use it in your AutoIt program, you need to include this library with this instruction:

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/StringSize.au3'
```

All AGS packages hosted in this npmjs repository belong to the organization [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). Indeed in order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository.


# StringSize

## Introduction

StringSize takes a text string and calculates the size of label required to hold it as well as formatting the string to fit.

Now AutoIt will, of course, size a label automatically to fit a text string, but it will not format the string in any way - what you use as the string is what you get in the label. If you do set any label sizes the text will be wrapped, but you can only determine the correct size of the label by trial and error.

StringSize will, however, reformat the string to fit in a given width and tell you the required height so that you can read it all - whatever the font type or size - and you do not have to do the formatting beforehand.

## Examples

### Simple usage

Here is a simple example to show how to use it :

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

### Reformat string in label

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

### Calculate the largest possible font size for a given label width

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

> **Continue reading ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
