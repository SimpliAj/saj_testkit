# saj_testkit

## Requirements:
 - ox_lib

## Optional Integrations:
- emfan-2step
- core_vehicle
- rahe_boosting_system
- saj_tuev
- okok_notify

## Description:
The saj_testkit script is compatible with ESX versions up to 1.7.5. When the "testkit" item is used, it opens a menu that allows the player to perform various checks on a nearby vehicle.

## Available Checks:
 - __Illegal Tuning:__ Identify unauthorized vehicle modifications.
 - __VIN Check:__ Verify the vehicle's identification number.
 - __2step Kit Check:__ Inspect the presence and functionality of a 2step kit.
 - __TÜV (Vehicle Registration):__ Check the registration status of the vehicle (requires integration with saj_tuev).

## Configuration:
The script is highly customizable through the `config.lua` file:

__Disable Unused Integrations:__ Easily toggle off optional features you don't require.
__Notification System:__ Choose between the ESX default notification system or OKOK Notify for alerts or add your own notify system!
