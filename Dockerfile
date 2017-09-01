FROM aquaron/anf
MAINTAINER Paul Pham <docker@aquaron.com>

RUN apk add --no-cache \
  curl \
  libxml2-dev \

&& cd /tmp \
  && curl -L https://www.imagemagick.org/download/ImageMagick.tar.gz | tar xzvf - \
  && cd "$(ls -d Image*)" \
  && ./configure -with-perl; make; make install; ldconfig /usr/local/lib \
  && perl -MImage::Magick -le 'print "Success: " . Image::Magick->QuantumDepth' \

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
&& apk del g++ gcc make perl-dev expat-dev curl

