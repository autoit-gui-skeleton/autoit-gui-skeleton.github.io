---
layout: post
title: Check for updates into an AutoIt application with <b>AGS-component-check-for-updates</b>
tags: [AGS, Component]
feature-img: "assets/img/pixabay/ags-component.jpg"
thumbnail: "assets/img/pixabay/ags-component.jpg"
excerpt_separator: <!--more-->
---


> AGS provides the component [@autoit-gui-skeleton/ags-component-check-for-updates](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-check-for-updates) in order to add the feature to check for updates to an AutoIt application 





<!--more-->


# How to install AGS-component-check-for-updates ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/), and to install this package AGS-component-http-request, you can use the dependencies manager for AutoIt provides in AGS. So just type in the root folder of your project where the `package.json` is stored:

<pre class="command-line" data-prompt="C: \>">
<code class=" language-bash">yarn add @autoit-gui-skeleton/ags-component-check-for-updates --modules-folder vendor</code>
</pre>

All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. 

All AGS packages hosted in this npmjs repository belong to the organization [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton). Indeed in order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository.



# How to use AGS-component-check-for-updates ?

## Description

With AGS-component-check-for-updates, you can create an AutoIt application with a feature to check its own updates. It then provides a link to download the latest version of the installer, and another link to the release notes.

![ags-component-check-for-updates :: update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-update-available.png)

To work, it compares the local version of the application installed on the user's PC with the repository of the published versions of the application. This repository is a json file, `RELEASES.json`, which is therefore hosted on a remote server. So we need to connect to the Internet to send an HTTP request to retrieve this file, and we need a JSON parse. This component therefore depends on other AGS components: ags-wrapper-json and ags-component-http-request. If you want to simulate different scenarios ofcheck for updates, you just need to change the value of the application version set in `./src/GLOBALS.au3`.

The remote file `RELEASES.json` looks like this:

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



## Example of an application that implements AGS-component-check-for-updates

Take a look of this example [ApplicationWithCheckForUpdates](https://github.com/autoit-gui-skeleton/AGS-component-check-for-updates/tree/master/example/ApplicationWithCheckForUpdates). This application has interesting features:

 - Check update on startup AutoIt application ;
 - Check update from the menu "? > Check for update" ;
 - Change settings application from the view "Configuration > Settings". Values are persisted into the configuration file ./config/parameters.ini. In this view, we can set proxy parameters to specify how this application try to connect to internet.
 
If the option for checking the update of the application at each start is enabled, and if a new version of this application is available, then when the user starts the application, he gives this information in a window child. 
 

## Available methods

This library provides few methods:

 Methods    | Description 
---------------|-------------
`json_decode_from_file($filePath)` | Decode JSON from a given local file.
`json_decode_from_url($jsonfileUrl, $proxy = "")` | Decode JSON from a given URL.
`RELEASES_JSON_get_all_versions($jsonObject)` | Parse all defined version(s) persisted in a decoded RELEASES.json file given.
`RELEASES_JSON_get_last_version($jsonObject)` | Get last version persisted in RELEASES.json
`CheckForUpdates($currentApplicationVersion, $remoteUrlReleasesJson, $proxy = "")` | Compare the current version with the last version persisted in an remote RELEASES.json file, in order to check if an update is available.
`_GUI_launch_CheckForUpdates($main_GUI, $context)` | Launch a check for updates. The build of a GUI exposing the results depends on the context when the check for update is launch : with an user interaction from menu or on startup application. We store the option to search update on starup in the configuration file `./config/parameters.ini` in parameter `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP`.
`_GUI_build_view_to_CheckForUpdates($main_GUI, $resultCheckForUpdate, $context = "")` | Create a child GUI use to expose the result of a check updater. It exposes if an update of current application is available. The child GUI is related to a given main GUI of application. If this method is execute on startup, we built this child GUI only if an update is available. And when this method is called by a user interaction, we built this child GUI in any case : no update available, new update or experimental.



## Configure the component AGS-component-check-for-updates

### Create configuration file `./config/parameters.ini`

With AGS, you must have the configuration file `./config/parameters.ini`. This file must not save with control version. You can use `./config/parameters.ini.dist` as a "template" of what your parameters.ini file should look like. Set parameters here that may be different on each application. Only this file is save with control version and push on remote server.

To configure the behavior of this component, you can set its options in this configuration file. You can enable or disable the search of a new update when the application starts, with the `LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP` variable of the section `AGS_CHECK_FOR_UPDATES`.

```ini
[AGS_CHECK_FOR_UPDATES]
; [REQUIRED] Enable/disable the search of a new update on start-up.
LAUNCH_CHECK_FOR_UPDATE_ON_STARTUP=1
```

In this component we use an another component [AGS-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request). This library is used to send HTTP request in GET or POST method, and with or wihtout behind a corporate proxy, in order to get the remote `RELEASES.json`. So you can also configure this component. For example, you can set a proxy for all HTTP connections, or set different types of timeouts. By default, this component looks in the configuration file if a proxy is defined in the `PROXY` variable in the `AGS_HTTP_REQUEST` section.

```ini
[AGS_HTTP_REQUEST]
; [OPTIONAL] Use a proxy for http connexion or choose NONE to disable it
# PROXY=NONE
PROXY=http://myProxy.com:20100
```

### Set constants in `./src/GLOBALS.au3`

All constants and global variables are set in one place `./src/GLOBALS.au3`, with the exception to global variables of graphic elements which are set in each specific view file. AGS-component-check-for-udpates use the constant `$APP_REMOTE_RELEASES_JSON` to specifiy where the repository `RELEASES.json` is hosted. 

This json file must be persisted in a remote server available via internet, and without restriction. For example, you can use Github to host this file, like this:

```autoit
Global Const $APP_REMOTE_RELEASES_JSON = "https://raw.githubusercontent.com/autoit-gui-skeleton/AGS-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/RELEASES.json"
```


### How to perform a check-for-updates on startup ?

In the `_main_GUI()` method of the main manager of graphic user interface `./src/GUI.au3`, it just add a call to the  method `_GUI_launch_CheckForUpdates` like this.

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


### How to perform a check-for-updates from an item menu ?

Into the `GUI_Init_Menu` method, we add a new menu item for check-for-udpates.

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

And we handle events clicks on menu about like this:

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


### user can change the settings directly in the application 

You can create a view into application in order to change settings. All values are persisted into the configuration file `./config/parameters.ini`. In this view, we can set proxy parameters to specify how this application try to connect to internet and if the application searchs an update on startup.

![AGS-component-check-for-updates :: view settings application](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-view-settings.png)

When the user click on save button, it uses the service `./src/services/ParametersIni.au3`, which call `IniWrite` method on configuration file `./config/parameters.ini` to persist values.

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

And the source code of the manager of the "Settings" view.

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


### How to test differents case with the check-for-updates

In this example of remote RELEASES.json, we set two releases like this:

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

If you want to simulate different scenarios on check updater, you just need to change the value of the application version set in `./src/GLOBALS.au3`. For example to simulate the case of:

 - new version available set it to : `Global Const $APP_VERSION = "0.9.0"` <br/><br/>![ags-component-check-for-updates :: update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-update-available.png)<br/><br/>
 
 - application have not update available : `Global Const $APP_VERSION = "1.0.0"` <br/><br/> ![AGS-component-check-for-updates :: no update available](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-no-update-available.png)<br/><br/>
 
 - application is experimental: `Global Const $APP_VERSION = "1.1.0"` <br/><br/>
 ![AGS-component-check-for-updates :: experimental version](https://raw.githubusercontent.com/autoit-gui-skeleton/ags-component-check-for-updates/master/example/ApplicationWithCheckForUpdates/docs/AGS-component-check-for-updates-experimental.png)<br/><br/>




<br/>

> **Continue reading ?**
>
> [Dependencies manager for AutoIt]({{ site.url }}{{ site.baseurl }}/documentation/getting-started#dependencies-manager-for-autoit)
