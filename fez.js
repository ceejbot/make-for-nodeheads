#!/usr/bin/env node

var
	fez        = require('fez'),
	browserify = require('fez-browserify'),
	concat     = require('fez-concat'),
	jshint     = require('fez-jshint'),
	less       = require('fez-less'),
	path       = require('path'),
	uglify     = require('fez-uglify')
	;

var outdir = 'out-fez';
var inputdir = 'assets';

var jsFiles = fez.glob('assets/js/*.js');

exports.lint = function(stage)
{
	stage(function(rule)
	{
		rule(jsFiles, jshint(), { always: true});
	});

};

exports.js = function(stage)
{
	stage(function(rule)
	{
		rule(jsFiles, path.join(outdir, 'dist.min.js'), concat(), uglify());
	});
};



exports.default = exports.lint;
fez(module);
