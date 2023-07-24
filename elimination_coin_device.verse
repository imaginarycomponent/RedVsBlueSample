
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
elimination_coin_device := class(creative_device):
    @editable TeamSettingsAndInventoryDevices : []team_settings_and_inventory_device = array{}
    @editable ItemGranterDevice : item_granter_device = item_granter_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        for(CurrentElement : TeamSettingsAndInventoryDevices):
            CurrentElement.EnemyEliminatedEvent.Subscribe(Grant_Coins)        
        return

    Grant_Coins(AgentIn : agent) : void=
        # var DefeatingAgent : agent = agent[AIInteractionResultIn.Source]
        ItemGranterDevice.GrantItem(AgentIn)