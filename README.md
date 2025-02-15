## Police Services Script for QBCore Framework

This script adds a "Citizen Services" feature to the police job in your server. It allows officers to manage citizen services, such as checking if a citizen's services are active, deactivating, or reactivating them. The menu options are presented through either qb-menu or ox_lib, depending on your configuration.

## Features:
1. Check Services: Check if a citizen's services are active or inactive.
2. Deactivate Services: Deactivate a specific citizen's services.
3. eactivate Services: Reactivate a citizen's services.
4. Menu Options: Offers a user-friendly menu interface to perform actions.
5. Notifications: Notify the officer of the results of their actions (via qb-core or ox_lib notifications).


# Requirements:
QBCore Framework

1. qb-menu `(if using Config.menu == "qb")`
2. ox_lib `(if using Config.menu == "ox")`
3. qb-input `(for input dialogs)`
4. animations `(for emote animations)`

# Installation:
Place the script in your server:

1. Copy the entire script into your server’s resource folder.
2. Makz sure the resource is included in your server.cfg by adding:
3. start police-services

# Ensure dependencies are installed:

1. Make sure you have qb-core, qb-menu (or ox_lib), and qb-input installed.
2. Install ox_lib if you plan to use it by following the installation instructions from the ox_lib GitHub.

# Configuration:

1. Open the config.lua file in the script and set the Config.Job to the job name that should be able to use the service (e.g., police).
2. Choose which menu system you want to use by setting Config.menu to either "qb" for qb-menu or "ox" for ox_lib.

# Emote Animation:

Ensure the animations resource is installed to allow for emote animations. This is used when interacting with the service menu (for example, taking out a notepad).

# Commands:
1. `/playerservices`: Opens the police services menu if the player is in the configured job (default: police).

# Events:

1. `police:client:playerservices`: Opens the menu with options to manage citizen services.
2. `police:client:manageservices`: Used to deactivate or reactivate a specific citizen's services.
3. `police:client:checkservices`: Used to check if a citizen's services are active or inactive.

# Example Usage:

Opening the Menu:

1. Type `/playerservices` in the chat (only available to players with the correct job).

2. The officer will be presented with a menu that includes options like "Check Services", "Deactivate Services", and "Reactivate Services".

# Deactivating or Reactivating Services:

1. Choose the "Deactivate Services" or "Reactivate Services" option from the menu.
2. Enter the citizen ID when prompted.
3. The system will check if the service is already in the desired state and provide feedback.
4. If the citizen's services are successfully changed, a notification will be sent to the officer confirming the action.

# Notifications:

Notifications will appear based on the action taken, with success or error messages indicating if the service was deactivated/reactivated or already in the correct state.


# Configuration:

Config.Job = "police" 

Config.menu = "qb" -- [ "qb" qb-menu or "ox" ox_lib menu ]

# Customization:

1. You can customize the icons used in the menus (via FontAwesome icons).
2. You can change the job name in the configuration to match your server’s roles (e.g., sheriff, police).
3. The notification system can be switched between qb-core and ox-lib.
