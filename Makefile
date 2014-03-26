COMPONENT=$(shell pwd)/node_modules/.bin/component
NPM=npm
DIR=.dirstamp
LOCAL_COMPONENTS=$(shell echo local/*/component.json)
BUILD_MINIFY=true


default: $(DIR)


# set up the environment
env: $(DIR)
	@echo 'setting up the environment'

$(DIR): node_modules/$(DIR) components/$(DIR)
	@>$@

# install node deps
node_modules/$(DIR): package.json
	@echo 'installing node modules'
	@$(NPM) i
	@>$@

$(COMPONENT): node_modules/$(DIR)

# install component deps
components/$(DIR): component.json $(COMPONENT) $(LOCAL_COMPONENTS)
	@echo 'installing components'
	@$(COMPONENT) install
	@>$@

# build assets
build: $(DIR)
	@echo 'building the assets'
	@MINIFY=$(BUILD_MINIFY) ./bin/build

# run dev server
srv: $(DIR)
	@./bin/srv

# cleanup
clean_build:
	@echo 'cleaning up built assets'
	@rm -rf build

clean_node:
	@echo 'cleaning up node modules'
	@rm -rf node_modules

clean_component:
	@echo 'cleaning up components'
	@rm -rf components

clean_all: clean_build clean_node clean_component

clean: clean_build


.PHONY: env srv build clean clean_all clean_build clean_node clean_component
