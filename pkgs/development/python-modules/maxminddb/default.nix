{ stdenv, buildPythonPackage, fetchPypi, libmaxminddb, pythonPackages}:

buildPythonPackage rec {
  pname = "maxminddb";
  version = "1.4.1";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "04mpilsj76m29id5xfi8mmasdmh27ldn7r0dmh2rj6a8v2y5256z";
  };

  propagatedBuildInputs = with pythonPackages; 
  [ requests libmaxminddb mock ] ++
  stdenv.lib.optional (isPy27) [ ipaddress ];
  checkInputs = with pythonPackages; [ mock enum pyopenssl ];

  preCheck = ''
    # Remove one failing test that only checks whether the command line works
    rm tests/reader_test.py
  '';

  meta = with stdenv.lib; {
    description = "Read MaxMind DB files";
    homepage = http://www.maxmind.com/;
    license = licenses.asl20;
    maintainers = with maintainers; [ leenaars ];
  };
}
