FROM ubuntu:22.04
ENV star_version 2.7.10a

LABEL description="Image for STAR aligner version 2.7.10a"

ARG USER_ID
ARG GROUP_ID

RUN echo $USER_ID $GROUP_ID
RUN groupadd --gid $GROUP_ID docker && useradd -lm --gid docker --uid $USER_ID docker

RUN apt-get update && apt-get -y install --no-install-recommends build-essential zlib1g-dev libgomp1 \
 && rm -rf /var/cache/apt/*

RUN for i in \
    /srv \
    /srv/input \
    /srv/output \
    /srv/star \
    ; do mkdir -p $i && chown -R docker:docker $i; done
ADD https://github.com/alexdobin/STAR/archive/${star_version}.tar.gz /srv/star
RUN chown docker:docker /srv/star/${star_version}.tar.gz
USER docker

WORKDIR /srv/star
RUN tar -xzf ${star_version}.tar.gz
WORKDIR /srv/star/STAR-${star_version}/source
RUN make && mv STAR /srv/star

WORKDIR /srv/star
