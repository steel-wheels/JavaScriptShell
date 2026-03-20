# install_xc.mk

PROJECT_NAME	?= JavaScriptShell
DERIVED_BASE	= $(HOME)/build/derived-data/
PRODUCT_PATH	= Build/Products/Release

all: install

clean:
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_macOS)
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_iOS)
	(cd $(DERIVED_BASE) && rm -rf $(PROJECT_NAME)_iOS_sim)
	(cd $(HOME)/Library/Frameworks && rm -rf $(PROJECT_NAME).xcframework)

install: dummy
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

dummy:

