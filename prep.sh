#!/bin/bash
FILENAME=Tekkit1.2.zip
FOLDERNM="Template"
VARTMP="template.sh"
VARPMT="ServerStart.sh"
PROPTMP="server.properties.tmp"
PROPPMT="server.properties"
EULA="eula=true"
URL="https://www.curseforge.com/api/v1/mods/348969/files/2823160/download"

#Function to download modpack
dl_modpack() {
    curl -L $URL -o $FILENAME
}

unzip_modpack() {
    unzip $FILENAME
    mv "$FOLDERNM"/* .
    rm -rf "$FOLDERNM"
}

#Moves into data directory
cd /data

if [ -e "$FILENAME" ]; then
    echo "Installation Exists"
    #rm -rf $VARPMT
    #rm -rf $PROPPMT

    #Ensures there is a valid variable template file
    if [ -e "$VARTMP" ]; then
        echo "Template Exists"
        #cp $VARTMP $VARPMT
    else
        echo "Missing $VARTMP file: Unzipping modpack for replacement"
        unzip_modpack
        cp $VARPMT $VARTMP
    fi

    #Ensures there is a valid server.properties template file
    if [ -e "$PROPTMP" ]; then
        echo "Properties Exists"
        #cp $PROPTMP $PROPPMT
    else
        echo "Missing $PROPTMP file: Unzipping modpack for replacement"
        unzip_modpack
        cp $PROPPMT $PROPTMP
    fi
fi

#creates eula.txt file to accept minecraft's EULA

#while IFS= read -r line; do
#    echo "$line"
#done < eula.txt

read -r line<eula.txt

#echo "$line"

if [[ "$line" == "$EULA" ]]; then
    echo "Eula True Exists"
    else
        echo "Creating Eula"
        rm -rf eula.txt
        echo eula=true > eula.txt
fi

#Sets Variables
echo ""
echo "Variables:"
sed 's%-Xms1024M -Xmx4096M%'"$JAVA_ARGS"'%' $VARPMT
sed -i 's%-Xms1024M -Xmx4096M%'"$JAVA_ARGS"'%' $VARPMT
sed -i 's%enable-rcon=false%enable-rcon=true%' $PROPPMT
echo rcon.password=$RCON_PASS>>$PROPPMT
echo 'rcon.port=25575'>>$PROPPMT
echo 'broadcast-rcon-to-ops=false'>>$PROPPMT

#Changes permissions and starts server
chmod +x ServerStart.sh
source ServerStart.sh
