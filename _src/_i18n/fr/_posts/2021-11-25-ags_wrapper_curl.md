---
layout: post
title: Utiliser curl pour faire des requêtes HTTP avec <b>AGS-wrapper-curl</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---

> AGS fournit le *wrapper* [@autoit-gui-skeleton/ags-wrapper-curl](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-curl) pour la librairie [Curl](https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/) construite par Ward.


<!--more-->


# Comment installer AGS-wrapper-scrollbars ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-wrapper-json, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké :

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-curl --modules-folder vendor</code>
</pre>


Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. Pour l'utiliser dans son programme AutoIt, vous devez inclure cette bibliothèque avec l'instruction :

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/Curl.au3'
```

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.


## Curl Ward library

### Introduction

Cette bibliothèque fournit une implémentation de libcurl avec le support SSL. Il est construit avec une autre bibliothèque Ward [BinaryCall](https://www.autoitscript.com/forum/topic/162366-binarycall-udf-write-subroutines-in-c-call-in-autoit/), et il offre les fonctionnalités suivantes :

- Aucune DLL supplémentaire nécessaire. Grâce à l'utilisation de la librairie BinaryCall.
- Avec support SSL/TLS et zlib (sans libidn, libiconv, libssh2).
- Prise en charge complète de l'interface curl easy-interface.
- Prise en charge partielle de l'interface curl multi-interface.
- Les données peuvent être lues ou écrites dans des variables ou des fichiers automatiques.
- Taille de la librairie plus petite, en comparaison à la plupart des DLL de libcurl.

Les informations de version de cette version :

- Version Curl : libcurl/7.42.1
- Version SSL : mbedTLS/1.3.10
- Version Libz : 1.2.8
- Protocoles : ftp, ftps, http, https

Voici les fonctions supplémentaires qui ne sont pas incluses dans la librairie libcurl.

    Curl_DataWriteCallback()
    Curl_DataReadCallback()
    Curl_FileWriteCallback()
    Curl_FileReadCallback()
    Curl_Data_Put()
    Curl_Data_Get()
    Curl_Data_Cleanup()

> Source Ward : [https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/](https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/)

### Exemples

#### Récupérer le HTTP header et son contenu 

```autoit
#Include "../Curl.au3"

; How to get html or header data?
;   1. Set $CURLOPT_WRITEFUNCTION and $CURLOPT_HEADERFUNCTION to Curl_DataWriteCallback()
;   2. Set $CURLOPT_WRITEDATA or $CURLOPT_HEADERDATA to any number as identify
;   3. Use Curl_Data_Get() to read the returned data in binary format
;   4. Use Curl_Data_Cleanup() to remove the data

Local $Curl = Curl_Easy_Init()
If Not $Curl Then Return

Local $Html = $Curl ; any number as identify
Local $Header = $Curl + 1 ; any number as identify

; Curl configuration
Curl_Easy_Setopt($Curl, $CURLOPT_URL, "https://www.google.com")
Curl_Easy_Setopt($Curl, $CURLOPT_USERAGENT, "AutoIt/Curl")
Curl_Easy_Setopt($Curl, $CURLOPT_FOLLOWLOCATION, 1)
Curl_Easy_Setopt($Curl, $CURLOPT_ACCEPT_ENCODING, "gzip") ; or set "" use all built-in supported encodings
Curl_Easy_Setopt($Curl, $CURLOPT_WRITEFUNCTION, Curl_DataWriteCallback())
Curl_Easy_Setopt($Curl, $CURLOPT_WRITEDATA, $Html)
Curl_Easy_Setopt($Curl, $CURLOPT_HEADERFUNCTION, Curl_DataWriteCallback())
Curl_Easy_Setopt($Curl, $CURLOPT_HEADERDATA, $Header)
Curl_Easy_Setopt($Curl, $CURLOPT_COOKIE, "tool=curl; script=autoit; fun=yes;")
Curl_Easy_Setopt($Curl, $CURLOPT_TIMEOUT, 30)
Curl_Easy_Setopt($Curl, $CURLOPT_SSL_VERIFYPEER, 0)

; Perform curl request
Local $Code = Curl_Easy_Perform($Curl)
If $Code = $CURLE_OK Then
	ConsoleWrite("Content Type: " & Curl_Easy_GetInfo($Curl, $CURLINFO_CONTENT_TYPE) & @LF)
	ConsoleWrite("Download Size: " & Curl_Easy_GetInfo($Curl, $CURLINFO_SIZE_DOWNLOAD) & @LF)

	MsgBox(0, 'Header', BinaryToString(Curl_Data_Get($Header)))
	MsgBox(0, 'Html', BinaryToString(Curl_Data_Get($Html)))
Else
	ConsoleWrite(Curl_Easy_StrError($Code) & @LF)
EndIf

Curl_Easy_Cleanup($Curl)
Curl_Data_Cleanup($Header)
Curl_Data_Cleanup($Html)
```


#### Utiliser curl avec un proxy

By default, libcurl respects the proxy environment variables named `http_proxy`, `ftp_proxy`, `sftp_proxy` etc. If set, libcurl will use the specified proxy for that URL scheme. So for a "FTP://" URL, the ftp_proxy is considered. all_proxy is used if no protocol specific proxy was set. If `no_proxy` is set, it is the exact equivalent of setting the CURLOPT_NOPROXY option. But if you want to ovveride envrionnement variables, it's possible with the `$CURLOPT_PROXY` and `CURLOPT_NOPROXY` options.

To set a proxy, use :

```
Curl_Easy_Setopt($Curl, $CURLOPT_PROXY, 'https://myProxy.com:8080');
```

To disable default proxy configuration, use :

```autoit
Curl_Easy_Setopt($Curl, $CURLOPT_PROXY, '');
```

#### Faire des requêtes HTTP avec multi interface pour ne pas freezer l'IHM

L'interface multi dans libcurl offre plusieurs capacités que l'interface par défaut (esay-interface) n'offre pas. Ce sont principalement :

1. Activez une interface "pull". L'application qui utilise libcurl décide où et quand demander à libcurl d'obtenir/envoyer des données.

2. Activez plusieurs transferts simultanés dans le même thread sans compliquer (freezer) la tâche de l'application.

3. Autorisez l'application à attendre une action sur ses propres descripteurs de fichier et les descripteurs de fichier de curl simultanément.

4. Activez la gestion basée sur les événements et la mise à l'échelle des transferts jusqu'à et au-delà de milliers de connexions parallèles.

> Plus d'informations : [https://curl.se/libcurl/c/libcurl-multi.html](https://curl.se/libcurl/c/libcurl-multi.html)


```autoit

Local $Curl = Curl_Easy_Init()
If Not $Curl Then Return

Curl_Easy_Setopt($Curl, $CURLOPT_URL, "http://www.google.com")
Curl_Easy_Setopt($Curl, $CURLOPT_USERAGENT, "AutoIt/Curl")
Curl_Easy_Setopt($Curl, $CURLOPT_FOLLOWLOCATION, 1)
Curl_Easy_Setopt($Curl, $CURLOPT_ACCEPT_ENCODING, "")
Curl_Easy_Setopt($Curl, $CURLOPT_WRITEFUNCTION, Curl_DataWriteCallback())
Curl_Easy_Setopt($Curl, $CURLOPT_WRITEDATA, $Curl)
Curl_Easy_Setopt($Curl, $CURLOPT_HEADERFUNCTION, Curl_DataWriteCallback())
Curl_Easy_Setopt($Curl, $CURLOPT_HEADERDATA, $Curl + 1)

Local $Multi = Curl_Multi_Init()
If Not $Multi Then Return
Curl_Multi_Add_Handle($Multi, $Curl)

Local $Running, $MsgsInQueue
Do
	Curl_Multi_Perform($Multi, $Running)
	Local $CURLMsg = Curl_Multi_Info_Read($Multi, $MsgsInQueue)
	If DllStructGetData($CURLMsg, "msg") = $CURLMSG_DONE Then
		Local $Curl = DllStructGetData($CURLMsg, "easy_handle")
		Local $Code = DllStructGetData($CURLMsg, "data")
		If $Code = $CURLE_OK Then
			ConsoleWrite("Content Type: " & Curl_Easy_GetInfo($Curl, $CURLINFO_CONTENT_TYPE) & @LF)
			ConsoleWrite("Download Size: " & Curl_Easy_GetInfo($Curl, $CURLINFO_SIZE_DOWNLOAD) & @LF)

			MsgBox(0, 'Header', BinaryToString(Curl_Data_Get($Curl + 1)))
			MsgBox(0, 'Html', BinaryToString(Curl_Data_Get($Curl)))
		Else
			ConsoleWrite(Curl_Easy_StrError($Code) & @LF)
		EndIf
		Curl_Multi_Remove_Handle($Multi, $Curl)
		Curl_Easy_Cleanup($Curl)
		Curl_Data_Cleanup($Curl)
		Curl_Data_Cleanup($Curl + 1)
	EndIf
	ConsoleWrite("non-GUI-blocking" & @LF)
	Sleep(10)
Until $Running = 0
Curl_Multi_Cleanup($Multi)
ConsoleWrite(@LF)
```

#### Autres examples 

Voir plus d'[examples](https://github.com/autoit-gui-skeleton/ags-wrapper-curl/tree/master/Examples) dans le dépôt git.
