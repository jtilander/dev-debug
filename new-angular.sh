#!/bin/bash

# Crete some scaffolding. Answer some questions.
# Most commonly:
#  * Use grunt
#  * Disable compass
#  * Minimal angular modules
yo angular

# Disable the karma test since it's too hard to install here.
sed -i -e "s/tasks: \['newer:jshint:test', 'newer:jscs:test', 'karma'\]/tasks: ['newer:jshint:test', 'newer:jscs:test']/g" Gruntfile.js
sed -i -e "s/'connect:test',/'connect:test'/g" Gruntfile.js
sed -i -e "s/'karma'$//g" Gruntfile.js

# Ensure that we can tunnel through the docker network
sed -i -e "s/hostname: 'localhost'/hostname: '0.0.0.0'/g" Gruntfile.js
