---
layout: post
title: Adding AutoIt actions (Run, Compile, Syntax check...) in Jetbrains 
tags: [AutoIt]
feature-img: "assets/img/post/autoit-compile.jpg"
thumbnail: "assets/img/post/autoit-compile.jpg"
excerpt_separator: <!--more-->
---


> How to add AutoIt actions (Compile, Run, Syntax Check...) in Jetbrains.

<!--more-->


# Add AutoIt action in IDE Jetbrains

1. Open `File > Settings > Tools > External Tools` ;
![AutoIt Actions Jetbrains]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/autoit-external-tools-jetbrains.png){:class="img-full img-fancybox"}<br/><br/>

2. Add the `Run` action as follows : 
   - Write `AutoIt` into Group ;
   - Write `Run` into Name ;
   - Write `C:\Program Files (x86)\AutoIt3\AutoIt3.exe` into Program ;
   - Write `/ErrorStdOut "$FilePath$"` into Arguments ; <br/><br/>
   
    
3.  Add the `Compile` action as follows :
   - Write `AutoIt` into Group ;
   - Write `Compile` into Name ;
   - Write `C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe` into Program ;
   - Write `/in "$FilePath$"` into Arguments ; <br/><br/>


4. Add the `Syntax check` action as follows :
    - Write `AutoIt` into Group ;
    - Write `Syntax check` into Name ;
    - Write `C:\Program Files (x86)\AutoIt3\Au3Check.exe` into Program ;
    - Write `-q "$FilePath$"` into Arguments ; <br/><br/>


5. Et voila ! ![AutoIt Actions in Jetbrains]({{ site.url }}{{ site.baseurl_root }}/assets/img/post/autoit-actions-jetbrains.png){:class="img-full img-fancybox"}