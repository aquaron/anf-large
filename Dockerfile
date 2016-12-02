FROM aquaron/anf
MAINTAINER Paul Pham <docker@aquaron.com>

RUN apk add --no-cache \
 openssl \
 libxml2-dev \
 imagemagick-dev \

&& cpanm -n \
 Net::SSLeay \
 Flickr::API \
 Flickr::Upload \
 Net::Twitter \
 WWW::Facebook::API \
 LWP::Authen::OAuth \
 PDF::API2 \
 Image::Magick \
 XML::RSS \
 XML::FeedPP \
 Crypt::DES \
 DateTime::Format::W3CDTF \

&& rm -rf /root/.cpanm \
&& apk del g++ gcc make perl-dev expat-dev 

