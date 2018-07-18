---
layout: post
title: Utiliser des fichiers JSON dans AutoIt avec <b>AGS-wrapper-json</b>
tags: [AGS, Wrapper]
feature-img: "assets/img/pixabay/ags-wrapper.jpg"
thumbnail: "assets/img/pixabay/ags-wrapper.jpg"
excerpt_separator: <!--more-->
---

> Pour travailler avec des fichiers JSON, AGS fournit le *wrapper* [@autoit-gui-skeleton/ags-wrapper-json](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json) de la librairie JSON.au3, créé par Ward. Cette librairie nous permet de décoder / encoder en JSON en utilisant l'analyseur [jsmn](https://zserge.com/jsmn.html).

<!--more-->



# Comment installer AGS-wrapper-json ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-wrapper-json, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-wrapper-json --modules-folder vendor</code>
</pre>

Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. Pour l'utiliser dans son programme AutoIt, vous devez inclure cette bibliothèque avec l'instruction: 

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'
```

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.





# Comment décoder un JSON ?

## Décoder depuis un fichier JSON local 

Par exemple, crééz ce fichier json dans le répertoire `./assets/DROIDS.json` de votre projet AGS.

```json
{
  "project": "Listing droids",
  "version": "1.0",
  "author": {
    "name": "Luke",
    "mail": "luke@2080.org"
  },
  "droids": [
    {
      "name": "R2D2",
      "type": "Astromecano",
      "size": "0,96m"
    },
    {
      "name": "BB8",
      "type": "Astromecano",
      "size": "0,67m"
    },
    {
      "name": "C-3PO",
      "type": "Social",
      "size": "1,67m"
    }
  ]
}
```

Pour décoder ce fichier, on utilise la fonction suivante `json_decode_from_file`.

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'

;====================================================================================
; Decode JSON from a given local file
;
; @param $jsonfilePath (string)
; @return $object (object), instance return by json_decode
;====================================================================================
Func json_decode_from_file($filePath)
	Local $fileOpen, $fileContent, $object

	$fileOpen = FileOpen($filePath, $FO_READ)
	If $fileOpen = -1 Then
		Return SetError(1, 0, "An error occurred when reading the file " & $filePath)
	EndIf
	$fileContent = FileRead($fileOpen)
	FileClose($fileOpen)
	$object = Json_Decode($fileContent)

	Return $object
EndFunc
```

Selon la documentation de Ward:
 
> The most JSON data type will be decoded into corresponding AutoIt variable, including 1D array, string, number, true, false, and null. JSON object will be decoded into "Windows Scripting Dictionary Object" retuned from `ObjCreate("Scripting.Dictionary")`. AutoIt build-in functions like IsArray, IsBool, etc. can be used to check the returned data type. But for Object and Null, Json_IsObject() and Json_IsNull() should be used.

> If the input JSON string is invalid, `@Error` will be set to `$JSMN_ERROR_INVAL`. And if the input JSON string is not finish, `@Error` will be set to `$JSMN_ERROR_PART`.



## Obtenir la valeur à partir d'un objet JSON 

Pour utiliser `$jsonObject`, le retour de `json_decode_from_file`, vous pouvez utilsier la fonction `Json_Get`. Pour sélectionner une variable JSON, vous pouvez utiliser au choix la notation par point ou par crochet. 

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)

; With dot notation
Local $project = Json_Get($jsonObject, '.project')     ; Listing droids
Local $name = Json_Get($jsonObject, '.author.name')    ; Luke
Local $mail = Json_Get($jsonObject, '.author.mail')    ; luke@2080.org
local $test = Json_Get($jsonObject, '.droids[1].name') ; BB8

; With array notation
Local $project2 = Json_Get($jsonObject, '["project"]')
Local $name2 = Json_Get($jsonObject, '["author"]["name"]')
Local $mail2 = Json_Get($jsonObject, '["author"]["mail"]')
local $test2 = Json_Get($jsonObject, '["droids"][1]["name"]')
```

Vous pouvez également utiliser des fonctions d'aide, qui son des couches d'abtractions des  fonctions de `Scripting.Dictionary` COM object.

- Json_ObjCreate()
- Json_ObjPut(ByRef $Object, $Key, $Value)
- Json_ObjGet(ByRef $Object, $Key)
- Json_ObjDelete(ByRef $Object, $Key)
- Json_ObjExists(ByRef $Object, $Key)
- Json_ObjGetCount(ByRef $Object)
- Json_ObjGetKeys(ByRef $Object)
- Json_ObjClear(ByRef $Object)



## Travailler avec une collection d'objet et parcourir ses éléments


Pour itérer les valeurs d'un tableau json:

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)

; Check if exists an item droid into the collection `droids`
Local $droids = Json_Get($jsonObject, '.droids')
If UBound($droids) = 0 Then
    Return SetError(3, 0, "Array attribute 'droids' is empty.")
EndIf

; Iterate items collection to store values into an array 
Local $array[UBound($droids)][3]
For $i = 0 To UBound($droids) - 1 Step 1
    $array[$i][0] = Json_Get($jsonObject, '.droids' & '[' & $i & '].name')
    $array[$i][1] = Json_Get($jsonObject, '.droids' & '[' & $i & '].type')
    $array[$i][2] = Json_Get($jsonObject, '.droids' & '[' & $i & '].size')
Next
```


## Ajouter un objet dans un JSON

Vous pouvez le faire simplement avec la fonction `Json_Put`:

```àutoit
Local $Obj
Json_Put($Obj, ".foo", "foo")
Json_Put($Obj, ".bar[0]", "bar")
Json_Put($Obj, ".test[1].foo.bar[2].foo.bar", "Test")

Local $Test = Json_Get($Obj, '["test"][1]["foo"]["bar"][2]["foo"]["bar"]') ; "Test"
```


## Décoder un fichier JSON depuis un serveur distant 

Pour décoder un fichier JSON hébergé sur un serveur distant, ou qui se construit depuis un webservice ou encore à partir d'une API Rest, vous pouvez utiliser [@autoit-gui-skeleton/ags-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request) pour effectuer des requetes HTTP vers une URL donnée.

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-component-http-request/ags-component-http-request.au3'

;====================================================================================
; Decode JSON from a given URL
;
; @param $jsonfileUrl (string)
; @param $proxy (string), by default we load proxy settings form configuration file
; @return $object (object), instance return by json_decode
;====================================================================================
Func json_decode_from_url($jsonfileUrl, $proxy = "")
	Local $response = HttpGET($jsonfileUrl, Default, $proxy)
	If (@error) Then
		Return SetError(@error, $response, _ 
		    "Unable to get json file on server " & $jsonfileUrl & ".")
	EndIf
	Local $data = $response.ResponseText
	Local $object = json_decode($data)

	Return $object
EndFunc

Local $jsonObject = json_decode_from_url(https://api.spacexdata.com/v2/info)

Local $name = Json_Get($jsonObject, '.name')        ; SpaceX
Local $founder = Json_Get($jsonObject, '.founder')  ; Elon Musk
Local $founded = Json_Get($jsonObject, '.founded')  ; 2002
```


# Comment encoder un JSON ?

Selon la documentation de Ward's, vous pouvez utilsier `Json_Encode($Data, $Option = 0, $Indent = "\t", $ArraySep = ",\r\n", $ObjectSep = ",\r\n", $ColonSep = ": ")`.

> - `$Data` can be a string, number, bool, keyword : default or null, 1D array, or `Scripting.Dictionary` COM object.
> - Binary will be converted to string in UTF8 encoding.
> - Ptr will be converted to number
> - Other unsupported types like 2D array, dllstruct or object will be encoded into null.
> 
> `$Option` is bitmask consisting following constant:
> 
> - `$JSON_UNESCAPED_ASCII` ; Don't escape ascii charcters between chr(1) ~ chr(0x1f)
> - `$JSON_UNESCAPED_UNICODE` ; Encode multibyte Unicode characters literally
> - `$JSON_UNESCAPED_SLASHES` ; Don't escape /
> - `$JSON_HEX_TAG` ; All < and > are converted to \u003C and \u003E
> - `$JSON_HEX_AMP` ; All &amp;amp;amp;amp;s are converted to \u0026
> - `$JSON_HEX_APOS` ; All ' are converted to \u0027
> - `$JSON_HEX_QUOT` ; All " are converted to \u0022
> - `$JSON_PRETTY_PRINT` ; Use whitespace in returned data to format it
> - `$JSON_STRICT_PRINT` ; Make sure returned JSON string is RFC4627 compliant
> - `$JSON_UNQUOTED_STRING` ; Output unquoted string if possible (conflicting with $JSMN_STRICT_PRINT)

Par exemple pour encoder en JSON:

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)
Local $jsonEncoded = Json_Encode($jsonObject, $JSON_PRETTY_PRINT)

ConsoleWrite($jsonEncoded)
```

> Most encoding option have the same means like PHP's json_encode() function. When `$JSON_PRETTY_PRINT` is set, output format can be change by other 4 parameters : `($Indent, $ArraySep, $ObjectSep, $ColonSep)`. Because these 4 output format parameters will be checked inside `Jsmn_Encode()` function, returned string will be always accepted by `Jsmn_Decode()`. $JSON_UNQUOTED_STRING can be used to output unquoted string that also accetped by Jsmn_Decode(). `$JSON_STRICT_PRINT` is used to check output format setting and avoid non-standard JSON output. So this option is conflicting with `$JSON_UNQUOTED_STRING`.


<br/>

> **Continuer la lecture ?**
>
> [https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/)
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#gestion-de-dépendances-pour-autoit)
