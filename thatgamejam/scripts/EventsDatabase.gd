extends Node

static func load_events_to_manager():
	EventManagertscn.good_events.clear()
	EventManagertscn.bad_events.clear()
	
	create_good_events()
	create_bad_events()

static func create_good_events():
	var e1 = GameEvent.new()
	e1.title = "Traveling Merchants Arrive"
	e1.description = "A wealthy caravan arrives at your settlement, offering valuable trade opportunities."
	e1.is_good = true
	var e1o1 = EventOption.new()
	e1o1.text = "Trade supplies for gold"
	e1o1.effects = {"supplies": -20, "money": 80}
	var e1o2 = EventOption.new()
	e1o2.text = "Sell lumber at premium price"
	e1o2.effects = {"wood": -30, "money": 70}
	var e1o3 = EventOption.new()
	e1o3.text = "Decline their offer"
	e1o3.effects = {}
	e1.options.append(e1o1)
	e1.options.append(e1o2)
	e1.options.append(e1o3)
	EventManagertscn.good_events.append(e1)
	
	var e2 = GameEvent.new()
	e2.title = "Bountiful Harvest Season"
	e2.description = "The fields have yielded an exceptional harvest this season!"
	e2.is_good = true
	var e2o1 = EventOption.new()
	e2o1.text = "Store all supplies"
	e2o1.effects = {"supplies": 100, "happiness": 0.1}
	var e2o2 = EventOption.new()
	e2o2.text = "Sell half the harvest"
	e2o2.effects = {"supplies": 50, "money": 60}
	var e2o3 = EventOption.new()
	e2o3.text = "Host a grand feast"
	e2o3.effects = {"supplies": 30, "happiness": 0.25, "faith": 40}
	e2.options.append(e2o1)
	e2.options.append(e2o2)
	e2.options.append(e2o3)
	EventManagertscn.good_events.append(e2)
	
	var e3 = GameEvent.new()
	e3.title = "Generous Donation"
	e3.description = "A wealthy benefactor has left a substantial gift at your chapel."
	e3.is_good = true
	var e3o1 = EventOption.new()
	e3o1.text = "Use for expansion"
	e3o1.effects = {"wood": 80, "money": 100}
	var e3o2 = EventOption.new()
	e3o2.text = "Distribute to followers"
	e3o2.effects = {"supplies": 100, "happiness": 0.2}
	var e3o3 = EventOption.new()
	e3o3.text = "Donate to chapel"
	e3o3.effects = {"faith": 120, "happiness": 0.15}
	e3.options.append(e3o1)
	e3.options.append(e3o2)
	e3.options.append(e3o3)
	EventManagertscn.good_events.append(e3)
	
	var e4 = GameEvent.new()
	e4.title = "Pilgrims Visit"
	e4.description = "Religious pilgrims have come to visit your chapel, bringing offerings."
	e4.is_good = true
	var e4o1 = EventOption.new()
	e4o1.text = "Welcome them warmly"
	e4o1.effects = {"faith": 60, "happiness": 0.15, "supplies": -10}
	var e4o2 = EventOption.new()
	e4o2.text = "Charge entrance fees"
	e4o2.effects = {"money": 50, "faith": 30}
	var e4o3 = EventOption.new()
	e4o3.text = "Ask for donations only"
	e4o3.effects = {"faith": 40, "money": 20, "happiness": 0.05}
	e4.options.append(e4o1)
	e4.options.append(e4o2)
	e4.options.append(e4o3)
	EventManagertscn.good_events.append(e4)
	
	var e5 = GameEvent.new()
	e5.title = "Lucky Find"
	e5.description = "Workers discovered an old treasure cache while digging!"
	e5.is_good = true
	var e5o1 = EventOption.new()
	e5o1.text = "Keep for the settlement"
	e5o1.effects = {"money": 150, "wood": 40}
	var e5o2 = EventOption.new()
	e5o2.text = "Share with all followers"
	e5o2.effects = {"money": 80, "happiness": 0.3}
	var e5o3 = EventOption.new()
	e5o3.text = "Donate to the poor"
	e5o3.effects = {"faith": 100, "happiness": 0.2}
	e5.options.append(e5o1)
	e5.options.append(e5o2)
	e5.options.append(e5o3)
	EventManagertscn.good_events.append(e5)
	
	var e6 = GameEvent.new()
	e6.title = "Perfect Weather Week"
	e6.description = "Ideal weather conditions provide a productivity boost across all operations."
	e6.is_good = true
	var e6o1 = EventOption.new()
	e6o1.text = "Focus on farming"
	e6o1.effects = {"supplies": 70}
	var e6o2 = EventOption.new()
	e6o2.text = "Focus on lumber"
	e6o2.effects = {"wood": 80}
	var e6o3 = EventOption.new()
	e6o3.text = "Let followers enjoy leisure"
	e6o3.effects = {"happiness": 0.2, "supplies": 30}
	e6.options.append(e6o1)
	e6.options.append(e6o2)
	e6.options.append(e6o3)
	EventManagertscn.good_events.append(e6)
	
	var e7 = GameEvent.new()
	e7.title = "Skilled Workers Arrive"
	e7.description = "Experienced craftsmen seek work in your settlement."
	e7.is_good = true
	var e7o1 = EventOption.new()
	e7o1.text = "Hire them for lumber work"
	e7o1.effects = {"wood": 50, "money": -40}
	var e7o2 = EventOption.new()
	e7o2.text = "Hire them for mining"
	e7o2.effects = {"money": 40}
	var e7o3 = EventOption.new()
	e7o3.text = "Decline the offer"
	e7o3.effects = {}
	e7.options.append(e7o1)
	e7.options.append(e7o2)
	e7.options.append(e7o3)
	EventManagertscn.good_events.append(e7)
	
	var e8 = GameEvent.new()
	e8.title = "Festival Season"
	e8.description = "It's time for the annual harvest festival!"
	e8.is_good = true
	var e8o1 = EventOption.new()
	e8o1.text = "Grand celebration"
	e8o1.effects = {"supplies": -40, "money": -30, "happiness": 0.35}
	var e8o2 = EventOption.new()
	e8o2.text = "Simple celebration"
	e8o2.effects = {"supplies": -15, "happiness": 0.15}
	var e8o3 = EventOption.new()
	e8o3.text = "Skip festival, focus on work"
	e8o3.effects = {"happiness": -0.1, "wood": 40, "supplies": 40}
	e8.options.append(e8o1)
	e8.options.append(e8o2)
	e8.options.append(e8o3)
	EventManagertscn.good_events.append(e8)
	
	var e9 = GameEvent.new()
	e9.title = "Rich Mineral Vein Discovered"
	e9.description = "Miners have found an exceptionally rich vein of valuable minerals!"
	e9.is_good = true
	var e9o1 = EventOption.new()
	e9o1.text = "Mine it all immediately"
	e9o1.effects = {"money": 200}
	var e9o2 = EventOption.new()
	e9o2.text = "Mine sustainably over time"
	e9o2.effects = {"money": 100, "happiness": 0.1}
	var e9o3 = EventOption.new()
	e9o3.text = "Sell mining rights"
	e9o3.effects = {"money": 150}
	e9.options.append(e9o1)
	e9.options.append(e9o2)
	e9.options.append(e9o3)
	EventManagertscn.good_events.append(e9)
	
	var e10 = GameEvent.new()
	e10.title = "Divine Blessing"
	e10.description = "Your prayers are answered with a powerful divine blessing!"
	e10.is_good = true
	var e10o1 = EventOption.new()
	e10o1.text = "Blessing of prosperity"
	e10o1.effects = {"wood": 60, "supplies": 60, "money": 60}
	var e10o2 = EventOption.new()
	e10o2.text = "Blessing of happiness"
	e10o2.effects = {"happiness": 0.3, "faith": 80}
	var e10o3 = EventOption.new()
	e10o3.text = "Blessing of faith"
	e10o3.effects = {"faith": 150, "happiness": 0.15}
	e10.options.append(e10o1)
	e10.options.append(e10o2)
	e10.options.append(e10o3)
	EventManagertscn.good_events.append(e10)
	
	var e11 = GameEvent.new()
	e11.title = "Neighboring Alliance"
	e11.description = "A nearby settlement proposes a mutually beneficial alliance."
	e11.is_good = true
	var e11o1 = EventOption.new()
	e11o1.text = "Accept alliance"
	e11o1.effects = {"supplies": 50, "money": 50, "happiness": 0.1}
	var e11o2 = EventOption.new()
	e11o2.text = "Trade agreement only"
	e11o2.effects = {"money": 80}
	var e11o3 = EventOption.new()
	e11o3.text = "Decline politely"
	e11o3.effects = {}
	e11.options.append(e11o1)
	e11.options.append(e11o2)
	e11.options.append(e11o3)
	EventManagertscn.good_events.append(e11)
	
	var e12 = GameEvent.new()
	e12.title = "Ancient Artifact Found"
	e12.description = "Workers unearth a mysterious ancient artifact of great value."
	e12.is_good = true
	var e12o1 = EventOption.new()
	e12o1.text = "Display in chapel"
	e12o1.effects = {"faith": 100, "happiness": 0.2}
	var e12o2 = EventOption.new()
	e12o2.text = "Sell to collectors"
	e12o2.effects = {"money": 180}
	var e12o3 = EventOption.new()
	e12o3.text = "Study its mysteries"
	e12o3.effects = {"faith": 60, "money": 40, "happiness": 0.1}
	e12.options.append(e12o1)
	e12.options.append(e12o2)
	e12.options.append(e12o3)
	EventManagertscn.good_events.append(e12)
	
	var e13 = GameEvent.new()
	e13.title = "Abundant Wildlife"
	e13.description = "Game animals have become plentiful in the surrounding forests."
	e13.is_good = true
	var e13o1 = EventOption.new()
	e13o1.text = "Organize hunting parties"
	e13o1.effects = {"supplies": 80, "wood": -10}
	var e13o2 = EventOption.new()
	e13o2.text = "Hunt moderately"
	e13o2.effects = {"supplies": 50}
	var e13o3 = EventOption.new()
	e13o3.text = "Leave wildlife alone"
	e13o3.effects = {"happiness": 0.1}
	e13.options.append(e13o1)
	e13.options.append(e13o2)
	e13.options.append(e13o3)
	EventManagertscn.good_events.append(e13)
	
	var e14 = GameEvent.new()
	e14.title = "Spiritual Awakening"
	e14.description = "A wave of religious fervor sweeps through your followers."
	e14.is_good = true
	var e14o1 = EventOption.new()
	e14o1.text = "Hold mass prayers"
	e14o1.effects = {"faith": 120, "happiness": 0.2}
	var e14o2 = EventOption.new()
	e14o2.text = "Channel into work"
	e14o2.effects = {"faith": 60, "wood": 50, "supplies": 50}
	var e14o3 = EventOption.new()
	e14o3.text = "Let it flow naturally"
	e14o3.effects = {"faith": 80, "happiness": 0.15}
	e14.options.append(e14o1)
	e14.options.append(e14o2)
	e14.options.append(e14o3)
	EventManagertscn.good_events.append(e14)
	
	var e15 = GameEvent.new()
	e15.title = "Master Craftsman Visits"
	e15.description = "A renowned craftsman offers to teach advanced techniques to your workers."
	e15.is_good = true
	var e15o1 = EventOption.new()
	e15o1.text = "Pay for training"
	e15o1.effects = {"money": -60, "wood": 90}
	var e15o2 = EventOption.new()
	e15o2.text = "Barter for training"
	e15o2.effects = {"supplies": -30, "wood": 70}
	var e15o3 = EventOption.new()
	e15o3.text = "Decline the offer"
	e15o3.effects = {}
	e15.options.append(e15o1)
	e15.options.append(e15o2)
	e15.options.append(e15o3)
	EventManagertscn.good_events.append(e15)

static func create_bad_events():
	var e1 = GameEvent.new()
	e1.title = "Bandit Attack"
	e1.description = "Bandits raid your settlement during the night!"
	e1.is_good = false
	var e1o1 = EventOption.new()
	e1o1.text = "Pay them to leave"
	e1o1.effects = {"money": -100, "happiness": -0.1}
	var e1o2 = EventOption.new()
	e1o2.text = "Fight back"
	e1o2.effects = {"wood": -30, "supplies": -30, "money": -30, "happiness": -0.15}
	var e1o3 = EventOption.new()
	e1o3.text = "Surrender everything valuable"
	e1o3.effects = {"wood": -50, "money": -80, "happiness": -0.2}
	e1.options.append(e1o1)
	e1.options.append(e1o2)
	e1.options.append(e1o3)
	EventManagertscn.bad_events.append(e1)
	
	var e2 = GameEvent.new()
	e2.title = "Warehouse Fire"
	e2.description = "A fire breaks out in your storage building!"
	e2.is_good = false
	var e2o1 = EventOption.new()
	e2o1.text = "Fight the fire"
	e2o1.effects = {"wood": -40, "supplies": -25}
	var e2o2 = EventOption.new()
	e2o2.text = "Let it burn"
	e2o2.effects = {"wood": -80, "supplies": -60, "happiness": -0.15}
	var e2o3 = EventOption.new()
	e2o3.text = "Save most valuable items only"
	e2o3.effects = {"wood": -50, "supplies": -40, "money": 30}
	e2.options.append(e2o1)
	e2.options.append(e2o2)
	e2.options.append(e2o3)
	EventManagertscn.bad_events.append(e2)
	
	var e3 = GameEvent.new()
	e3.title = "Crop Failure"
	e3.description = "A blight has destroyed much of your harvest."
	e3.is_good = false
	var e3o1 = EventOption.new()
	e3o1.text = "Buy supplies from traders"
	e3o1.effects = {"money": -80, "supplies": 40}
	var e3o2 = EventOption.new()
	e3o2.text = "Ration what remains"
	e3o2.effects = {"supplies": -50, "happiness": -0.2}
	var e3o3 = EventOption.new()
	e3o3.text = "Hunt and forage"
	e3o3.effects = {"supplies": 20, "wood": -20, "happiness": -0.05}
	e3.options.append(e3o1)
	e3.options.append(e3o2)
	e3.options.append(e3o3)
	EventManagertscn.bad_events.append(e3)
	
	var e4 = GameEvent.new()
	e4.title = "Tool Shortage"
	e4.description = "Many essential tools have broken simultaneously."
	e4.is_good = false
	var e4o1 = EventOption.new()
	e4o1.text = "Buy new tools"
	e4o1.effects = {"money": -90}
	var e4o2 = EventOption.new()
	e4o2.text = "Craft makeshift replacements"
	e4o2.effects = {"wood": -30, "money": -20}
	var e4o3 = EventOption.new()
	e4o3.text = "Work with broken tools"
	e4o3.effects = {"wood": -40, "supplies": -40, "happiness": -0.1}
	e4.options.append(e4o1)
	e4.options.append(e4o2)
	e4.options.append(e4o3)
	EventManagertscn.bad_events.append(e4)
	
	var e5 = GameEvent.new()
	e5.title = "Severe Storm"
	e5.description = "A violent storm damages buildings and resources."
	e5.is_good = false
	var e5o1 = EventOption.new()
	e5o1.text = "Repair everything immediately"
	e5o1.effects = {"wood": -70, "money": -80}
	var e5o2 = EventOption.new()
	e5o2.text = "Make temporary repairs"
	e5o2.effects = {"wood": -30, "money": -30, "happiness": -0.1}
	var e5o3 = EventOption.new()
	e5o3.text = "Focus on essentials only"
	e5o3.effects = {"wood": -40, "supplies": -30, "happiness": -0.15}
	e5.options.append(e5o1)
	e5.options.append(e5o2)
	e5.options.append(e5o3)
	EventManagertscn.bad_events.append(e5)
	
	var e6 = GameEvent.new()
	e6.title = "Worker Dispute"
	e6.description = "Workers are demanding better conditions and threatening to strike."
	e6.is_good = false
	var e6o1 = EventOption.new()
	e6o1.text = "Meet their demands"
	e6o1.effects = {"supplies": -40, "money": -50, "happiness": 0.1}
	var e6o2 = EventOption.new()
	e6o2.text = "Refuse their demands"
	e6o2.effects = {"wood": -50, "supplies": -50, "happiness": -0.25}
	var e6o3 = EventOption.new()
	e6o3.text = "Compromise with them"
	e6o3.effects = {"supplies": -20, "money": -25, "happiness": 0.05}
	e6.options.append(e6o1)
	e6.options.append(e6o2)
	e6.options.append(e6o3)
	EventManagertscn.bad_events.append(e6)
	
	var e7 = GameEvent.new()
	e7.title = "Crisis of Faith"
	e7.description = "Doubts spread among followers about the faith."
	e7.is_good = false
	var e7o1 = EventOption.new()
	e7o1.text = "Hold emergency prayers"
	e7o1.effects = {"supplies": -25, "faith": 40, "happiness": 0.05}
	var e7o2 = EventOption.new()
	e7o2.text = "Give space to question"
	e7o2.effects = {"faith": -40, "happiness": -0.15}
	var e7o3 = EventOption.new()
	e7o3.text = "Address concerns openly"
	e7o3.effects = {"faith": 10, "happiness": 0.05}
	e7.options.append(e7o1)
	e7.options.append(e7o2)
	e7.options.append(e7o3)
	EventManagertscn.bad_events.append(e7)
	
	var e8 = GameEvent.new()
	e8.title = "Supply Caravan Lost"
	e8.description = "A supply caravan has disappeared on the road."
	e8.is_good = false
	var e8o1 = EventOption.new()
	e8o1.text = "Send search party"
	e8o1.effects = {"money": -40, "wood": -20}
	var e8o2 = EventOption.new()
	e8o2.text = "Accept the loss"
	e8o2.effects = {"supplies": -60, "wood": -40, "happiness": -0.15}
	var e8o3 = EventOption.new()
	e8o3.text = "Hire mercenaries"
	e8o3.effects = {"money": -70, "supplies": 30}
	e8.options.append(e8o1)
	e8.options.append(e8o2)
	e8.options.append(e8o3)
	EventManagertscn.bad_events.append(e8)
	
	var e9 = GameEvent.new()
	e9.title = "Mine Collapse"
	e9.description = "Part of the mine has collapsed, halting operations."
	e9.is_good = false
	var e9o1 = EventOption.new()
	e9o1.text = "Repair immediately"
	e9o1.effects = {"wood": -60, "money": -80}
	var e9o2 = EventOption.new()
	e9o2.text = "Slow repairs"
	e9o2.effects = {"wood": -30, "money": -70}
	var e9o3 = EventOption.new()
	e9o3.text = "Abandon this section"
	e9o3.effects = {"money": -100, "happiness": -0.1}
	e9.options.append(e9o1)
	e9.options.append(e9o2)
	e9.options.append(e9o3)
	EventManagertscn.bad_events.append(e9)
	
	var e10 = GameEvent.new()
	e10.title = "Severe Drought"
	e10.description = "Water sources are running dry, affecting all operations."
	e10.is_good = false
	var e10o1 = EventOption.new()
	e10o1.text = "Dig emergency wells"
	e10o1.effects = {"wood": -40, "money": -60, "supplies": -30}
	var e10o2 = EventOption.new()
	e10o2.text = "Ration water strictly"
	e10o2.effects = {"supplies": -50, "happiness": -0.2}
	var e10o3 = EventOption.new()
	e10o3.text = "Pray for rain"
	e10o3.effects = {"faith": 50, "supplies": -40, "happiness": -0.1}
	e10.options.append(e10o1)
	e10.options.append(e10o2)
	e10.options.append(e10o3)
	EventManagertscn.bad_events.append(e10)
	
	var e11 = GameEvent.new()
	e11.title = "Plague Outbreak"
	e11.description = "A contagious disease spreads through the settlement."
	e11.is_good = false
	var e11o1 = EventOption.new()
	e11o1.text = "Quarantine and treat"
	e11o1.effects = {"supplies": -50, "money": -40, "wood": -30}
	var e11o2 = EventOption.new()
	e11o2.text = "Let it run its course"
	e11o2.effects = {"happiness": -0.3, "supplies": -20}
	var e11o3 = EventOption.new()
	e11o3.text = "Basic care only"
	e11o3.effects = {"supplies": -30, "happiness": -0.15}
	e11.options.append(e11o1)
	e11.options.append(e11o2)
	e11.options.append(e11o3)
	EventManagertscn.bad_events.append(e11)
	
	var e12 = GameEvent.new()
	e12.title = "Locust Swarm"
	e12.description = "A massive swarm of locusts descends on your fields."
	e12.is_good = false
	var e12o1 = EventOption.new()
	e12o1.text = "Hire exterminators"
	e12o1.effects = {"money": -70, "supplies": -30}
	var e12o2 = EventOption.new()
	e12o2.text = "Let them pass"
	e12o2.effects = {"supplies": -80, "happiness": -0.15}
	var e12o3 = EventOption.new()
	e12o3.text = "Fight them manually"
	e12o3.effects = {"supplies": -50, "wood": -20}
	e12.options.append(e12o1)
	e12.options.append(e12o2)
	e12.options.append(e12o3)
	EventManagertscn.bad_events.append(e12)
	
	var e13 = GameEvent.new()
	e13.title = "Forest Fire"
	e13.description = "A wildfire threatens the nearby forests and lumber operations."
	e13.is_good = false
	var e13o1 = EventOption.new()
	e13o1.text = "Fight the fire"
	e13o1.effects = {"wood": -50, "supplies": -30, "money": -40}
	var e13o2 = EventOption.new()
	e13o2.text = "Let it burn out"
	e13o2.effects = {"wood": -100, "happiness": -0.2}
	var e13o3 = EventOption.new()
	e13o3.text = "Create firebreaks"
	e13o3.effects = {"wood": -70, "money": -30}
	e13.options.append(e13o1)
	e13.options.append(e13o2)
	e13.options.append(e13o3)
	EventManagertscn.bad_events.append(e13)
	
	var e14 = GameEvent.new()
	e14.title = "Harsh Winter"
	e14.description = "An unusually severe winter is approaching quickly."
	e14.is_good = false
	var e14o1 = EventOption.new()
	e14o1.text = "Stockpile everything"
	e14o1.effects = {"wood": -50, "money": -60, "supplies": 40}
	var e14o2 = EventOption.new()
	e14o2.text = "Basic preparations"
	e14o2.effects = {"wood": -30, "money": -30}
	var e14o3 = EventOption.new()
	e14o3.text = "Face it unprepared"
	e14o3.effects = {"supplies": -60, "happiness": -0.2}
	e14.options.append(e14o1)
	e14.options.append(e14o2)
	e14.options.append(e14o3)
	EventManagertscn.bad_events.append(e14)
	
	var e15 = GameEvent.new()
	e15.title = "Corrupt Officials"
	e15.description = "Visiting officials demand bribes and threaten sanctions."
	e15.is_good = false
	var e15o1 = EventOption.new()
	e15o1.text = "Pay the bribes"
	e15o1.effects = {"money": -100, "happiness": -0.1}
	var e15o2 = EventOption.new()
	e15o2.text = "Refuse and face sanctions"
	e15o2.effects = {"wood": -40, "supplies": -40, "money": -60}
	var e15o3 = EventOption.new()
	e15o3.text = "Report to higher authorities"
	e15o3.effects = {"money": -50, "faith": 30}
	e15.options.append(e15o1)
	e15.options.append(e15o2)
	e15.options.append(e15o3)
	EventManagertscn.bad_events.append(e15)
