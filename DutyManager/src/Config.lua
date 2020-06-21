DMConfig = LibStub("AceAddon-3.0"):NewAddon("DMConfig")

DMConfig = {
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
                name="",
            },
            {
                path="interface/icons/ability_warrior_sunder.blp", -- sunder armor
                name="",
            },
            {
                path="interface/icons/ability_thunderclap.blp", -- thunder clap
                name="",
            },
            {
                path="interface/icons/ability_warrior_warcry.blp", -- demoralizing shout
                name="",
            },

            {
                path="interface/icons/ability_golemthunderclap.blp", -- intimidating shout
                name="",
            },

            {
                path="interface/icons/inv_gauntlets_04.blp", -- pummel
                name="",
            },
        },
        ROGUE={
            {
                path="interface/icons/inv_misc_herb_16.blp", -- wound poison
                name="",
            },
            {
                path="interface/icons/spell_nature_nullifydisease.blp", -- mind numbing poison
                name="",
            },

            {
                path="interface/icons/ability_sap.blp", -- sap
                name="",
            },
            {
                path="interface/icons/ability_kick.blp", -- kick
                name="",
            },
            {
                path="interface/icons/spell_shadow_mindsteal.blp", -- blind
                name="",
            },
            {
                path="interface/icons/ability_gouge.blp", -- gouge
                name="",
            },
        },
        MAGE={
            {
                path="interface/icons/spell_holy_arcaneintellect.blp", -- int
                name="",
            },
            {
                path="interface/icons/spell_nature_abolishmagic.blp", -- dampen
                name="",
            },
            {
                path="interface/icons/spell_holy_flashheal.blp", -- amplify
                name="",
            },

            {
                path="interface/icons/spell_fire_soulburn.blp", -- improved scorch
                name="",
            },
            {
                path="interface/icons/spell_frost_chillingblast.blp", -- winters chill
                name="",
            },

            {
                path="interface/icons/spell_nature_polymorph.blp", -- poly
                name="",
            },
            {
                path="interface/icons/spell_frost_frostnova.blp", -- frost nova
                name="",
            },
            {
                path="interface/icons/spell_frost_iceshock.blp", -- counterspell
                name="",
            },

            {
                path="interface/icons/spell_nature_removecurse.blp", -- remove curse
                name="",
            },
        },
        PRIEST={
            {
                path="interface/icons/spell_holy_wordfortitude.blp", -- stam
                name="",
            },
            {
                path="interface/icons/spell_shadow_antishadow.blp", -- shadow protection
                name="",
            },
            {
                path="interface/icons/spell_holy_divinespirit.blp", -- spirit
                name="",
            },
            {
                path="interface/icons/spell_holy_excorcism.blp", -- fear ward
                name="",
            },

            {
                path="interface/icons/spell_shadow_blackplague.blp", -- shadow weaving
                name="",
            },

            {
                path="interface/icons/spell_nature_slow.blp", -- shackle undead
                name="",
            },
            {
                path="interface/icons/spell_shadow_shadowworddominate.blp", -- mind control
                name="",
            },
            {
                path="interface/icons/spell_shadow_psychicscream.blp", -- psychic scream
                name="",
            },
            {
                path="interface/icons/spell_shadow_impphaseshift.blp", -- silence
                name="",
            },

            {
                path="interface/icons/spell_nature_nullifydisease.blp", -- cure disease
                name="",
            },
            {
                path="interface/icons/spell_holy_dispelmagic.blp", -- dispel magic
                name="",
            },
        },
        WARLOCK={
            {
                path="interface/icons/spell_shadow_bloodboil.blp", -- blood pact
                name="",
            },
            {
                path="interface/icons/inv_misc_orb_04.blp", -- SS
                name="",
            },
            {
                path="interface/icons/inv_stone_04.blp", -- HS
                name="",
            },

            {
                path="interface/icons/spell_shadow_unholystrength.blp", -- CoR
                name="",
            },
            {
                path="interface/icons/spell_shadow_curseofachimonde.blp", -- CoS
                name="",
            },
            {
                path="interface/icons/spell_shadow_chilltouch.blp", -- CoE
                name="",
            },
            {
                path="interface/icons/spell_shadow_curseofmannoroth.blp", -- CoW
                name="",
            },
            {
                path="interface/icons/spell_shadow_curseoftounges.blp", -- CoT
                name="",
            },
            {
                path="interface/icons/spell_shadow_curseofsargeras.blp", -- CoA
                name="",
            },
            {
                path="interface/icons/spell_shadow_auraofdarkness.blp", -- CoD
                name="",
            },

            {
                path="interface/icons/spell_shadow_possession.blp", -- fear
                name="",
            },
            {
                path="interface/icons/spell_shadow_cripple.blp", -- banish
                name="",
            },
            {
                path="interface/icons/spell_shadow_mindrot.blp", -- spell lock
                name="",
            },
            {
                path="interface/icons/spell_shadow_mindsteal.blp", -- seduction
                name="",
            },

            {
                path="interface/icons/spell_nature_purge.blp", -- devour magic
                name="",
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
                name="",
            },
            {
                path="interface/icons/spell_nature_strengthofearthtotem02.blp", -- earthbind
                name="",
            },
            {
                path="interface/icons/spell_frostresistancetotem_01.blp", -- frost resistance
                name="",
            },
            {
                path="interface/icons/spell_fireresistancetotem_01.blp", -- fire resistance
                name="",
            },
            {
                path="interface/icons/spell_frost_summonwaterelemental.blp", -- mana tide
                name="",
            },
            {
                path="interface/icons/spell_nature_diseasecleansingtotem.blp", -- disease cleansing
                name="",
            },
            {
                path="interface/icons/spell_nature_poisoncleansingtotem.blp", -- posion cleansing
                name="",
            },
            {
                path="interface/icons/spell_nature_natureresistancetotem.blp", -- nature resistance
                name="",
            },
            {
                path="interface/icons/spell_nature_windfury.blp", -- windfury
                name="",
            },
            {
                path="interface/icons/spell_nature_brilliance.blp", -- tranquil air totem
                name="",
            },
            {
                path="interface/icons/spell_nature_invisibilitytotem.blp", -- grace of air
                name="",
            },

            {
                path="interface/icons/spell_nature_purge.blp", -- purge
                name="",
            },
        },
        DRUID={
            {
                path="interface/icons/spell_nature_regeneration.blp", -- mark
                name="",
            },
            {
                path="interface/icons/spell_nature_thorns.blp", -- thorns
                name="",
            },
            {
                path="interface/icons/spell_nature_reincarnation.blp", -- reinc
                name="",
            },

            {
                path="interface/icons/spell_nature_faeriefire.blp", -- faeriefire
                name="",
            },
            {
                path="interface/icons/spell_nature_insectswarm.blp", -- insect swarm
                name="",
            },

            {
                path="interface/icons/spell_nature_sleep.blp", -- hibernate
                name="",
            },
            {
                path="interface/icons/spell_nature_stranglevines.blp", -- entangling roots
                name="",
            },

            {
                path="interface/icons/spell_nature_nullifypoison_02.blp", -- dispell poison
                name="",
            },
            {
                path="interface/icons/spell_holy_removecurse.blp", -- remove curse
                name="",
            },
        },
        PALADIN={
            {
                path="interface/icons/spell_holy_greaterblessingofkings.blp", -- BoM
                name="",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofsalvation.blp", -- BoS
                name="",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofwisdom.blp", -- wisdom
                name="",
            },
            {
                path="interface/icons/spell_magic_greaterblessingofkings.blp", -- BoK
                name="",
            },
            {
                path="interface/icons/spell_holy_greaterblessingoflight.blp", -- BoL
                name="",
            },
            {
                path="interface/icons/spell_holy_greaterblessingofsanctuary.blp", -- sanctuary
                name="",
            },
            {
                path="interface/icons/spell_holy_devotionaura.blp", -- devotion aura
                name="",
            },
            {
                path="interface/icons/spell_holy_mindsooth.blp", -- concentration aura
                name="",
            },
            {
                path="interface/icons/spell_holy_auraoflight.blp", -- retribution aura
                name="",
            },
            {
                path="interface/icons/spell_fire_sealoffire.blp", -- FR aura
                name="",
            },
            {
                path="interface/icons/spell_frost_wizardmark.blp", -- frost res aura
                name="",
            },
            {
                path="interface/icons/spell_shadow_sealofkings.blp", -- SR aura
                name="",
            },

            {
                path="interface/icons/spell_holy_healingaura.blp", -- judgement of light
                name="",
            },
            {
                path="interface/icons/spell_holy_righteousnessaura.blp", -- judgement of wisdom
                name="",
            },

            {
                path="interface/icons/spell_holy_sealofmight.blp", -- hammer of justice
                name="",
            },
            {
                path="interface/icons/spell_holy_prayerofhealing.blp", -- repentance
                name="",
            },

            {
                path="interface/icons/spell_holy_renew.blp", -- cleanse
                name="",
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