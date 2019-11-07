FROM google/dart

WORKDIR /tvc_crawler

ADD pubspec.yaml /tvc_crawler/
RUN pub get
ADD . /tvc_crawler
RUN pub get --offline
CMD []
ENTRYPOINT ["/usr/bin/dart", "bin/main.dart"]
