#!/bin/sh 
for jarpath in `ls lib/*.jar`  
do  
   CLASSPATH=$CLASSPATH:$jarpath     
done
echo "$CLASSPATH"  
export CLASSPATH=$CLASSPATH:conf  
java -classpath "$CLASSPATH" -Dfile.encoding=utf-8 com.geor.gcr.vfs.AP &
