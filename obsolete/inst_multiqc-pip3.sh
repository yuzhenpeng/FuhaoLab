#!/bin/bash
source FuhaoLab.conf
#https://multiqc.info/
#https://github.com/ewels/MultiQC

PythonModules2install="multiqc"

if CheckPythonModules $PythonModules2install; then
	echo "Info: $PythonModules2install installed, now checking upgrades"
	pip3 install --user -U $PythonModules2install
else
	pip3 install --user $PythonModules2install
fi

exit 0
