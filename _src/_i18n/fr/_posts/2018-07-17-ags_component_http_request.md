---
layout: post
title: Envoyer une requête HTTP en AutoIt avec <b>AGS-component-http-request</b>
tags: [AGS, Component]
feature-img: "assets/img/pixabay/ags-component.jpg"
thumbnail: "assets/img/pixabay/ags-component.jpg"
excerpt_separator: <!--more-->
---


> Pour envoyer des requêtes HTTP, AGS fournit ce composant [@autoit-gui-skeleton/ags-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request). Cette librairie nous permet d'envoyer des requêtes HTTP en GET ou en POST, et avec ou sans un proxy. 



<!--more-->


# Comment installer AGS-component-http-request ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-component-http-request, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-http-request --modules-folder vendor</code>
</pre>

Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. Pour l'utiliser dans son programme AutoIt, vous devez inclure cette bibliothèque avec l'instruction: 

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-component-http-request/ags-component-http-request.au3'
```

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.



# Comment utiliser AGS-component-http-request ? 

## Méthodes disponibles 
    
Cette bibliothèque fournit plusieurs méthodes pour traiter les requêtes HTTP

 Methods    | Description 
---------------|-------------
`HttpGET($url, $data = "", $proxy = "")` | Send HTTP request with GET method.
`HttpPOST($url, $data = "", $proxy = "")` | Send HTTP request with POST method.
`URLEncode($urlText)` | URL encoding replaces unsafe ASCII characters.  
`URLDecode($urlText)` | Inverse operation of URLEncode.
`WinHttp_SetProxy_from_configuration_file($oHttp)` | Set timeouts by parsing the configuration file AGS project store in './config/parameters.ini'.
`WinHttp_SetProxy_from_configuration_file($oHttp)` | Set proxy by parsing the configuration file AGS project store in './config/parameters.ini'.


## Configurer le composant AGS-component-http-request

Pour configurer le comportement de ce composant, vous pouvez définir ses options dans le fichier `./config/parameters.ini`. Par exemple, vous pouvez définir un proxy pour toute les connexions HTTP, ou encore définir différents types de délai d'attente. Par défaut, ce composant recherche dans le fichier de configuration si un proxy est défini dans la variable `PROXY` de la section` AGS_HTTP_REQUEST`.

```ini
## ./config/parameters.ini ##

[AGS_HTTP_REQUEST]
; [OPTIONAL] Use a proxy for http connexion. Keep empty to disable it.
PROXY=http:/myproxy.com:20100

; [OPTIONAL] Time-out value applied when resolving a host name to an @IP,
; in miliseconds.
RESOLVE_TIMEOUT=1000

; [OPTIONAL] Time-out value applied when establishing a communication socket
; with the target server, in milliseconds.
CONNECT_TIMEOUT=1000

; [OPTIONAL] Time-out value applied when sending an individual packet of request
; data on the communication socket to the target server, in milliseconds. A
; large request sent to an HTTP server are normally be broken up into multiple
; packets. The send time-out applies to sending each packet individually.
SEND_TIMEOUT=1000

; [OPTIONAL] Time-out value applied when receiving a packet of response data
; from the target server, in milliseconds. Large responses are be broken up into
; multiple packets; the receive time-out applies to fetching each packet of data
; off the socket.
RECEIVE_TIMEOUT=1000
```


## Comment envoyer une requête HTTP en GET ?

```autoit
Local $response = HttpGET("https://soundcloud.com/2080/my-megadrive")
    
ConsoleWrite($response.Status & @CRLF)
ConsoleWrite($response.ResponseText)
```


### Comment envoyer une requête HTTP avec un proxy ?

Par défaut, ce composant recherche dans le fichier de configuration si un proxy est défini dans la variable `PROXY` de la section` AGS_HTTP_REQUEST`. Mais vous pouvez également fournir un proxy explicitement dans la méthode.

```autoit
Local $response = HttpGET( _ 
    "https://soundcloud.com/2080/my-megadrive", _ 
    default, _ 
    "http://myproxy.com:20100")
    
ConsoleWrite($response.Status & @CRLF)
ConsoleWrite($response.ResponseText)
```


### Comment encoder une URL ?

Le codage d'URL (URL encoding) est un mécanisme d'encodage d'informations dans un URI (Uniform Resource Identifier). Il est utilisé dans la préparation des données du type de support application/x-www-form-urlencoded, et lors de la soumission de données dans les requêtes HTTP. 

Si vous utilisez HttpGET, vous devez nettoyer les données à envoyer avec cet méthode au préalable.

```autoit
Local $msg = "Welcome in AGS"
Local $url = "https://myServer.org/foo?msg=" & URLEncode($msg) & "&param=32"

ConsoleWrite($url)
; Output >> https://myServer.org/foo?msg=Welcome%20in%20AGS&param=32

ConsoleWrite(URLEncode("123abc!@#$%^&*()_+ ") & @crlf)
; Output >> 123abc!%40%23%24%25%5E%26*()_%2B%20
```




<br/>

> **Continue reading ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
