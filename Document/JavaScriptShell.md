# jsh: The JavaScript shell

## Copyright
Copyright (C) 2026 [Steel Wheels Project](https://github.com/steel-wheels/Project/blob/main/README.md).
The software for `jsh` and `JSH Terminal` are distributed under  [GNU General Public License version 2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html.en). 
And the documentations for `jsh` nd `JSH Terminal` are distributed under [GNU Free Documentation License](https://www.gnu.org/licenses/fdl-1.3.html.en#license-text).

## Software 
* `jsh`: JavaScript shell command line application.
* `JSH Terminal`: The terminal application to run the `jsh`.

## Introduction
The syntax of `jsh` shell script is based on the JavaScript. The script is translated into JavaScript and executed by the JavaScriptCore egine.

### Script mode
The `jsh` has script mode. The mode has 2 status: `shell mode` and `script mode`. 

#### Swith the mode
The default mode is `script mode`.

This is the example of shell mode. You can execute the shell commands.
<pre>
% ls
Desktop		Downloads	Movies		Pictures	tmp
Documents	Library		Music		SystemData
%   
</pre>

### `jshrc`file
The `jshrc` (run command filr for jsh) contains the JavaScript to setup `jsh` at the boot timing.

#### The location of `jshrc` file
* for macOS
* for iOS

## Related documents
* [Builtin commands](./BuiltinCommands.md): List of supported built-in commands and it's specification.
* [Environment variables](./EnvVariable.md): List of default environment variables.


