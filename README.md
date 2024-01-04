# FiveM-luacheck-config
A set of config files for using [luacheck](https://github.com/mpeterv/luacheck) with FiveM lua scripts.

I created this with the intent of using it for lua resource validation using GitHub Actions, or another workflow equivalent. Feel free to copy & modify the config files for use in your projects.

# Files
All files include globals that are commonly used & provided by the FiveM lua environment. These were obtained through some of the repositories by [Cfx.re](https://github.com/citizenfx) such as [natives](https://github.com/citizenfx/natives/).

These files cannot make luacheck truly replicate the FiveM environment, and they do not attempt to do so, so be mindful that they are not aware of run order or global declarations across files. Additionally, FiveM's lua environment introduces features outside of the standard language like `joaat()` shorthand and the `+=` operator.

## errors.luacheck
This config ignores all warnings provided by luacheck ([List of warnings](https://luacheck.readthedocs.io/en/stable/warnings.html)). The reason being is that luacheck has a non-zero exit code when warnings are found - this is problematic for workflows / actions that check the return status of commands. Otherwise, you may not have correct action indications.

## full.luacheck
This config includes all warnings (except for 631 - *Line is too long.* as an example) but will likely cause action indications to show failures when warnings are encountered. Warnings are helpful and should be read, so there is utility to running this instead of the other version.

# Output
To illustrate, the output from using these config files with the example.lua should resemble the following:

- Control output
```
> luacheck .
Checking example.lua                              4 warnings

    example.lua:2:1: accessing undefined variable 'RegisterNetEvent'
    example.lua:3:17: accessing undefined variable 'source'
    example.lua:4:1: line contains only whitespace
    example.lua:5:5: accessing undefined variable 'TriggerClientEvent'

Total: 4 warnings / 0 errors in 1 file
```

- Full output
```
> luacheck . --config full.luacheck
Checking example.lua                              1 warning

    example.lua:4:1: line contains only whitespace

Total: 1 warning / 0 errors in 1 file
```

- Errors only output
```
> luacheck . --config errors.luacheck
Checking example.lua                              OK

Total: 0 warnings / 0 errors in 1 file
```
