---
layout: post
title: Ajouter des actions pour AutoIt (Run, Compile, Syntax check...) dans Jetbrains 
tags: [AutoIt]
feature-img: "assets/img/post/autoit-compile.jpg"
thumbnail: "assets/img/post/autoit-compile.jpg"
excerpt_separator: <!--more-->
---


> Procédure pour ajouter des actions AutoIt (Compile, Run, Syntax Check...) dans Jetbrains.

<!--more-->


# Ajouter une action AutoIt dans l'IDE Jetbrains

1. Ouvrir `File > Settings > Tools > External Tools` ;
![AutoIt Actions Jetbrains]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/autoit-external-tools-jetbrains.png){:class="img-full img-fancybox"}<br/><br/>


2. Ajouter l'action `Run` de la manière suivante : 
   - Ecrire `AutoIt` dans Group ;
   - Ecrire `Run` dans Name ;
   - Ecrire `C:\Program Files (x86)\AutoIt3\AutoIt3.exe` dans Program ;
   - Ecrire `/ErrorStdOut "$FilePath$"` dans Arguments ;<br/><br/>
   

3. Ajouter l'action `Compile` de la manière suivante :
    - Ecrire `AutoIt` dans Group ;
    - Ecrire `Compile` dans Name ;
    - Ecrire `C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe` dans Program ;
    - Ecrire `/in "$FilePath$"` dans Arguments ;<br/><br/>


4. Ajouter l'action `Syntax check` de la manière suivante :
    - Ecrire `AutoIt` dans Group ;
    - Ecrire `Syntax check` dans Name ;
    - Ecrire `C:\Program Files (x86)\AutoIt3\Au3Check.exe` dans Program ;
    - Ecrire `-q "$FilePath$"` dans Arguments ; <br/><br/>


5. Et voila ! ![AutoIt Actions in Jetbrains]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/autoit-actions-jetbrains.png){:class="img-full img-fancybox"}

