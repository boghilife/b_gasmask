Config = {}

/* RESOURCE GENERAL */

-- Rytrak scba resource name, change the name only if you have changed the default one
Config.resourcename = 'r_scba'

-- Debug in the console (fore testing purpose) 
Config.debug = true

-- Use or not the gas mask in interiors
Config.disableInteriorUse = true

/* CLOTHE RELATED */

-- This is the default component id for the masks, change it if you have a different one (es. hats)
-- See the components list here: https://docs.fivem.net/natives/?_0x262B14F48D29DE80
Config.maskcomponent = 1

-- These are the ids of the the masks to utilise in the game, there are no limits
Config.gasmasks = {
    216,
    217
}

/* NOTIFY & TEXT RELATED */

-- Display or not the text
Config.displaytext = true

-- Default position: bottom-center
-- Es. postion 
Config.textposition = {
    x = 0.50,
    y = 0.95
}

-- The font of the text
Config.textfont = 2

-- Setup your notify system or disable it
-- Available options: default, esx, false (for disabling)
Config.notify = 'default'

-- The prefix for the notifies
Config.notifyprefix = ''

/* LANGUAGE */

-- Used language, based on the locales below
Config.language = 'it' 

-- Locales for the languages, you can esily add/change your language below
Config.locales = {
    en = {
        gasmask_active_text = 'Gas mask ~g~Active',
        gasmask_interior_text = 'Gas mask ~r~Unactive',
        gasmask_on_notify = 'Gas mask on',
        gasmask_off_notify = 'Gas mask off',
        scba_error_notify = 'You can\'t use the scba with the mask!'
    },
    it = {
        gasmask_active_text = 'Maschera anti gas ~b~~g~Attiva',
        gasmask_interior_text = 'Gas mask ~r~Unactive',
        gasmask_on_notify = 'Maschera attiva',
        gasmask_off_notify = 'Maschera non attiva',
        scba_error_notify = 'Non puoi usare l\'SCBA con la maschera!'
    }
    -- Add more languages here
}

/* FUNCTION FOR LOCALES - DO NOT TOUCH! */
function Config.getLocale(key)
    return Config.locales[Config.language][key] or key
end

