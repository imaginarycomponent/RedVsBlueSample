
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using {/Fortnite.com/Playspaces}
using {/Fortnite.com/Characters}
using {/Fortnite.com/Game}
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
timed_granter_device := class(creative_device):
    @editable ItemGranterDevice : item_granter_device = item_granter_device{}
    @editable TimerDevice : timer_device = timer_device{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # TODO: Replace this with your code
        TimerDevice.SuccessEvent.Subscribe(TimerDeviceFinish)
        return

    TimerDeviceFinish(AgentIn : ?agent ): void=
        TimerDevice.Reset()
        TimerDevice.Start()
        GrantCoinsToAllPlayers()
    
    GrantCoinsToAllPlayers() : void =
        WorldPlayers := GetAllAgents()
        for(Agent : WorldPlayers):
            GrantCoins(Agent)

    GetAllAgents<public>()<transacts>:[]agent={
        return Self.GetPlayspace().GetPlayers()
    } 

    GrantCoins(AgentIn : agent) : void=
        # var DefeatingAgent : agent = agent[AIInteractionResultIn.Source]
        ItemGranterDevice.GrantItem(AgentIn)

    