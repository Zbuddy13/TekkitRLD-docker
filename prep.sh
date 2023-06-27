#!/bin/bash
FILENAME=Tekkit1.2.zip
FOLDERNM="Template"
VARTMP="template.sh"
VARPMT="ServerStart.sh"
URL="https://www.curseforge.com/api/v1/mods/348969/files/2823160/download"

#Function to download modpack
dl_modpack() {
    curl -L $URL -o $FILENAME
    unzip $FILENAME
    mv "$FOLDERNM"/* .
    rm -rf "$FOLDERNM"
}

#Moves into data directory
cd /data

#creates eula.txt file to accept minecraft's EULA
echo eula=true > eula.txt

#checks if there is a current modpack installation
if [ -f "$FILENAME" ]; then
    echo "Installation Exists"
    rm -rf $VARPMT

    #Ensures there is a valid variable template file
    if [ -f "$VARTMP" ]; then
        cp $VARTMP $VARPMT
    else
        echo "Missing $VARPMT file: Downloading modpack for replacement"
        dl_modpack
        cp $VARPMT $VARTMP
    fi
else
    
    #If there is no installation, it downloads the modpack and creates the installation
    dl_modpack
    cp $VARPMT $VARTMP
fi

#Sets Variables
echo ""
echo "Variables:"
sed 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' $VARPMT
sed -i 's%JAVA_ARGS=""%JAVA_ARGS="'"$JAVA_ARGS"'"%' $VARPMT

#Changes permissions and starts server
chmod +x start.sh
source start.sh