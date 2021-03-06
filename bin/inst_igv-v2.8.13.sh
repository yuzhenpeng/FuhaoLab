#!/bin/bash
source FuhaoLab.conf


PackageName="igv"
PackageVers="v2.8.13"
InternetLink="https://data.broadinstitute.org/igv/projects/downloads/2.8/IGV_2.8.13.zip"
NameUncompress="IGV_Linux_2.8.13"
#TestCmd="./bowtie --help"

CmdExit 'java'

NameCompress=$PackageName-$PackageVers.zip
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	DecompressFile $NameCompress
fi
DeletePath ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
if [ ! -x igv.sh ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
ln -sf ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/igv.sh ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/igv
AddBashrc "### $PackageName-$PackageVers"
AddBashrc "export PATH=${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE:\$PATH"
ModuleAppend "prepend-path    PATH    ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"

exit 0
