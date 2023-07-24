
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
grant_coin_device := class(creative_device):
    @editable GuardSpawnerDevices : []guard_spawner_device = array{}
    @editable ItemGranterDevice : item_granter_device = item_granter_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        for(CurrentElement : GuardSpawnerDevices):
            CurrentElement.EliminatedEvent.Subscribe(Grant_Coins)        
        return

    Grant_Coins(AIInteractionResultIn : device_ai_interaction_result) : void=
        # var DefeatingAgent : agent = agent[AIInteractionResultIn.Source]
        if (DefeatingAgent := AIInteractionResultIn.Source?):
            ItemGranterDevice.GrantItem(DefeatingAgent)