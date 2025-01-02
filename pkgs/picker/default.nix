{ stdenv, fetchFromGitHub # 废话
, cmake # 使用cmake进行构建
, swig, python3 }:

let
  version = "1.0";
  pname = "picker";
  xcomm_src = fetchFromGitHub {
    owner = "XS-MLVP";
    repo = "xcomm";
    rev = "master";
    sha256 = "sha256-teb1+OF3sy662lOXOMXTv6DhrDFqxGKAGevrmSRdwKQ=";
  };

in stdenv.mkDerivation {
  # inherit version pname ;
  name = "${pname}-${version}";

  # 从 GitHub 下载源代码
  src = fetchFromGitHub ({
    owner = "XS-MLVP";
    repo = "picker";
    rev = "master";
    sha256 = "sha256-RThhq3NwxqK13tQa5lCfS1bYqMjFh0mcf9bPSkX7ca4=";
  });

  dontFixCmake = true;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ swig python3 ];

  patchPhase = ''
    # Create the destination directory: dependence/xcomm
    mkdir -p dependence/xcomm

    # Copy xcomm source
    cp -r ${xcomm_src}/* dependence/xcomm
  '';
  preConfigure = ''
    # Create the build directory
    # mkdir -p build
    export BUILD_XSPCOMM_SWIG=python
  '';
}
