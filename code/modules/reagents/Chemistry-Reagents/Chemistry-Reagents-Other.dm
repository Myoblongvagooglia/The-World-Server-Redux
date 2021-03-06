/* Paint and crayons */

/datum/reagent/crayon_dust
	name = "Crayon dust"
	id = "crayon_dust"
	description = "Intensely coloured powder obtained by grinding crayons."
	taste_description = "powdered wax"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5
	price_tag = 0.1

/datum/reagent/crayon_dust/red
	name = "Red crayon dust"
	id = "crayon_dust_red"
	color = "#FE191A"

/datum/reagent/crayon_dust/orange
	name = "Orange crayon dust"
	id = "crayon_dust_orange"
	color = "#FFBE4F"

/datum/reagent/crayon_dust/yellow
	name = "Yellow crayon dust"
	id = "crayon_dust_yellow"
	color = "#FDFE7D"

/datum/reagent/crayon_dust/green
	name = "Green crayon dust"
	id = "crayon_dust_green"
	color = "#18A31A"

/datum/reagent/crayon_dust/blue
	name = "Blue crayon dust"
	id = "crayon_dust_blue"
	color = "#247CFF"

/datum/reagent/crayon_dust/purple
	name = "Purple crayon dust"
	id = "crayon_dust_purple"
	color = "#CC0099"

/datum/reagent/crayon_dust/grey //Mime
	name = "Grey crayon dust"
	id = "crayon_dust_grey"
	color = "#808080"

/datum/reagent/crayon_dust/brown //Rainbow
	name = "Brown crayon dust"
	id = "crayon_dust_brown"
	color = "#846F35"

/datum/reagent/marker_ink
	name = "Marker ink"
	id = "marker_ink"
	description = "Intensely coloured ink used in markers."
	taste_description = "extremely bitter"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5

/datum/reagent/marker_ink/black
	name = "Black marker ink"
	id = "marker_ink_black"
	color = "#000000"

/datum/reagent/marker_ink/red
	name = "Red marker ink"
	id = "marker_ink_red"
	color = "#FE191A"

/datum/reagent/marker_ink/orange
	name = "Orange marker ink"
	id = "marker_ink_orange"
	color = "#FFBE4F"

/datum/reagent/marker_ink/yellow
	name = "Yellow marker ink"
	id = "marker_ink_yellow"
	color = "#FDFE7D"

/datum/reagent/marker_ink/green
	name = "Green marker ink"
	id = "marker_ink_green"
	color = "#18A31A"

/datum/reagent/marker_ink/blue
	name = "Blue marker ink"
	id = "marker_ink_blue"
	color = "#247CFF"

/datum/reagent/marker_ink/purple
	name = "Purple marker ink"
	id = "marker_ink_purple"
	color = "#CC0099"

/datum/reagent/marker_ink/grey //Mime
	name = "Grey marker ink"
	id = "marker_ink_grey"
	color = "#808080"

/datum/reagent/marker_ink/brown //Rainbow
	name = "Brown marker ink"
	id = "marker_ink_brown"
	color = "#846F35"

/datum/reagent/paint
	name = "Paint"
	id = "paint"
	description = "This paint will stick to almost any object."
	taste_description = "chalk"
	reagent_state = LIQUID
	color = "#808080"
	overdose = REAGENTS_OVERDOSE * 0.5
	color_weight = 20

/datum/reagent/paint/touch_turf(var/turf/T)
	if(istype(T) && !istype(T, /turf/space))
		T.color = color

/datum/reagent/paint/touch_obj(var/obj/O)
	if(istype(O))
		O.color = color

/datum/reagent/paint/touch_mob(var/mob/M)
	if(istype(M) && !istype(M, /mob/observer)) //painting ghosts: not allowed
		M.color = color //maybe someday change this to paint only clothes and exposed body parts for human mobs.

/datum/reagent/paint/get_data()
	return color

/datum/reagent/paint/initialize_data(var/newdata)
	color = newdata
	return

/datum/reagent/paint/mix_data(var/newdata, var/newamount)
	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0

	var/hex1 = uppertext(color)
	var/hex2 = uppertext(newdata)
	if(length(hex1) == 7)
		hex1 += "FF"
	if(length(hex2) == 7)
		hex2 += "FF"
	if(length(hex1) != 9 || length(hex2) != 9)
		return
	colors[1] += hex2num(copytext(hex1, 2, 4)) * volume
	colors[2] += hex2num(copytext(hex1, 4, 6)) * volume
	colors[3] += hex2num(copytext(hex1, 6, 8)) * volume
	colors[4] += hex2num(copytext(hex1, 8, 10)) * volume
	tot_w += volume
	colors[1] += hex2num(copytext(hex2, 2, 4)) * newamount
	colors[2] += hex2num(copytext(hex2, 4, 6)) * newamount
	colors[3] += hex2num(copytext(hex2, 6, 8)) * newamount
	colors[4] += hex2num(copytext(hex2, 8, 10)) * newamount
	tot_w += newamount

	color = rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)
	return

/* Things that didn't fit anywhere else */

/datum/reagent/adminordrazine //An OP chemical for admins
	name = "Adminordrazine"
	id = "adminordrazine"
	description = "It's magic. We don't have to explain it."
	taste_description = "bwoink"
	reagent_state = LIQUID
	color = "#C8A5DC"
	affects_dead = 1 //This can even heal dead people.
	mrate_static = TRUE //Just in case

	glass_name = "liquid gold"
	glass_desc = "It's magic. We don't have to explain it."

/datum/reagent/adminordrazine/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed)

/datum/reagent/adminordrazine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.setCloneLoss(0)
	M.setOxyLoss(0)
	M.radiation = 0
	M.heal_organ_damage(5,5)
	M.adjustToxLoss(-5)
	M.hallucination = 0
	M.setBrainLoss(0)
	M.disabilities = 0
	M.sdisabilities = 0
	M.eye_blurry = 0
	M.SetBlinded(0)
	M.SetWeakened(0)
	M.SetStunned(0)
	M.SetParalysis(0)
	M.silent = 0
	M.dizziness = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.SetConfused(0)
	M.sleeping = 0
	M.jitteriness = 0

/datum/reagent/gold
	name = "Gold"
	id = "gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#F7C430"
	price_tag = 3.2

/datum/reagent/silver
	name = "Silver"
	id = "silver"
	description = "A soft, white, lustrous transition metal, it has the highest electrical conductivity of any element and the highest thermal conductivity of any metal."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#D0D0D0"
	price_tag = 1.2

/datum/reagent/uranium
	name ="Uranium"
	id = "uranium"
	description = "A silvery-white metallic chemical element in the actinide series, weakly radioactive."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#B8B8C0"
	price_tag = 3.2

/datum/reagent/platinum
	name = "Platinum"
	id = "platinum"
	description = "Platinum is a dense, malleable, ductile, highly unreactive, precious, gray-white transition metal.  It is very resistant to corrosion."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#777777"
	price_tag = 2.9

/datum/reagent/uranium/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	affect_ingest(M, alien, removed)

/datum/reagent/uranium/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.apply_effect(5 * removed, IRRADIATE, 0)

/datum/reagent/uranium/touch_turf(var/turf/T)
	if(volume >= 3)
		if(!istype(T, /turf/space))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/adrenaline
	name = "Adrenaline"
	id = "adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#C8A5DC"
	mrate_static = TRUE

/datum/reagent/adrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.SetParalysis(0)
	M.SetWeakened(0)
	M.adjustToxLoss(rand(3))

/datum/reagent/water/holywater
	name = "Holy Water"
	id = "holywater"
	description = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."
	taste_description = "water"
	color = "#E0E8EF"
	mrate_static = TRUE
	hydration_factor = 10

	glass_name = "holy water"
	glass_desc = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."

/datum/reagent/water/holywater/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	if(ishuman(M)) // Any location
		if(M.mind && cult.is_antagonist(M.mind) && prob(10))
			cult.remove_antagonist(M.mind)

/datum/reagent/water/holywater/touch_turf(var/turf/T)
	if(volume >= 5)
		T.holy = 1
	return

/datum/reagent/ammonia
	name = "Ammonia"
	id = "ammonia"
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	taste_description = "mordant"
	taste_mult = 2
	reagent_state = GAS
	color = "#404030"

/datum/reagent/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	description = "A secondary amine, mildly corrosive."
	taste_description = "iron"
	reagent_state = LIQUID
	color = "#604030"

/datum/reagent/fluorosurfactant // Foam precursor
	name = "Fluorosurfactant"
	id = "fluorosurfactant"
	description = "A perfluoronated sulfonic acid that forms a foam when mixed with water."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#9E6B38"

/datum/reagent/foaming_agent // Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming agent"
	id = "foaming_agent"
	description = "A agent that yields metallic foam when mixed with light metal and a strong acid."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#664B63"

/datum/reagent/thermite
	name = "Thermite"
	id = "thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	taste_description = "sweet tasting metal"
	reagent_state = SOLID
	color = "#673910"
	touch_met = 50

/datum/reagent/thermite/touch_turf(var/turf/T)
	if(volume >= 5)
		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/W = T
			W.thermite = 1
			W.overlays += image('icons/effects/effects.dmi',icon_state = "#673910")
			remove_self(5)
	return

/datum/reagent/thermite/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 5)

/datum/reagent/thermite/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustFireLoss(3 * removed)

/datum/reagent/space_cleaner
	name = "Space cleaner"
	id = "cleaner"
	description = "A compound used to clean things. Now with 50% more sodium hypochlorite!"
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#A5F0EE"
	touch_met = 50
	price_tag = 0.2

/datum/reagent/space_cleaner/touch_obj(var/obj/O)
	O.clean_blood()

/datum/reagent/space_cleaner/touch_turf(var/turf/T)
	if(volume >= 1)
		if(istype(T, /turf/simulated))
			var/turf/simulated/S = T
			S.dirt = 0
		T.clean_blood()

		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(5, 10))

/datum/reagent/space_cleaner/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.r_hand)
		M.r_hand.clean_blood()
	if(M.l_hand)
		M.l_hand.clean_blood()
	if(M.wear_mask)
		if(M.wear_mask.clean_blood())
			M.update_inv_wear_mask(0)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(alien == IS_SLIME)
			M.adjustToxLoss(rand(5, 10))
		if(H.head)
			if(H.head.clean_blood())
				H.update_inv_head(0)
		if(H.wear_suit)
			if(H.wear_suit.clean_blood())
				H.update_inv_wear_suit(0)
		else if(H.w_uniform)
			if(H.w_uniform.clean_blood())
				H.update_inv_w_uniform(0)
		if(H.shoes)
			if(H.shoes.clean_blood())
				H.update_inv_shoes(0)
		else
			H.clean_blood(1)
			return
	M.clean_blood()

/datum/reagent/space_cleaner/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_SLIME)
		M.adjustToxLoss(6 * removed)
	else
		M.adjustToxLoss(3 * removed)
		if(prob(5))
			M.vomit()

/datum/reagent/lube // TODO: spraying on borgs speeds them up
	name = "Lube"
	id = "lube"
	description = "Lubricant is a substance introduced between two moving surfaces to reduce the friction and wear between them, giggity."
	taste_description = "slime"
	reagent_state = LIQUID
	color = "#009CA8"
	price_tag = 0.7

/datum/reagent/lube/touch_turf(var/turf/simulated/T)
	if(!istype(T))
		return
	if(volume >= 1)
		T.wet_floor(2)

/datum/reagent/silicate
	name = "Silicate"
	id = "silicate"
	description = "A compound that can be used to reinforce glass."
	taste_description = "plastic"
	reagent_state = LIQUID
	color = "#C7FFFF"
	price_tag = 0.5

/datum/reagent/silicate/touch_obj(var/obj/O)
	if(istype(O, /obj/structure/window))
		var/obj/structure/window/W = O
		W.apply_silicate(volume)
		remove_self(volume)
	return

/datum/reagent/glycerol
	name = "Glycerol"
	id = "glycerol"
	description = "Glycerol is a simple polyol compound. Glycerol is sweet-tasting and of low toxicity."
	taste_description = "sweetness"
	reagent_state = LIQUID
	color = "#808080"
	price_tag = 0.9

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	id = "nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	taste_description = "oil"
	reagent_state = LIQUID
	color = "#808080"
	price_tag = 0.7

/datum/reagent/coolant
	name = "Coolant"
	id = "coolant"
	description = "Industrial cooling substance."
	taste_description = "sourness"
	taste_mult = 1.1
	reagent_state = LIQUID
	color = "#C8A5DC"
	price_tag = 0.5

/datum/reagent/ultraglue
	name = "Ultra Glue"
	id = "glue"
	description = "An extremely powerful bonding agent."
	taste_description = "a special education class"
	color = "#FFFFCC"
	price_tag = 0.5

/datum/reagent/woodpulp
	name = "Wood Pulp"
	id = "woodpulp"
	description = "A mass of wood fibers."
	taste_description = "wood"
	reagent_state = LIQUID
	color = "#B97A57"
	price_tag = 0.9

/datum/reagent/luminol
	name = "Luminol"
	id = "luminol"
	description = "A compound that interacts with blood on the molecular level."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#F2F3F4"
	price_tag = 0.7

/datum/reagent/luminol/touch_obj(var/obj/O)
	O.reveal_blood()

/datum/reagent/luminol/touch_mob(var/mob/living/L)
	L.reveal_blood()

/datum/reagent/poppy
	name = "Poppy Resin"
	id = "poppyresin"
	description = "Extracted from poppies."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 0.8

	get_tax()
		return DRUG_TAX

/datum/reagent/coca
	name = "coca extract"
	id = "coca"
	description = "Extracted from the coca plant."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 0.9

	get_tax()
		return DRUG_TAX

/datum/reagent/menthol
	name = "Menthol"
	id = "menthol"
	description = "Tastes naturally minty, and imparts a very mild numbing sensation."
	taste_description = "mint"
	reagent_state = LIQUID
	color = "#80af9c"
	metabolism = REM * 0.002
	overdose = REAGENTS_OVERDOSE * 0.25
	scannable = 1
	price_tag = 0.3

/datum/reagent/caapi
	name = "caapi extract"
	id = "caapi_extract"
	description = "An extract from the caapi plant."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 1.8

	get_tax()
		return DRUG_TAX

/datum/reagent/chacruna
	name = "chacruna extract"
	id = "chacruna_extract"
	description = "An extract from the chacruna plant."
	taste_description = "a bitter gooey substance"
	reagent_state = LIQUID
	color = "#755202"
	price_tag = 1.8

	get_tax()
		return DRUG_TAX

/datum/reagent/toiletwater
	name = "Toilet Water"
	id = "toiletwater"
	description = "Nasty water taken from a toilet."
	taste_description = "feces and urine"
	reagent_state = LIQUID
	color = "#757547"