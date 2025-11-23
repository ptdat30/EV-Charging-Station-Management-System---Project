#!/bin/sh
# Script to remove inter-service dependencies from pom.xml for Docker build

if [ -f pom.xml ]; then
    # Create backup
    cp pom.xml pom.xml.bak
    
    # Remove user-service and payment-service dependencies
    # This is a simple approach - remove lines between <dependency> and </dependency> that contain these artifacts
    awk '
    /<dependency>/{dep=1; buf=$0}
    /<\/dependency>/{if(dep){dep=0; if(buf !~ /user-service|payment-service/){print buf; print $0}} else print}
    !dep && !/<dependency>/{print}
    dep && !/<\/dependency>/{buf=buf"\n"$0}
    ' pom.xml.bak > pom.xml
fi



