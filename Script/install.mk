# install_xc.mk

PROJECT_NAME	?= JavaScriptShell
DERIVED_BASE	= $(HOME)/build/derived-data/
PRODUCT_PATH	= Build/Products/Release

LIB_DIR		= ../Resource/Library

SHKIT_DIR	= ../../ShellKit
SHKIT_LIB_DIR	= $(SHKIT_DIR)/Resource/Library

all: install

clean:
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_macOS)
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_iOS)
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_iOS_sim)
	(cd $(HOME)/Library/Frameworks && rm -rf $(PROJECT_NAME).xcframework)

install: install_lib install_command install_app

install_lib: $(LIB_DIR)/Library.js $(LIB_DIR)/types/Library.d.ts

$(LIB_DIR)/Library.js: $(SHKIT_LIB_DIR)/Library.js
	cp $< $@

$(LIB_DIR)/types/Library.d.ts: $(SHKIT_LIB_DIR)/types/Library.d.ts
	cp $< $@

install_command: dummy
	xcodebuild install \
	  -scheme jsh \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="generic/platform=macOS" \
	  -configuration Release \
 	  -derivedDataPath $(DERIVED_BASE)/$(PROJECT_NAME) \
	  -sdk macosx \
 	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_ROOT=/ \
 	  SKIP_INSTALL=NO \
 	  ONLY_ACTIVE_ARCH=NO

install_app: dummy
	xcodebuild install \
	  -scheme JSTerminal \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="generic/platform=macOS" \
	  -configuration Release \
 	  -derivedDataPath $(DERIVED_BASE)/$(PROJECT_NAME) \
	  -sdk macosx \
 	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_ROOT=/ \
 	  SKIP_INSTALL=NO \
 	  ONLY_ACTIVE_ARCH=NO

dummy:

