#! /bin/bash

NAME="${PROJECT}-${VERSION}.high_sierra.bottle.tar.gz"

mkdir -p ${PROJECT}/${VERSION}/opt/enumivo_cdt/lib/cmake

PREFIX="${PROJECT}/${VERSION}"
SPREFIX="\/usr\/local"
SUBPREFIX="opt/${PROJECT}"
SSUBPREFIX="opt\/${PROJECT}"

export PREFIX
export SPREFIX
export SUBPREFIX
export SSUBPREFIX

bash generate_tarball.sh ${NAME}

hash=`openssl dgst -sha256 ${NAME} | awk 'NF>1{print $NF}'`

echo "class EnumivoCdt < Formula

   homepage \"${URL}\"
   revision 0
   url \"https://github.com/enumivo/enumivo.cdt/archive/v${VERSION}.tar.gz\"
   version \"${VERSION}\"
   
   option :universal

   depends_on \"cmake\" => :build
   depends_on \"automake\" => :build
   depends_on \"libtool\" => :build
   depends_on \"wget\" => :build
   depends_on \"gmp\" => :build
   depends_on \"gettext\" => :build
   depends_on \"doxygen\" => :build
   depends_on \"graphviz\" => :build
   depends_on \"lcov\" => :build
   depends_on :xcode => :build
   depends_on :macos => :high_sierra
   depends_on :arch =>  :intel
  
   bottle do
      root_url \"https://github.com/enumivo/enumivo.cdt/releases/download/v${VERSION}\"
      sha256 \"${hash}\" => :high_sierra
   end
   def install
      raise \"Error, only supporting binary packages at this time\"
   end
end
__END__" &> enumivo.cdt.rb

rm -r ${PROJECT}
