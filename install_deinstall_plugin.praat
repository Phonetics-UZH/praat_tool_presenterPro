### install_deinstall_plugin.praat
#
# Praat Script for Praat software (www.praat.org)
# author: Volker Dellwo (volker.dellwo@uzh.ch)
# 
# HISTORY: 
#    V_0.1: created 2014-11-08
#
# DESCRIPTION: 
#    This script installs/deinstalls a plugin on your computer. 
#    Click 'Run' under the 'Run' menu above and follow the intructions. 
#
# SETTINGS: 
#    Plugin: 
#       Insert name of the plugin to be installed/deinstalled. 
#
#    Action:
#       Choose whether you wish to install or deinstall the plugin. 
#
##################

### SCRIPT START ###

form Install plugin...
	sentence Plugin plugin_presenterPro
	choice Action 1
		option Install
		option Deinstall
endform

# Get information about the operating system and save in file: 

	beginPause: "Choose operating system..."
		choice: "Operating_system", 2
			option: "Windows"
			option: "Unix (including Mac)"
	nocheck endPause: "Continue", 1
	os = operating_system

# Check whether plugin already exists:

	file$ = preferencesDirectory$+"/'plugin$'/setup.praat"
	exist = fileReadable(file$)

# Install: 
if action=1

	# Check if plugin exists: 
	if exist = 1
		nocheck pause This plugin is already installed on your system. Overwrite?
		if os = 1
			nocheck exit Windows is not yet supported. Install manually. 
		elsif os = 2
			system rm -R "'preferencesDirectory$'/'plugin$'"
		endif
	endif

	# Move files to preferences directory: 
	if os=1
		nocheck exit Windows is not yet supported. Install manually.
	elsif os=2
		system cp -R 'plugin$' "'preferencesDirectory$'/'plugin$'"
	endif 

	call restartPraat
	
# Deinstall: 
else

	# Stop plugin if it does not exist:
	if exist = 0
		exit This plugin does not exist on your computer.
	else 
		nocheck pause Do you really want to deinstall plugin 'plugin$'?
		if os = 1
			nocheck exit Windows is not yet supported. Deinstall manually. 
		elsif os = 2
			system rm -R "'preferencesDirectory$'/'plugin$'"
		endif
	endif

	call restartPraat

endif

### PROCEDURES

procedure restartPraat
	beginPause: "Restart Praat..."
		comment: "Your installation was successfull"
		comment: "You need to restart Praat for the changes to take effect."
		comment: "Quit Praat now?"
	clicked=endPause: "Restart", "Do NOT restart", 1
	if clicked=1
		Quit
	endif
endproc

### SCRIPT END ###
