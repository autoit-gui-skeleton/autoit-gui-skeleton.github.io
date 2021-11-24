---
layout: post
title: Vérifier les mises à jour dans une application AutoIt avec <b>AGS-component-check-for-updates</b>
tags: [AGS, Component]
feature-img: "assets/img/pixabay/ags-component.jpg"
thumbnail: "assets/img/pixabay/ags-component.jpg"
excerpt_separator: <!--more-->
---


> AGS fournit le composant [@autoit-gui-skeleton/ags-component-check-for-updates](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-check-for-updates) afin d'ajouter la fonctionnalité pour vérifier les mises à jour dans une application AutoIt. 


<!--more-->


# Comment installer AGS-component-check-for-updates ?

On suppose que vous avez déjà installé [Node.js](https://nodejs.org/) et [Yarn](https://yarnpkg.com/lang/en/), par example avec [Chocolatey](https://chocolatey.org/), et pour installer le package AGS-component-check-for-updatest, vous pouvez alors utiliser le gestionnaire de dépendances pour AutoIt fournit dans AGS. Il suffit donc de taper dans le dossier racine du projet, où le fichier `package.json` est stocké:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-check-for-updates --modules-folder vendor</code>
</pre>

Toutes les dépendances du projet, ainsi que les dépendances filles des dépedances parentes sont installées dans le répertoire `./vendor/@autoit-gui-skeleton/`. 

Tous les paquets AGS hébergés dans le dépôt npmjs appartiennent à l'organisation [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). En effet afin de simplifier la gestion des dépendances d'un projet AutoIt construit avec le framework AGS, nous avons détourné de son utilisation initiale le gestionnaire de dépendance npm, et son évolution Yarn. Cela nous permet de gérer les dépendances d'un projet AGS avec d'autres bibliothèques AutoIt, et de partager ces paquets AutoIt à partir du référentiel npmjs.org.




# Comment utilsier AGS-component-check-for-updates ?

## Description

Avec AGS-component-check-for-updates, vous pouvez créer une application AutoIt disposant d'une fonctionnalité pour vérifier ses propres mises à jour. Il fournit alors un lien pour télécharger la dernière version de l'installeur, et un autre lien vers les notes de versions.

![ags-component-check-for-updates :: update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-update-available.png)

Pour fonctionner, il compare la version locale de l'application installée sur le PC de l'utilisateur avec le référentiel des versions publiées de l'application. Ce référentiel est un fichier json, `RELEASES.json`, qui est hébergé sur un serveur distant. Nous devons donc nous connecter à Internet pour envoyer une requête HTTP pour récupérer ce fichier, et nous avons besoin d'une analyse JSON. Ce composant dépend donc des autres composants AGS: ags-wrapper-json et ags-component-http-request. Si vous souhaitez simuler différents scénarios de vérification des mises à jour, il vous suffit de modifier la valeur de l'ensemble des versions de l'application dans `./src/GLOBALS.au3`.

Le fichier distant `RELEASES.json` ressemble à ceci:

```json
{
  "name": "ApplicationWithCheckForUpdates",
  "description": "Example to implementation of AGS-component-check-for-updates",
  "license": "MIT",
  "homepage": "https://autoit-gui-skeleton.github.io",
  "releases": [
    {
      "version": "1.0.0",
      "state": "stable",
      "downloadSetup": "https://myApplication.com/v1.0.0/setup_myApplication_v1.0.0.exe",
      "published": "2018-10-07",
      "releaseNotes": "https://myApplication.com/v1.0.0/README.md"
    },
    {
      "version": "0.1.0",
      "state": "prototype",
      "downloadSetup": "undefined",
      "published": "2014-03-21",
      "releaseNotes": "undefined"
    }
  ]
}
```
 


## Exemple d'une application qui implémente AGS-component-check-for-updates

Jetez un oeil à cet exemple [ApplicationWithCheckForUpdates](https://github.com/autoit-gui-skeleton/AGS-component-check-for-updates/tree/master/example/ApplicationWithCheckForUpdates). Cette application a des caractéristiques intéressantes :

 - Vérifier la mise à jour au démarrage de l'application AutoIt;
 - Vérifier la mise à jour depuis le menu "?> Vérifier la mise à jour";
 - Modifierles paramètres de l'application à partir de la vue "Configuration> Paramètres". Les valeurs sont conservées dans le fichier de configuration `./config/parameters.ini`. Dans cette vue, nous pouvons définir des paramètres proxy pour spécifier comment cette application essaie de se connecter à Internet.

Si l'option de vérification de recherche de mise à jour de l'application à chaque démarrage est activée, et si une nouvelle version de cette application est disponible, alors lorsque l'utilisateur démarre l'application, il donne cette information dans une fenêtre enfant.




## Méthodes disponibles 

Cette bibliothèque fournit plusieurs méthodes

 Methods    | Description 
---------------|-------------
`json_decode_from_file($filePath)` | Decode JSON from a given local file.
`json_decode_from_url($jsonfileUrl, $proxy = "")` | Decode JSON from a given URL.
`RELEASES_JSON_get_all_versions($jsonObject)` | Parse all defined version(s) persisted in a decoded RELEASES.json file given.
`RELEASES_JSON_get_last_version($jsonObject)` | Get last version persisted in RELEASES.json
`CheckForUpdates($currentApplicationVersion, $remoteUrlReleasesJson, $proxy = "")` | Compare the current version with the last version persisted in an remote RELEASES.json file, in order to check if an update is available.
`_GUI_launch_CheckForUpdates($main_GUI, $context)` | Launch a check for updates. The build of a GUI exposing the results depends on the context when the check for update is launch : with an user interaction from menu or on startup application. We store the option to search update on starup in the configuration file `./config/parameters.ini` in parameter `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP`.
`_GUI_build_view_to_CheckForUpdates($main_GUI, $resultCheckForUpdate, $context = "")` | Create a child GUI use to expose the result of a check updater. It exposes if an update of current application is available. The child GUI is related to a given main GUI of application. If this method is execute on startup, we built this child GUI only if an update is available. And when this method is called by a user interaction, we built this child GUI in any case : no update available, new update or experimental.



## Configurer le composant AGS-component-check-for-updates

### Création du fichier de configuration `./config/parameters.ini`

Avec AGS vous devez avoir un fichier de configuration `./config/parameters.ini`. Ce fichier ne doit pas être sauvegarder avec le contrôle de version. Vous pouvez utiliser `./config/parameters.ini.dist` comme un 'template' de ce à quoi devrait ressembler votre fichier parameters.ini. Définissez les paramètres ici qui peuvent être différents sur chaque application.

Pour configurer le comportement de ce composant, vous pouvez définir ses options dans ce fichier de configuration. Vous pouvez activer ou désactiver la recherche d'une nouvelle mise à jour lorsque l'application démarre, avec la variable `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP` de la section `AGS_CHECK_FOR_UPDATES`.

```ini
[AGS_CHECK_FOR_UPDATES]
; [REQUIRED] Enable/disable the search of a new update on start-up.
LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP=1
```

Dans ce composant, on utilise un autre composant [AGS-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request). Cette bibliothèque est utilisée pour envoyer une requête HTTP avec la méthode GET ou POST, et avec ou sans un proxy, afin d'obtenir le fichier distant `RELEASES.json`. Vous pouvez donc également configurer ce composant. Par exemple, vous pouvez définir un proxy pour toutes les connexions HTTP ou définir différents types de délais. Par défaut, ce composant recherche dans le fichier de configuration si un proxy est défini dans la variable `PROXY` de la section` AGS_HTTP_REQUEST`.

```ini
[AGS_HTTP_REQUEST]
; [OPTIONAL] Use a proxy for http connexion or choose NONE to disable it
# PROXY=NONE
PROXY=http://myProxy.com:20100
```

### Définir les constantes dans `./src/GLOBALS.au3`

Toutes les constantes et les variables globales sont définies à un seul endroit `./src/GLOBALS.au3`, à l'exception des variables globales des éléments graphiques qui sont définies dans chaque fichier de vue spécifique. AGS-component-check-for-udpates utilise la constante `$APP_REMOTE_RELEASES_JSON` pour spécifier où le référentiel` RELEASES.json` est hébergé.

Ce fichier json doit être sauvegarder dans un serveur distant disponible via internet, et sans restriction. Par exemple, vous pouvez utiliser Github pour héberger ce fichier, comme ceci:

```autoit
Global Const $APP_REMOTE_RELEASES_JSON = "https://raw.githubusercontent.com/autoit-gui-skeleton/AGS-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/RELEASES.json"
```


### Comment effectuer une recherche de mise à jour au démarrage ? 

Dans la méthode `_main_GUI()` du manager principal de l'interface utilisateur `./src/GUI.au3`, il suffit d'ajouter un appel à la méthode `_GUI_launch_CheckForUpdates` comme ceci.

```autoit
;; ./src/GUI.au3 ;;

Func _main_GUI()
	Global $main_GUI = GUICreate($APP_NAME, $APP_WIDTH, $APP_HEIGHT, -1, -1)

	_GUI_Init_Menu()
	_GUI_Init_Footer()
	_GUI_Init_View_Welcome()
	_GUI_Init_View_About()
	_GUI_Init_View_Settings()

	; Set configuration application : icon, background color
	_GUI_Configuration()

	; Show Welcome view on startup
	_GUI_ShowHide_View_Welcome($GUI_SHOW)
	GUISetState(@SW_SHOW)

	; Launch a check for updates on startup, the check is performed 
	; only if LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP is enable in
	; the configuration file './config/parameters.ini'
	_GUI_launch_CheckForUpdates($main_GUI, "ON_STARTUP")

	; Handle all user interactions and events
	_GUI_HandleEvents()

	GUIDelete()
	Exit
EndFunc
```


### Comment effectuer une recherche de mise à jour depuis un élement du menu ? 

Dans la méthode `GUI_Init_Menu`, on ajoute un nouvel item pour vérifier les mises à jour. 

```autoit
;; ./src/GUI.au3 ;;

Func _GUI_Init_Menu()

    (...)
    
	; Création 'About' menu
	Global $menu_About = GUICtrlCreateMenu("?")
	Global $menuitem_Help = GUICtrlCreateMenuItem("Help", $menu_About)
	Global $menuitem_CheckForUpdate = GUICtrlCreateMenuItem("Check for update", $menu_About)
EndFunc
```

Et on traite les évenements de clics sur le menu "About" comme ceci.

```autoit
;; ./src/GUI.au3 ;;

Func _GUI_HandleEvents_Menu_About($msg)
	Switch $msg
		Case $menuitem_Help
			ConsoleWrite('Click on "? > Help"' & @CRLF)
		
		Case $menuitem_CheckForUpdate
			_GUI_launch_CheckForUpdates($main_GUI, "ON_MENU")
EndFunc
```


### L'utilisateur peut modifier les paramètres directement dans l'application

Vous pouvez créer une vue dans l'application afin de modifier ses paramètres. Toutes les valeurs sont conservées dans le fichier de configuration `./config/parameters.ini`. Dans cette vue, nous pouvons définir des paramètres proxy pour spécifier comment cette application essaie de se connecter à Internet et si l'application recherche une mise à jour au démarrage.  

![AGS-component-check-for-updates :: view settings application](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-view-settings.png)

Lorsque l'utilisateur clique sur le bouton Enregistrer, il utilise le service `./src/services/ParametersIni.au3`, qui appelle la méthode` IniWrite` sur le fichier de configuration `./config/parameters.ini` pour sauvegarder les changements.

```autoit
;====================================================================================
; Save values choose by user in 'Setting' views, and launch with 'save' button
;
; @params void
; @return void
;====================================================================================
Func _save_parameters_ini()
	; Save proxy settings
	IniWrite($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "PROXY", GUICtrlRead($input_HTTP_Proxy))
	IniWrite($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "RESOLVE_TIMEOUT", GUICtrlRead($input_HTTP_Resolve_Timeout))
	IniWrite($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "CONNECT_TIMEOUT", GUICtrlRead($input_HTTP_Connect_Timeout))
	IniWrite($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "SEND_TIMEOUT", GUICtrlRead($input_HTTP_Send_Timeout))
	IniWrite($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "RECEIVE_TIMEOUT", GUICtrlRead($input_HTTP_Receive_Timeout))

	; Startup settings
	If (GUICtrlRead($checkbox_STARTUP_CHECK_UPDATE) = $GUI_CHECKED) Then
		IniWrite($APP_PARAMETERS_INI, "AGS_CHECK_FOR_UPDATES", "LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP", "1")
	Else
		IniWrite($APP_PARAMETERS_INI, "AGS_CHECK_FOR_UPDATES", "LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP", "0")
	EndIf
EndFunc
```

Et le code source du gestionnaire de la vue "Settings"

```autoit
;; ./src/views/View_Settings.au3 ;;

#include-once

;====================================================================================
; Create element for the 'Settings' view
;
; @param void
; @return void
;====================================================================================
Func _GUI_Init_View_Settings()
	GUISetFont(20, 800, 0, "Arial Narrow")
	Global $label_title_settings = GUICtrlCreateLabel("Settings", 20, 30, 400)
	GUICtrlSetColor($label_title_settings, 0x85C4ED)
	GUICtrlSetBkColor($label_title_settings, $GUI_BKCOLOR_TRANSPARENT)

	Local $height = 120
	Local $heightStep = 30
	Local $margin_top = 50

	; Proxy settings
	GUISetFont(9, 800, 0, "Arial")
	Local $height_group_proxy_settings = (5 * $heightStep) + 30
	Global $group_proxy_settings = GUICtrlCreateGroup(" Proxy ", 30, $height - 30, ($APP_WIDTH - 60), $height_group_proxy_settings)
	GUISetFont(9, 400, 0, "Arial")
	Local $PROXY = IniRead($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "PROXY", "")
	Local $RESOLVE_TIMEOUT = Int(IniRead($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "RESOLVE_TIMEOUT", 0))
	Local $CONNECT_TIMEOUT = Int(IniRead($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "CONNECT_TIMEOUT", 60000))
	Local $SEND_TIMEOUT = Int(IniRead($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "SEND_TIMEOUT", 30000))
	Local $RECEIVE_TIMEOUT = Int(IniRead($APP_PARAMETERS_INI, "AGS_HTTP_REQUEST", "RECEIVE_TIMEOUT", 30000))
	Global $label_HTTP_Proxy = GUICtrlCreateLabel("HTTP / HTTPS Proxy", 50, $height)
	Global $input_HTTP_Proxy = GUICtrlCreateInput($PROXY, 200, $height - 2, 400, 20)
	Global $label_HTTP_Resolve_Timeout = GUICtrlCreateLabel("Timeout for HTTP resolve", 50, $height + $heightStep)
	Global $input_HTTP_Resolve_Timeout = GUICtrlCreateInput($RESOLVE_TIMEOUT, 200, $height + $heightStep - 2, 100, 20)
	Global $label_HTTP_Connect_Timeout = GUICtrlCreateLabel("Timeout for HTTP connect", 50, $height + 2 * $heightStep)
	Global $input_HTTP_Connect_Timeout = GUICtrlCreateInput($CONNECT_TIMEOUT, 200, $height + 2 * $heightStep - 2, 100, 20)
	Global $label_HTTP_Send_Timeout = GUICtrlCreateLabel("Timeout for HTTP send", 50, $height + 3 * $heightStep)
	Global $input_HTTP_Send_Timeout = GUICtrlCreateInput($SEND_TIMEOUT, 200, $height + 3 * $heightStep - 2, 100, 20)
	Global $label_HTTP_Receive_Timeout = GUICtrlCreateLabel("Timeout for HTTP receive", 50, $height + 4 * $heightStep)
	Global $input_HTTP_Receive_Timeout = GUICtrlCreateInput($RECEIVE_TIMEOUT, 200, $height + 4 * $heightStep - 2, 100, 20)
	GUICtrlCreateGroup("", -1, -1, 1, 1)

	; Startup settings
	$height = $height + $height_group_proxy_settings
	GUISetFont(9, 800, 0, "Arial")
	Global $group_startup_settings = GUICtrlCreateGroup(" Start-up ", 30, $height, ($APP_WIDTH - 60), (1 * $heightStep) + 30)
	GUISetFont(9, 400, 0, "Arial")
	Global $checkbox_STARTUP_CHECK_UPDATE = GUICtrlCreateCheckbox( _
			"Search update on application startup ?", _
			50, $height + $heightStep, Default, 20, $BS_RIGHTBUTTON _
			)
	Local $LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP = Int(IniRead($APP_PARAMETERS_INI, "AGS_CHECK_FOR_UPDATES", "LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP", "NotFound"))
	If ($LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP = 1) Then
		GUICtrlSetState($checkbox_STARTUP_CHECK_UPDATE, $GUI_CHECKED)
	Else
		GUICtrlSetState($checkbox_STARTUP_CHECK_UPDATE, $GUI_UNCHECKED)
	EndIf
	GUICtrlCreateGroup("", -1, -1, 1, 1)

	Global $button_save_settings = GUICtrlCreateButton("Save", ($APP_WIDTH - 150) / 2, $APP_HEIGHT - 100, 150)

	; Setter of tips and cursors
	_GUI_SetCursorAndTip_View_Settings()

	; Hide all elements by default
	_GUI_ShowHide_View_Settings($GUI_HIDE)
EndFunc


;====================================================================================
; Setter tips and cursor for elements in 'Settings' view
;
; @param void
; @return void
;====================================================================================
Func _GUI_SetCursorAndTip_View_Settings()
	GUICtrlSetCursor($label_HTTP_Proxy, 4)
	GUICtrlSetTip($label_HTTP_Proxy, @CRLF & "Configuration of proxy to allow internet connection" & @CRLF & @CRLF & "Example : http(s):\\myProxy.com:8080", "HTTP/HTTPS Proxy", 1)

	GUICtrlSetCursor($checkbox_STARTUP_CHECK_UPDATE, 4)
	GUICtrlSetTip($checkbox_STARTUP_CHECK_UPDATE, @CRLF & "To allow the search of an update of the application at each start." & @CRLF & "This search requires an internet connection, and therefore" & @CRLF & "potenially need a configuration of a proxy.", "Check for update on start-up", 1)

	GUICtrlSetCursor($button_save_settings, 0)
EndFunc


;====================================================================================
; Handler for display element on 'Settings' view
;
; @param {int} $action, use GUIConstantsEx $GUI_SHOW or $GUI_HIDE
; @return void
;====================================================================================
Func _GUI_ShowHide_View_Settings($action)
	Switch $action
		Case $GUI_SHOW
			_GUI_Hide_all_view()
			; Define here all elements to show when user come into this view
			GUICtrlSetState($label_title_settings, $GUI_SHOW)
			GUICtrlSetState($group_proxy_settings, $GUI_SHOW)
			GUICtrlSetState($label_HTTP_Proxy, $GUI_SHOW)
			GUICtrlSetState($input_HTTP_Proxy, $GUI_SHOW)
			GUICtrlSetState($label_HTTP_Resolve_Timeout, $GUI_SHOW)
			GUICtrlSetState($input_HTTP_Resolve_Timeout, $GUI_SHOW)
			GUICtrlSetState($label_HTTP_Connect_Timeout, $GUI_SHOW)
			GUICtrlSetState($input_HTTP_Connect_Timeout, $GUI_SHOW)
			GUICtrlSetState($label_HTTP_Send_Timeout, $GUI_SHOW)
			GUICtrlSetState($input_HTTP_Send_Timeout, $GUI_SHOW)
			GUICtrlSetState($label_HTTP_Receive_Timeout, $GUI_SHOW)
			GUICtrlSetState($input_HTTP_Receive_Timeout, $GUI_SHOW)
			GUICtrlSetState($group_startup_settings, $GUI_SHOW)
			GUICtrlSetState($checkbox_STARTUP_CHECK_UPDATE, $GUI_SHOW)
			GUICtrlSetState($button_save_settings, $GUI_SHOW)

		Case $GUI_HIDE
			; Define here all elements to hide when user leave this view
			GUICtrlSetState($label_title_settings, $GUI_HIDE)
			GUICtrlSetState($group_proxy_settings, $GUI_HIDE)
			GUICtrlSetState($label_HTTP_Proxy, $GUI_HIDE)
			GUICtrlSetState($input_HTTP_Proxy, $GUI_HIDE)
			GUICtrlSetState($label_HTTP_Resolve_Timeout, $GUI_HIDE)
			GUICtrlSetState($input_HTTP_Resolve_Timeout, $GUI_HIDE)
			GUICtrlSetState($label_HTTP_Connect_Timeout, $GUI_HIDE)
			GUICtrlSetState($input_HTTP_Connect_Timeout, $GUI_HIDE)
			GUICtrlSetState($label_HTTP_Send_Timeout, $GUI_HIDE)
			GUICtrlSetState($input_HTTP_Send_Timeout, $GUI_HIDE)
			GUICtrlSetState($label_HTTP_Receive_Timeout, $GUI_HIDE)
			GUICtrlSetState($input_HTTP_Receive_Timeout, $GUI_HIDE)
			GUICtrlSetState($group_startup_settings, $GUI_HIDE)
			GUICtrlSetState($checkbox_STARTUP_CHECK_UPDATE, $GUI_HIDE)
			GUICtrlSetState($button_save_settings, $GUI_HIDE)

	EndSwitch
EndFunc


;====================================================================================
; Handler for events in 'Settings' view
;
; @param $msg, event return with GUIGetMsg method, i.e. the control ID of the control sending the message
; @return @void
;====================================================================================
Func _GUI_HandleEvents_View_Settings($msg)
	Switch $msg
		Case $button_save_settings
			ConsoleWrite('Click on "$button_save_settings"' & @CRLF)
			_save_parameters_ini()
	EndSwitch
EndFunc
```


### Comment tester les différents cas de recherche de mise à jour ?

Dans cet example, nous avons défini deux versions comme ceci:

```json
{
  "name": "ApplicationWithCheckForUpdates",
  "description": "Example to implementation of AGS-component-check-for-updates",
  "license": "MIT",
  "homepage": "https://autoit-gui-skeleton.github.io",
  "releases": [
    {
      "version": "1.0.0",
      "state": "stable",
      "downloadSetup": "https://myApplication.com/v1.0.0/setup_myApplication_v1.0.0.exe",
      "published": "2018-10-07",
      "releaseNotes": "https://myApplication.com/v1.0.0/README.md"
    },
    {
      "version": "0.9.0",
      "state": "prototype",
      "downloadSetup": "undefined",
      "published": "2014-03-21",
      "releaseNotes": "undefined"
    }
  ]
}
```

Si vous voulez simuler différents scénarios sur la recherche de mise à jour de chèques, il vous suffit de changer la valeur de la version de l'application définie dans `./src/GLOBALS.au3`. Par exemple pour simuler le cas de:

 - une nouvelle version disponbile, changer la valeur pour : `Global Const $APP_VERSION = "0.9.0"` <br/><br/>![ags-component-check-for-updates :: update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-update-available.png)<br/><br/>
 
 - il n'y a pas de nouvelle version disponible : `Global Const $APP_VERSION = "1.0.0"` <br/><br/> ![AGS-component-check-for-updates :: no update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-no-update-available.png)<br/><br/>
 
 - vous utilisez une version experimental : `Global Const $APP_VERSION = "1.1.0"` <br/><br/>
 ![AGS-component-check-for-updates :: experimental version](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-experimental.png)<br/><br/>




<br/>

> **Continue la lecture ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
