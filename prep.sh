#!/bin/bash
FILENAME=Tekkit1.2.zip
FOLDERNM="Template"
VARTMP="template.sh"
VARPMT="ServerStart.sh"
PROPTMP="server.properties.tmp"
PROPPMT="server.properties"
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

#checks if there is a current modpack installation
if [ -f "$FILENAME" ]; then
    echo "Installation Exists"
    rm -rf $VARPMT
    rm -rf $PROPPMT

    #Ensures there is a valid variable template file
    if [ -f "$VARTMP" ]; then
        cp $VARTMP $VARPMT
    else
        echo "Missing $VARTMP file: Unzipping modpack for replacement"
        unzip $FILENAME
        cp $VARPMT $VARTMP
    fi

    #Ensures there is a valid server.properties template file
    if [ -f "$PROPTMP" ]; then
        cp $PROPTMP $PROPPMT
    else
        echo "Missing $PROPTMP file: Unzipping modpack for replacement"
        unzip $FILENAME
        cp $PROPPMT $PROPTMP
    fi
else
    
    #If there is no installation, it downloads the modpack and creates the installation
    dl_modpack
    cp $VARPMT $VARTMP
    cp $PROPPMT $PROPTMP
fi

#creates eula.txt file to accept minecraft's EULA
rm -rf eula.txt
echo eula=true > eula.txt

#Sets Variables
echo ""
echo "Variables:"
sed 's%-Xms1024M -Xmx4096M%'"$JAVA_ARGS"'%' $VARPMT
sed -i 's%-Xms1024M -Xmx4096M%'"$JAVA_ARGS"'%' $VARPMT
sed -i 's%enable-rcon=false%enable-rcon=true%'
echo rcon.password=$RCON_PASS>>$PROPPMT
echo 'rcon.port=25575'>>$PROPPMT
echo 'broadcast-rcon-to-ops=false'>>$PROPPMT

#Changes permissions and starts server
chmod +x ServerStart.sh
source ServerStart.sh
