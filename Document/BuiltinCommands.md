# Builtin commands
This documentation descrived about the built-in commands of `jsh`.

* [`run`](#runc): Execute the JavaScript program
* [`whitch`](#whitch) : Print the location of given commmand

## Commands

### `run`

Execute the JavaScript program. You can pass the path of the script file to be executed. If you dont give the path, the dialog is used to select the script file.

#### Syntax
<pre>
run [file-path]
</pre>

The <code>file-path</code> argument must be the path of the JavaScript file. The file extension must be "<code>.js</code>". If the <code>file-path</code> is not given, the dialog to select the JavaScript file will be opened.

### `which`
Print the location of given command.

## Related documents
* [jsh](./JavaScriptShell.md): The main document for `jsh`.

