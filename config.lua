Config = {}

-- Notify System ('okokNotify', 'mythic_notify', 'esx,' 'custom' add own in client/server.lua at bottom for custom)
Config.NotifySystem = 'okokNotify'

Config.UsableItem = 'prkit'

Config.MenuOptions = {
    exhaust = true,      -- requires emfan2 step
    illegal_tuning = true, -- requires core vehicles
    tuev = true,         -- requries saj_tuev
    vin = true            -- requires rahe boosting
}

-- Change Locales
Config.Locale = Config.Locales['de']

-- Lokalisierungen
Config.Locales = {
    ['de'] = {
        check_vehicle_exhaust = "Überprüfe bei dem Fahrzeug die Auspuffanlage",
        check_illegal_tuning = "Überprüfe das Fahrzeug nach Illegalen Tuning",
        check_tuev = "Überprüfe ob TÜV vorhanden ist",
        check_vin = "Überprüfe die VIN Nummer",
        menu_title = "PRÜFUNGSKIT",
        no_vehicle_found = "Kein Fahrzeug in der Nähe gefunden!",
        exhaust_ok = "Die Abgasanlage ist in Ordnung.",
        exhaust_modified = "Die Abgasanlage ist Modifiziert.",
        illegal_parts_found = "Es wurden Illegale Tuningteile gefunden: ",
        no_illegal_parts = "Das Fahrzeug hat keine illegalen Tuningteile verbaut",
        tuev_check = "Überprüfen",
        tuev_ausstellen = "Stelle TÜV für ein KFZ aus (ADAC)",
        tuev_entfernen = "Entferne den TÜV Status eines KFZ (ADAC)",
        vehicle_not_modified = 'Fahrzeug nicht modifiziert',
        vehicle_owned = 'Spieler besitzt das Fahrzeug',
        vehicle_not_owned = 'Spieler besitzt das Fahrzeug nicht',
        invalid_twostep_value = 'Ungültiger Wert für twostep in der Datenbank!',
        vehicle_not_found = 'Fahrzeug nicht in der Datenbank gefunden',
        illegal_parts_found = 'Illegale Teile gefunden: ',
        no_illegal_parts = 'Keine illegalen Teile gefunden'
    },
    ['en'] = {
        -- English translations (you can add more locales here)
    }
}

