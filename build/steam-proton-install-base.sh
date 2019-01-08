
usage() {
	echo "usage: steam-proton-manager [option]"
	echo "  -i  --install    Install proton to the steam directory of the current user"
	echo "  -r  --remove    Remove proton from the steam directory of the current user"
}

install() {
	if [ ! -d $(STEAM_DIR) ]; then echo >&2 "!! "$(STEAM_DIR)" does not exist, cannot install"; return 1; fi
	mkdir -p $(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)
	cp -a $(DST_BASE)/* $(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)
	echo "Installed Proton to "$(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)
	echo "You may need to restart Steam to select this tool"
}

remove() {	
	if [ ! -d $(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)]; then echo >&2 "!! No existing install found at " $(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME); return 1; fi
	rm -rf $(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)
	echo "Removed proton install at "$(STEAM_DIR)/compatibilitytools.d/$(BUILD_NAME)
	echo "You may need to restart Steam update the available tools"
}

if ! [ -z "$2" ]
then
	echo "error: please specify a single option only"
	usage
	exit 1
fi

if [ "$1" = "-i" | "$1" = "--install" ]
then
	install
elif [ "$1" = "-r" | "$1" = "--remove" ]
then
	remove
else
	echo "error: Please specify an option"
	usage
	exit 1
fi
