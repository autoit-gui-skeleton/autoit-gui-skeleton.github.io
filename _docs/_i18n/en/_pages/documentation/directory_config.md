### Directory `config`

An AGS project must have a configuration file `./config/parameters.ini`. 

Be aware, this file is not save with control version, so to create a new configuration file you can use `./config/parameters.ini.dist` as a "template" of what your parameters.ini file should look like. Set parameters here that may be different on each application. To use parameters we have a constant `$APP_PARAMETERS_INI`, wich contains the full path to it. It's defined in `./src/GLOBALS.au3`, and when the application start-up, AGS checks that the configuration file parameters.ini exist.

#### How to read the value of a parameter ?

For a string value of variable `LAST_OPEN_FILE` persist in the ini section `[APPLICATION]`, we use:

```autoit
Local $LAST_OPEN_FILE = IniRead( _ 
    $APP_PARAMETERS_INI, "APPLICATION", "LAST_OPEN_FILE", "NotFound"
)
```

And for a integer value, we use:

```autoit
Local $IS_OPEN = Int(IniRead( _ 
    $APP_PARAMETERS_INI, "APPLICATION", "IS_OPEN", -1
)
```

#### How to change the value of a parameter ?

For example, if the value is provided from an input controller in GUI, we use in first the GUICtrlRead method to get its value. And finally we save its value into a parameter, with this instrcution :

```autoit
IniWrite( _
    $APP_PARAMETERS_INI, "APPLICATION", "LAST_OPEN_FILE", _
    GUICtrlRead($input_OPEN_FILE) _
)
```