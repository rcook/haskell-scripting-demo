# Haskell scripting demo

This repo demonstrates how to do more advanced forms of scripting with [Haskell Stack][haskell-stack] including sharing code in a common module. Stack scripting does not seem to support sharing modules natively, so this is my workaround. It's a bit of hack. We don't get to use the nice Stack shebang and embedded `stack script` commands.

Instead we have to do the following:

* Create a small Bash stub script, one per Haskell script
* Place common modules in one directory: these will be compiled on the fly by Stack
* Place script modules in a different directory: these will be run in interpreted mode by Stack and can reference the common modules

This should be mostly transparent to the user. The only weirdness is when the common modules are built for the first time or are modified: this will cause Stack to rebuild the package. Not intervention is required by the user, but the Stack/GHC build output will be written to the terminal. This could probably be suppressed, but this would risk obscuring any compiler errors etc.

## Examples

```bash
bin/hello-world
bin/goodbye
```

## Licence

[MIT License](LICENSE)

[haskell-stack]: https://haskellstack.org/
