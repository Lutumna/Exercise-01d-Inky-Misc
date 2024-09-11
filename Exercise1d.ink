/*
This is a comment block. It won't be read as an Ink story.
Comments are very useful for leaving ideas for story and functionalty

This exercise will demonstrate the following in the example video:
 - Varrying text via loops
 - Functions
 
 In the assignment:
 - A story with at least 6 knots
 - Vary some text via a loop
 - Create a function that serves as a timer. (This is shown in the video)
*/


VAR time = 0 //  0 Morning, 1 Noon, 2 Night
VAR health = 3
VAR ammo = 1
VAR weapon = ""
VAR fuses = 0
VAR e_cnt = 2
VAR acid_cerberus = 2
VAR fungal_minotaur = 1
VAR visor = 0

-> Preparation

-> split_path

=== Preparation ===
Before you lies a fork in the road. You decide which weapon to prepare.

*[Revolver] 
    ~ weapon = "Revolver" 
    -> split_path
*[Shotgun] 
    ~ weapon = "Shotgun" 
    -> split_path
*[Marksman Rifle] 
    ~ weapon = "Marksman Rifle" 
    -> split_path


== split_path ==
You must choose your path. The crypt is unkown territory and is pitch black. The badlands aren't as dark, but are known for the abominations that reside there. {not fuse_pickup:There is a fuse on the floor.}

Are you sure the {weapon} is the right decision?

You have {fuses} fuses

+ [Take the crypt] -> crypt
+ [Take the badlands] -> badlands
* [Pick up the fuse charge] -> fuse_pickup
+ [Go Back] -> Preparation

== crypt ==
You are in the crypt. It is very dark, you can't see anything.
* {fuses > 0} [Use fuse] -> crypt_lit
+ [Go Back] -> split_path
-> END

== badlands ==
You have {not chimera_loot:wandered into} {chimera_loot:returned to} the badlands... good luck... Its { advance_time() }
{weapon == "Revolver": A revolver in the badlands... old faithful.| }
+ [Go set up camp in the woods] -> camp_site
+ {camp_fuse_pickup} {not chimera_loot} [Go scavenging] -> deep_badlands
+ [Go Back] -> split_path
-> END

=== fuse_pickup ===
~ fuses = fuses + 1
You now have a fuse charge. It can provide a momentary burst of light.
* [Go Back] -> split_path
-> END

== crypt_lit ==
You send out a burst of light with your fuse it won't last very long. Suddenly, you see an ammo stash and an exit path!
* [Go for exit] -> Fight
* [Loot ammo] -> ammo_loot
-> END

=== ammo_loot ===
~ ammo = ammo + 1
You now have {ammo} shots. This will aid in putting down monsters.
* [Go Back] -> crypt_lit
-> END

=== Fight ===

As you go for the exit you see two mutants blocking the way choose which one to take out.
* {ammo > 1} [Acid Cerberus] -> AC_End
* {ammo > 0} [Fungal Minotaur] -> FM_End

== AC_End ==
~ health = health - fungal_minotaur
You barley escape with your life you have {health} health remaining.
->END

== FM_End ==
~ health = health - acid_cerberus
You barley escape with your life you have {health} health remaining.
->END

== camp_site ==
You find a secluded area to set up camp. {not camp_fuse_pickup: You'll need another fuse to ignite a camp fire.} {deep_badlands: After your excursion, you need rest.} Its { advance_time() }
* [Go find fuse] -> camp_fuse_pickup
+ {camp_fuse_pickup} {not chimera_loot} [Venture back into the badlands] -> badlands
+ {(fuses > 1) && (time > 0)} [Start fire and end night] -> camp_end
-> END

=== camp_fuse_pickup===
~ fuses = fuses + 1
You now have a fuse charge. It can help ignite a campfire.
* [Go Back] -> camp_site
-> END

=== deep_badlands ===
Its { advance_time() }. You see a chimera in the distance. It carries the gear of slain vagabonds as a warning. That gear may be of value.
+ [Return] -> badlands
+ {ammo >= 1} [Take the shot] -> chimera_loot

== chimera_loot ==
~ ammo = ammo + 2
~ visor = visor + 1
Your bullet whistles before is strikes the chimera's neck. It locks eyes with you as it gives its last roar. The spoils are yours for the taking. You find two rounds of ammunation and a strange visor that highlights targets.
* [Start venturing back] -> badlands

== camp_end ==
You sleep through the night with a fire to scare the mutants.
-> END

== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 2:
            ~ time = 0
    }    
    
    {   
        - time == 0:
            ~ return "high noon"
        
        - time == 1:
            ~ return "evening"
        
        - time == 2:
            ~ return "midnight"
    
    }
    
    
        
    ~ return time
    
    
    
