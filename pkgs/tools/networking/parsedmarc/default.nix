{ stdenv, python3, python3Packages, elasticsearch, kibana, pkgs }:

python3Packages.buildPythonPackage rec {
  pname = "parsedmarc";
  version = "3.8.0";
  name = "${pname}-${version}";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0mff62xpqainb8msbf3448cs1gl6hdg8j84hak8k8ziwww34hxgr";
  };

  propagatedBuildInputs = with python3Packages; [ 
    IMAPClient
    mail-parser
    python3Packages.geoip2
    pygeoip
    dnspython
    dateparser
    python3Packages.elasticsearch 
    python3Packages.elasticsearchdsl
    requests 
    publicsuffix 
    xmltodict
    flake8 
    sphinx
    sphinx_rtd_theme 
    wheel 
    kibana 
    simplejson 
    six
  ];

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
