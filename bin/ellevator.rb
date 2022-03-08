#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
libpath = Pathname.new(File.dirname(__FILE__)).join('..', 'lib').to_s
$LOAD_PATH.unshift libpath

