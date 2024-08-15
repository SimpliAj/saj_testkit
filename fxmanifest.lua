fx_version 'adamant'
game 'gta5'

description 'Custom Vehicle Testkit'

author 'SimpliAj'
version '1.0.0'

shared_script {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',  -- Falls du MySQL verwendest
    'server.lua'
}

dependencies {
    'es_extended',
    'progressbar'
}
