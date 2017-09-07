FROM aquaron/anf
MAINTAINER Paul Pham <docker@aquaron.com>

RUN apk add --no-cache \
  curl \
  libxml2-dev \

&& cd /tmp \
  && curl -L https://www.imagemagick.org/download/ImageMagick.tar.gz | tar xzvf - \
  && _imagemagick="$(ls -d Image*)" \
  && cd $_imagemagick \
  && ./configure -with-perl; make -j3; make install-strip; ldconfig /usr/local/lib \
  && cd ..; rm -r $_imagemagick \

&& cpanm -n \
 Plack \
 Net::SSLeay \
 Flickr::API \
 Flickr::Upload \
 Net::Twitter \
 WWW::Facebook::API \
 LWP::Authen::OAuth \
 PDF::API2 \
 XML::RSS \
 XML::FeedPP \
 Crypt::DES \
 Crypt::Blowfish \
 DateTime::Format::W3CDTF \
 String::Random \
 Text::CSV \
 Archive::Zip \

&& rm -rf /root/.cpanm \
&& apk del g++ gcc curl make perl-dev expat-dev libxml2-dev \
&& apk add --no-cache --virtual .gettext gettext \
&& mv /usr/bin/envsubst /tmp/ \
&& runDeps="$( \
    scanelf --needed --nobanner /usr/local/bin/magick /usr/local/lib/*.so /tmp/envsubst \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
   )" \
&& apk add --no-cache $runDeps expat \
&& apk del .gettext \
&& mv /tmp/envsubst /usr/local/bin/ \

&& perl -MImage::Magick -le 'print "Image::Magick Installation Quantum Depth: " . Image::Magick->QuantumDepth'
