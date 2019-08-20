#!/bin/bash

base=`pwd`
path=$base/omp-deploy/omp

function boot(){
	if test -d $path
	then
		rm -rf $path
		echo "clean success !"
	else
		echo "No folder to need to delete !"
	fi	
}

boot

sleep 6s
