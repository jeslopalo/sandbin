#!/bin/bash

# Exists functions

function mvn.exists_pom()
{
	local pom_path="$1"
	local pom_filename="pom.xml"

	[ -f "$pom_path/$pom_filename" ] && echo "true";
}

function mvn.exists_release_file()
{
	local artifact_name="$1"
	local pom_path="$2"

	[ $(mvn.exists_pom "$pom_path") ] && echo $(ls target/*$artifact_name*.jar &> /dev/null;) || $(ls target/*$artifact_name*.war &> /dev/null;)
}


# mvn utils

function mvn.build.version()
{
	echo $1 | sed -e "s/-SNAPSHOT//i" | sed -e "s/-RELEASE//i"	
}

function mvn.build.release_version()
{
	version=$(mvn.build.version $1)
	echo "$version-RELEASE"
}

function mvn.build.snapshot_version()
{
	version=$(mvn.build.version $1)
	if [[ "$version" = "" ]]; then
		echo "$(date +"%Y.%m.%d")-SNAPSHOT"
	else
		echo "$version-SNAPSHOT"		
	fi
}

# mvn properties

function mvn.project.packaging()
{
	local pom_path="$1"	

	[ $(mvn.exists_pom "$pom_path") ] && echo "$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.packaging | grep -v '\[')"
}

function mvn.project.artifactId()
{
	local pom_path="$1"

	[ $(mvn.exists_pom "$pom_path") ] && echo "$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.artifactId | grep -v '\[')"
}

function mvn.project.version()
{
	local pom_path="$1"

	[ $(mvn.exists_pom "$pom_path") ] && echo "$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | grep -v '\[')"
}

function mvn.project.description()
{
	local pom_path="$1"

	[ $(mvn.exists_pom "$pom_path") ] && echo "$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.description | grep -v '\[')"
}
