# Makefile for building the slides will go here.

# use locally-installed tools
NPM_BIN := node_modules/.bin/
UGLIFY := $(addprefix $(NPM_BIN), uglifyjs)
LESS := $(addprefix $(NPM_BIN), lessc)
BROWSERIFY := $(addprefix $(NPM_BIN), browserify)
JSHINT := $(addprefix $(NPM_BIN), jshint)

# variables!
INPUT_DIR = assets
OUTPUT_DIR = out-make

# CSS setup
LESSOPTS =
LESSDIR := $(INPUT_DIR)/less
CSSDIR := $(OUTPUT_DIR)/css

LESSFILES := $(wildcard $(LESSDIR)/**/*.less)
CSS := $(patsubst $(LESSDIR)%, $(CSSDIR)%, $(patsubst %.less,%.css,$(LESSFILES)))
MINCSS = $(CSS:.css=.min.css)

# javascript setup
JSDIR = $(INPUT_DIR)/js
JS_SRCS := $(wildcard $(JSDIR)/*.js)
JS_TARGETS := $(patsubst $(JSDIR)%, $(OUTPUT_DIR)%, $(JS_SRCS))

# now the build rules

all: dirs css js
.PHONY : all dirs css js
.SUFFIXES:

dirs:
	@mkdir -p $(OUTPUT_DIR)

css: dirs $(CSS) $(MINCSS)

$(CSSDIR)/%.css : $(LESSDIR)/%.less
	@echo Compiling $<
	@$(LESS) $< > $@

$(CSSDIR)/%.min.css : $(LESSDIR)/%.less
	@echo Minifying $<
	@$(LESS) $(LESSOPTS) --yui-compress $< > $@

lint: $(JS_SRCS)
	@$(JSHINT) $(JS_SRCS)
	@echo OK

js: dirs $(JS_TARGETS)

$(OUTPUT_DIR)/%.js : $(JSDIR)/%.js
	@$(BROWSERIFY) $< -o $@

%.min.js: %.js
	@echo Minifying $<
	@$(UGLIFY) --no-mangle -nc $< > $@
