{ stdenv, python3, elasticsearch, kibana, pkgs }:

with python3.pkgs;

buildPythonPackage rec {
  pname = "parsedmarc";
  version = "3.8.0";
  name = "${pname}-${version}";

  disabled = with python3.pkgs; isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "0mff62xpqainb8msbf3448cs1gl6hdg8j84hak8k8ziwww34hxgr";
  };

  propagatedBuildInputs = [
    requests dnspython publicsuffix xmltodict dnspython IMAPClient
    mail-parser dateparser elasticsearch elasticsearchdsl flake8 sphinx
    sphinx_rtd_theme wheel kibana geoip2 simplejson six
  ];

  configurePhase = ''
    echo -x
    export
    declare -x PYTHONPATH="${stdenv.lib.makeSearchPathOutput "lib"
    "lib/${pkgs.python3.libPrefix}/site-packages" [
    python3.pkgs.setuptools
    python3.pkgs.wheel
    python3.pkgs.IMAPClient
    python3.pkgs.mail-parser
    python3.pkgs.geoip2
    python3.pkgs.dnspython
    python3.pkgs.dateparser
    python3.pkgs.elasticsearch
    python3.pkgs.elasticsearchdsl
    python3.pkgs.xmltodict
    python3.pkgs.publicsuffix
    python3.pkgs.simplejson
    python3.pkgs.six
    python3.pkgs.maxminddb
    python3.pkgs.tzlocal
    python3.pkgs.dateutil
    python3.pkgs.regex
    python3.pkgs.pytz
    python3.pkgs.urllib3
    python3.pkgs.requests
    python3.pkgs.chardet
    python3.pkgs.certifi
    python3.pkgs.idna

    ]  }";
  '';

  meta = with stdenv.lib; {
    homepage = https://domainaware.github.io/parsedmarc;
    description = "DMARC report processing";
    longDescription = ''
      parsedmarc is a Python module and CLI utility for parsing DMARC
      reports. When used with Elasticsearch and Kibana, it works as a
      self-hosted open source alternative to commercial DMARC report
      processing services such as Agari, Dmarcian, and OnDMARC.

      Features:

      - Parses draft and 1.0 standard aggregate/rua reports
      - Parses forensic/failure/ruf reports
      - Can parse reports from an inbox over IMAP
      - Transparently handles gzip or zip compressed reports
      - Consistent data structures
      - Simple JSON and/or CSV output
      - Optionally email the results
      - Optionally send the results to Elasticsearch, for use with premade Kibana dashboards
    '';
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ leenaars ];
  };
}
