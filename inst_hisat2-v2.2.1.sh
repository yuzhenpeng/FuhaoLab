#!/bin/bash
source FuhaoLab.conf
### https://daehwankimlab.github.io/hisat2/
### https://github.com/DaehwanKimLab/hisat2


PackageName="hisat2"
PackageVers="v2.2.1"
InternetLink="https://github.com/DaehwanKimLab/hisat2/archive/v2.2.1.tar.gz"
NameUncompress="hisat2-2.2.1"
TestCmd="./hisat2 --help"


NameCompress=$PackageName-$PackageVers.tar.gz
CheckPath $PackageName $PackageVers
DownloadWget $InternetLink $NameCompress
if [ ! -d $NameUncompress ]; then
	RunCmds "tar xzvf $NameCompress"
fi

cd ${PROGPATH}/$PackageName/$PackageVers
DeletePath "${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
RunCmds "mv ${PROGPATH}/$PackageName/$PackageVers/$NameUncompress ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE"
cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
RunCmds "make hisat2-align-s hisat2-build-s hisat2-inspect-s"

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/bin
$TestCmd
if [ $? -ne 0 ]; then
	echo "Error: failed to install $PackageName-$PackageVers" >&2
	exit 100
fi

cd ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE
AddEnvironVariable ${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE "$PackageName-$PackageVers"
AddBashrc "export PATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/scripts:\$PATH"
AddBashrc "export PYTHONPATH=\${PROGPATH}/$PackageName/$PackageVers/$MACHTYPE/hisat2lib/pymodule:\$PYTHONPATH"

exit 0
