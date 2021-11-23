---
layout: post
title: Send HTTP request in AutoIt with <b>AGS-component-http-request</b>
tags: [AGS, Component]
feature-img: "assets/img/pixabay/ags-component.jpg"
thumbnail: "assets/img/pixabay/ags-component.jpg"
excerpt_separator: <!--more-->
---


> In order to send HTTP request, AGS provides this component [@autoit-gui-skeleton/ags-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request). This library is used to send HTTP request in GET or POST method, and with or wihtout behind a corporate proxy.


<!--more-->


# How to install AGS-component-http-request ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/), and to install this package AGS-component-http-request, you can use the dependencies manager for AutoIt provides in AGS. So just type in the root folder of your project where the `package.json` is stored:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-http-request --modules-folder vendor</code>
</pre>


All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. To use it in your AutoIt program, you need to include this library with this instruction:

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-component-http-request/ags-component-http-request.au3'
```

All AGS packages hosted in this npmjs repository belong to the organization [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). Indeed in order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository.


# How to use AGS-component-http-request ? 

## Available methods 
    
This library provides severals methods to deal with HTTP requests.

 Methods    | Description 
---------------|-------------
`HttpGET($url, $data = "", $proxy = "")` | Send HTTP request with GET method.
`HttpPOST($url, $data = "", $proxy = "")` | Send HTTP request with POST method.
`URLEncode($urlText)` | URL encoding replaces unsafe ASCII characters.  
`URLDecode($urlText)` | Inverse operation of URLEncode.
`WinHttp_SetProxy_from_configuration_file($oHttp)` | Set timeouts by parsing the configuration file AGS project store in './config/parameters.ini'.
`WinHttp_SetProxy_from_configuration_file($oHttp)` | Set proxy by parsing the configuration file AGS project store in './config/parameters.ini'.


## Configure the AGS-component-http-request component

To configure the behavior of this component, you can set its options in the `./config/parameters.ini` file. For example, you can set a proxy for all HTTP connections, or set different types of timeouts. By default, this component looks in the configuration file if a proxy is defined in the `PROXY` variable in the `AGS_HTTP_REQUEST` section.

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


## How to send HTTP request by using GET method ?

```autoit
Local $response = HttpGET("https://soundcloud.com/2080/my-megadrive")
    
ConsoleWrite($response.Status & @CRLF)
ConsoleWrite($response.ResponseText)
```


## How to send HTTP request behind a corporate proxy ?

By default this component search in the configuration file `./config/parameters.ini` if a proxy is defined in the `PROXY` variable of the section `AGS_HTTP_REQUEST`. But you can also provide a proxy directly in the method.

```autoit
Local $response = HttpGET( _ 
    "https://soundcloud.com/2080/my-megadrive", _ 
    default, _ 
    "http://myproxy.com:20100")
    
ConsoleWrite($response.Status & @CRLF)
ConsoleWrite($response.ResponseText)
```


## How to URL encode a string ?

URL encoding is a mechanism for encoding information in a Uniform Resource Identifier (URI). It is used in the preparation of data of the application/x-www-form-urlencoded media type, and in the submission of HTML form data in HTTP requests.

If you use HttpGET, you must clean the data to be sent with this method in advance. 

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
