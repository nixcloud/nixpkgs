{ stdenv, python3Packages, libmaxminddb }:

python3Packages.buildPythonPackage rec {
  pname = "geoip2";
  version = "2.9.0";
  name = "${pname}-${version}";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1w7cay5q6zawjzivqbwz5cqx1qbdjw6kbriccb7l46p7b39fkzzp";
  };

  #patchPhase = ''
  #  substituteInPlace requirements.txt --replace requests "#requests"
  #'';

  propagatedBuildInputs = with python3Packages; [ python3Packages.requests python3Packages.maxminddb ];

  meta = with stdenv.lib; {
    description = "Python geospatial data analysis framework";
    homepage = http://www.maxmind.com/;
    license = licenses.asl20;
    maintainers = with maintainers; [ leenaars ];
  };
}
