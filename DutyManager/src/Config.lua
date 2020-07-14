DMConfig = LibStub("AceAddon-3.0"):NewAddon("DMConfig")

DMConfig = {
    version="0.0.1",
    raidTarget = {
        SKULL="interface/targetingframe/ui-raidtargetingicon_8.blp",
        CROSS="interface/targetingframe/ui-raidtargetingicon_7.blp",
        BLUE="interface/targetingframe/ui-raidtargetingicon_6.blp",
        MOON="interface/targetingframe/ui-raidtargetingicon_5.blp",
        GREEN="interface/targetingframe/ui-raidtargetingicon_4.blp",
        PURPLE="interface/targetingframe/ui-raidtargetingicon_3.blp",
        ORANGE="interface/targetingframe/ui-raidtargetingicon_2.blp",
        STAR="interface/targetingframe/ui-raidtargetingicon_1.blp",
    },
    taskList = {
        WARRIOR={
            {
                path="interface/icons/ability_warrior_battleshout.blp", -- battle shout
                name="Battle Shout",
            },
            {
                path="interface/icons/ability_warrior_sunder.blp", -- sunder armor
                name="Sunder Armor",
            },
            {
                path="interface/icons/ability_thunderclap.blp", -- thunder clap
                name="Thunder Clap",
            },
            {
                path="interface/icons/ability_warrior_warcry.blp", -- demoralizing shout
                name="Demoralizing Shout",
            },

            {
                path="interface/icons/ability_golemthunderclap.blp", -- intimidating shout
                name="Intimidating Shout",
            },

            {
                path="interface/icons/inv_gauntlets_04.blp", -- pummel
                name="Pummel",
            },
        },
        ROGUE={
            {
                path="interface/icons/inv_misc_herb_16.blp", -- wound poison
                name="Wound Poison",
            },
            {
                path="interface/icons/spell_nature_nullifydisease.blp", -- mind numbing poison
                name="Mind Numbing Poison",
            },

            {
                path="interface/icons/ability_sap.blp", -- sap
                name="Sap",
            },
            {
                path="interface/icons/ability_kick.blp", -- kick
                name="Kick",
            },
            {
                path="interface/icons/spell_shadow_mindsteal.blp", -- blind
                name="Blind",
            },
            {
                path="interface/icons/ability_gouge.blp", -- gouge
                name="Gouge",
            },
        },
        MAGE={
            {
                path="interface/icons/spell_holy_arcaneintellect.blp", -- int
                name="Intellect",
            },
            {
                path="interface/icons/spell_nature_abolishmagic.blp", -- dampen
                name="Dampen Magic",
            },
            {
                path="interface/icons/spell_holy_flashheal.blp", -- amplify
                name="Amplify Magic",
            },

            {
                path="interface/icons/spell_fire_soulburn.blp", -- improved scorch
                name="Scorch",
            },
            {
                path="interface/icons/spell_frost_chillingblast.blp", -- winters chill
                name="Winter's Chill",
            },

            {
                path="interface/icons/spell_nature_polymorph.blp", -- poly
                name="Polymorph",
            },
            {
                path="interface/icons/spell_frost_frostnova.blp", -- frost nova
                name="Frost Nova",
            },
            {
                path="interface/icons/spell_frost_iceshock.blp", -- counterspell
                name="Counterspell",
            },

            {
                path="interface/icons/spell_nature_removecurse.blp", -- remove curse
                name="Remove Curse",
            },
        },
        PRIEST={
            {
                path="interface/icons/spell_holy_wordfortitude.blp", -- stam
                name="Stamina",
            },
            {
                path="interface/icons/spell_shadow_antishadow.blp", -- shadow protection
                name="Shadow Protection",
            },
            {
                path="interface/icons/spell_holy_divinespirit.blp", -- spirit
                name="Spirit",
            },
            {
                path="interface/icons/spell_holy_excorcism.blp", -- fear ward
                name="Fear Ward",
            },

            {
                path="interface/icons/spell_shadow_blackplague.blp", -- shadow weaving
                name="Shadow Weaving",
            },

            {
                path="interface/icons/spell_nature_slow.blp", -- shackle undead
                name="Shackle Undead",
            },
            {
                path="interface/icons/spell_shadow_shadowworddominate.blp", -- mind control
                name="Mind Control",
            },
            {
                path="interface/icons/spell_shadow_psychicscream.blp", -- psychic scream
                name="Psychic Scream",
            },
            {
                path="interface/icons/spell_shadow_impphaseshift.blp", -- silence
                name="Silence",
            },

            {
                path="interface/icons/spell_nature_nullifydisease.blp", -- cure disease
                name="Cure Disease",
            },
            {
                path="interface/icons/spell_holy_dispelmagic.blp", -- dispel magic
                name="Dispel Magic",
            },
        },
        WARLOCK={
            {
                path="interface/icons/spell_shadow_bloodboil.blp", -- blood pact
                name="Blood Pact",
            },
            {
                path="interface/icons/inv_misc_orb_04.blp", -- SS
                name="Soulstone",
            },
            {
                path="interface/icons/inv_stone_04.blp", -- HS
                name="Healthstone",
            },

            {
                path="interface/icons/spell_shadow_unholystrength.blp", -- CoR
                name="Curse of Recklesness",
            },
            {
                path="interface/icons/spell_shadow_curseofachimonde.blp", -- CoS
                name="Curse of Shadow",
            },
            {
                path="interface/icons/spell_shadow_chilltouch.blp", -- CoE
                name="Curse of Elements",
            },
            {
                path="interface/icons/spell_shadow_curseofmannoroth.blp", -- CoW
                name="Curse of Weakness",
            },
            {
                path="interface/icons/spell_shadow_curseoftounges.blp", -- CoT
                name="Curse of Tongues",
            },
            {
                path="interface/icons/spell_shadow_curseofsargeras.blp", -- CoA
                name="Curse of Agony",
            },
            {
                path="interface/icons/spell_shadow_auraofdarkness.blp", -- CoD
                name="Curse of Doom",
            },

            {
                path="interface/icons/spell_shadow_possession.blp", -- fear
                name="Fear",
            },
            {
                path="interface/icons/spell_shadow_cripple.blp", -- banish
                name="Banish",
            },
            {
                path="interface/icons/spell_shadow_mindrot.blp", -- spell lock
                name="Spell Lock",
            },
            {
                path="interface/icons/spell_shadow_mindsteal.blp", -- seduction
                name="Seduction",
            },

            {
                path="interface/icons/spell_nature_purge.blp", -- devour magic
                name="Devour Magic",
            },
        },
        HUNTER={
            {
                path="interface/icons/ability_trueshot.blp", -- trueshot aura
                name="Trueshot Aura",
            },
            {
                path="interface/icons/spell_nature_protectionformnature.blp", -- aspect of the wild
                name="Aspect of the Wild",
            },

            {
                path="interface/icons/ability_hunter_snipershot.blp", -- hunters mark
                name="Hunter's Mark",
            },
            {
                path="interface/icons/spell_nature_drowsy.blp", -- tranquilizing shot
                name="Tranquilizing shot",
            },

            {
                path="interface/icons/spell_frost_chainsofice.blp", -- freezing trap
                name="Freezing Trap",
            },
            {
                path="interface/icons/ability_druid_cower.blp", -- scare beast
                name="Scare Beast",
            },
            {
                path="interface/icons/ability_theblackarrow.blp", -- silencing shot
                name="Silencing Shot",
            },
            {
                path="interface/icons/inv_spear_02.blp", -- wyvern sting
                name="Wyvern Sting",
            },
            {
                path="interface/icons/ability_hunter_aimedshot.blp", -- viper sting
                name="Viper Sting",
            },
        },
        SHAMAN={
            {
                path="interface/icons/spell_nature_tremortotem.blp", -- tremor totem
                name="Tremor Totem",
            },
            {
                path="interface/icons/spell_nature_strengthofearthtotem02.blp", -- earthbind
                name="Earthbind Totem",
            },
            {
                path="interface/icons/spell_frostresistancetotem_01.blp", -- frost resistance
                name="Frost Resistance Totem",
            },
            {
                path="interface/icons/spell_fireresistancetotem_01.blp", -- fire resistance
                name="Fire Resistance Totem",
            },
            {
                path="interface/icons/spell_frost_summonwaterelemental.blp", -- mana tide
                name="Mana Tide Totem",
            },
            {
                path="interface/icons/spell_nature_diseasecleansingtotem.blp", -- disease cleansing
                name="Disease Cleansing Totem",
            },
            {
                path="interface/icons/spell_nature_poisoncleansingtotem.blp", -- posion cleansing
                name="Poison Cleansing Totem",
            },
            {
                path="interface/icons/spell_nature_natureresistancetotem.blp", -- nature resistance
                name="Nature Resistance Totem",
            },
            {
                path="interface/icons/spell_nature_windfury.blp", -- windfury
                name="Windfury Totem",
            },
            {
                path="interface/icons/spell_nature_brilliance.blp", -- tranquil air totem
                name="Tranquil Air Totem",
            },
            {
                path="interface/icons/spell_nature_invisibilitytotem.blp", -- grace of air
                name="Grace of Air Totem",
            },

            {
                path="interface/icons/spell_nature_purge.blp", -- purge
                name="Purge",
            },
        },
        DRUID={
            {
                path="interface/icons/spell_nature_regeneration.blp", -- mark
                name="Mark of the Wild",
            },
            {
                path="interface/icons/spell_nature_thorns.blp", -- thorns
                name="Thorns",
            },
            {
                path="interface/icons/spell_nature_reincarnation.blp", -- reinc
                name="Reincarnation",
            },

            {
                path="interface/icons/spell_nature_faeriefire.blp", -- faeriefire
                name="Faerie Fire",
            },
            {
                path="interface/icons/spell_nature_insectswarm.blp", -- insect swarm
                name="Insect Swarm",
            },

            {
                path="interface/icons/spell_nature_sleep.blp", -- hibernate
                name="Hibernate",
            },
            {
                path="interface/icons/spell_nature_stranglevines.blp", -- entangling roots
                name="Entangling Roots",
            },

            {
                path="interface/icons/spell_nature_nullifypoison_02.blp", -- dispell poison
                name="Dispel Posion",
            },
            {
                path="interface/icons/spell_holy_removecurse.blp", -- remove curse
                name="Remove Curse",
            },
        },
        PALADIN={
            {
                path="interface/icons/spell_holy_greaterblessingofkings.blp", -- BoM
                name="Blessing of Might",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofsalvation.blp", -- BoS
                name="Blessing of Salvation",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofwisdom.blp", -- wisdom
                name="Blessing of Wisdom",
            },
            {
                path="interface/icons/spell_magic_greaterblessingofkings.blp", -- BoK
                name="Blessing of Kings",
            },
            {
                path="interface/icons/spell_holy_greaterblessingoflight.blp", -- BoL
                name="Blessing of Light",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofsanctuary.blp", -- sanctuary
                name="Blessing of Sanctuary",
            },
            {
                path="interface/icons/spell_holy_devotionaura.blp", -- devotion aura
                name="Devotion Aura",
            },
            {
                path="interface/icons/spell_holy_mindsooth.blp", -- concentration aura
                name="Concentration Aura",
            },
            {
                path="interface/icons/spell_holy_auraoflight.blp", -- retribution aura
                name="Retribution Aura",
            },
            {
                path="interface/icons/spell_fire_sealoffire.blp", -- FR aura
                name="Fire Resistance Aura",
            },
            {
                path="interface/icons/spell_frost_wizardmark.blp", -- frost res aura
                name="Frost Resistance Aura",
            },
            {
                path="interface/icons/spell_shadow_sealofkings.blp", -- SR aura
                name="Shadow Resist Aura",
            },

            {
                path="interface/icons/spell_holy_healingaura.blp", -- judgement of light
                name="Judgement of Light",
            },
            {
                path="interface/icons/spell_holy_righteousnessaura.blp", -- judgement of wisdom
                name="Judgement of Wisdom",
            },

            {
                path="interface/icons/spell_holy_sealofmight.blp", -- hammer of justice
                name="Hammer of Justice",
            },
            {
                path="interface/icons/spell_holy_prayerofhealing.blp", -- repentance
                name="Repentance",
            },

            {
                path="interface/icons/spell_holy_renew.blp", -- cleanse
                name="Cleanse",
            },
        },
    },
    classColors = {
        WARRIOR="C79C6E",
        ROGUE="FFF569",
        MAGE="40C7EB",
        PRIEST="FFFFFF",
        WARLOCK="8787ED",
        HUNTER="A9D271",
        SHAMAN="0070DE",
        DRUID="FF7D0A",
        PALADIN="F58CBA",
    }
}