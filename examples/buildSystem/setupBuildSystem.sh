echo "== Moving to *build* directory - creating if needed"
mkdir -p build
cd build


###
echo "== Installing Packages"
conan install .. --build missing


###
echo "== Making build system"

# TODO - remove the DCONAN_DISABLE_CHECK_COMPILER flag
#        - some issue giving error:
#          "CMake Error at build/conanbuildinfo.cmake:151 (message):
#          "  Incorrect 'gcc' version 'compiler.version=5.3' is not the one detected by
#          "  CMake: 'GNU=5.4'
#        - flag options from https://github.com/conan-io/conan/issues/138)
#        - possible releated issues:
#          - https://github.com/conan-io/conan/issues/199
#          - https://github.com/conan-io/conan/issues/178
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCONAN_DISABLE_CHECK_COMPILER=On


###
echo "== Autobuilding (smoke test)"

cmake --build . --config Release

###
echo "== Return to child directory"
cd ..
