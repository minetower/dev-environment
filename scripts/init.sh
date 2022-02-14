#!/bin/bash

trap 'echo exit && exit' 2

# minimal list for build with docker
repos=('assets' 'packs' 'minecraft-tweaks' 'minetower.github.io')
optional_repos=('svelte-snowpack-template' 'ui-components')

needed_minecraft_tweaks=('assets' 'packs' 'minecraft-tweaks')
