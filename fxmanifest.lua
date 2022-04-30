fx_version 'cerulean'

games { 'gta5' }

client_scripts {
    'src/RageUI.lua',
    'src/Menu.lua',
    'src/MenuController.lua',
    'src/components/*.lua',
    'src/elements/*.lua',
    'src/items/*.lua',
    'client/Weed.lua',
}

shared_script {
    'shared/config.lua',
}

server_script {
    'server/server.lua',
}
