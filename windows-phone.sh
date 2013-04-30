#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LANGUAGES=(
	"de:WordPress/Localization/LocalizedResources.de-DE.resx"
	"es:WordPress/Localization/LocalizedResources.es-ES.resx"
	"it:WordPress/Localization/LocalizedResources.it-IT.resx"
	"ja:WordPress/Localization/LocalizedResources.ja-JP.resx"
	"nl:WordPress/Localization/LocalizedResources.nl.resx"
	"pt-br:WordPress/Localization/LocalizedResources.pt-BR.resx"
	"pt:WordPress/Localization/LocalizedResources.pt-PT.resx"
	"sv:WordPress/Localization/LocalizedResources.sv-SE.resx"
	"th:WordPress/Localization/LocalizedResources.th-TH.resx"
)

mkdir -p $DIR/windowsphone
cd $DIR/windowsphone
svn co http://windowsphone.svn.wordpress.org/trunk

for language in "${LANGUAGES[@]}" ; do
	KEY=${language%%:*}
	VALUE=${language#*:}

	URL=http://translate.wordpress.org/api/projects/wordpress-for-windows-phone/development/$KEY/default/export-translations?format=resx

	A=$$; ( wget -q $URL -O $A.d && mv $A.d $DIR/windowsphone/trunk/$VALUE; echo "Downloaded: $KEY" ) || ( rm $A.d; echo "Failed downloading: $KEY" )
done

cd $DIR/windowsphone/trunk
svn ci -m "Updated language files"