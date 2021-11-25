---
layout: post
title: Use curl to make HTTP request with <b>AGS-wrapper-curl</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---


> AGS provides the *wrapper* [@autoit-gui-skeleton/ags-wrapper-curl](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-curl) for the library [Curl](https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/) built by Ward.



<!--more-->


# How to install AGS-wrapper-curl ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/). To install this package you can use the dependencies manager for AutoIt provides in AGS. So just type in the root folder of your project where the `package.json` is stored:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-curl --modules-folder vendor</code>
</pre>


All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. To use it in your AutoIt program, you need to include with this instruction :

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-string-size/Curl.au3'
```

All AGS packages hosted in this npmjs repository belong to the organization [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). Indeed in order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository.


## Curl Ward library

### Introduction

This library provides an implementation of libcurl with SSL support. It's built with another Ward library [BinaryCall](https://www.autoitscript.com/forum/topic/162366-binarycall-udf-write-subroutines-in-c-call-in-autoit/), and it provides this features :

- Pure AutoIt script, no DLLs needed.
- Build with SSL/TLS and zlib support (without libidn, libiconv, libssh2).
- Full easy-interface and partial multi-interface support.
- Data can read from or write to autoit variables or files.
- Smaller code size (compare to most libcurl DLL).

The version information of this build:
- Curl Version: libcurl/7.42.1
- SSL Version: mbedTLS/1.3.10
- Libz Version: 1.2.8
- Protocols: ftp,ftps,http,https

Here are the helper functions (not include in libcurl library).

    Curl_DataWriteCallback()
    Curl_DataReadCallback()
    Curl_FileWriteCallback()
    Curl_FileReadCallback()
    Curl_Data_Put()
    Curl_Data_Get()
    Curl_Data_Cleanup()

> Source from Ward's post : [https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/](https://www.autoitscript.com/forum/topic/173067-curl-udf-autoit-binary-code-version-of-libcurl-with-ssl-support/)

### Examples

#### Get HTTP header and content from google

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


#### Deals with proxy settings

By default, libcurl respects the proxy environment variables named `http_proxy`, `ftp_proxy`, `sftp_proxy` etc. If set, libcurl will use the specified proxy for that URL scheme. So for a "FTP://" URL, the ftp_proxy is considered. all_proxy is used if no protocol specific proxy was set. If `no_proxy` is set, it is the exact equivalent of setting the CURLOPT_NOPROXY option. But if you want to ovveride envrionnement variables, it's possible with the `$CURLOPT_PROXY` and `CURLOPT_NOPROXY` options.

To set a proxy, use :

```
Curl_Easy_Setopt($Curl, $CURLOPT_PROXY, 'https://myProxy.com:8080');
```

To disable default proxy configuration, use :

```autoit
Curl_Easy_Setopt($Curl, $CURLOPT_PROXY, '');
```

#### Make request with multi interface for non-GUI blocking

The multi interface provides in libcurl offers several abilities that the easy interface (default mode use in libcurl) does not. They are mainly:

1. Enable a "pull" interface. The application that uses libcurl decides where and when to ask libcurl to get/send data.

2. Enable multiple simultaneous transfers in the same thread without making it complicated for the application.

3. Enable the application to wait for action on its own file descriptors and curl's file descriptors simultaneously.

4. Enable event-based handling and scaling transfers up to and beyond thousands of parallel connections.

> See more : [https://curl.se/libcurl/c/libcurl-multi.html](https://curl.se/libcurl/c/libcurl-multi.html)


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

#### Another examples 

See more [examples](https://github.com/autoit-gui-skeleton/ags-wrapper-curl/tree/master/Examples) in git repository.
