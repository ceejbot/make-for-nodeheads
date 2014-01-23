# Makefile for building the slides will go here.

# use locally-installed tools
NPM_BIN := node_modules/.bin/
UGLIFY := $(addprefix $(NPM_BIN), uglifyjs)
LESS := $(addprefix $(NPM_BIN), lessc)
BROWSERIFY := $(addprefix $(NPM_BIN), browserify)

# CSS setup
LESSOPTS := --include-path=bower_components/bootstrap/less
LESSDIR := $(INPUT_DIR)/less
CSSDIR := $(OUTPUT_DIR)/css

LESSFILES := $(wildcard $(LESSDIR)/*.less)
LESSDEPS := $(LESSFILES) $(wildcard $(LESSDIR)/**/*.less)
CSS := $(patsubst $(LESSDIR)%, $(CSSDIR)%, $(patsubst %.less,%.css,$(LESSFILES)))
MINCSS = $(CSS:.css=.min.css)


# now the build rules

all:  css js

css: $(CSS) $(MINCSS)

$(CSSDIR)/%.css : $(LESSDIR)/%.less $(LESSDEPS)
	@echo Compiling $<
	@$(LESS) $(LESSOPTS) $< > $@

$(CSSDIR)/%.min.css : $(LESSDIR)/%.less
	@echo Minifying $<
	@$(LESS) $(LESSOPTS) --yui-compress $< > $@

js: $(JS_TARGETS)
	@echo Just copying js files for now...

$(JSDIR)/%.js : $(JSSRCDIR)/%.js
	@cp $< $@

%.min.js: %.js
	@echo Minifying $<
	@$(UGLIFY) --no-mangle -nc $< > $@
