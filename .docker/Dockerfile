FROM ruby:3.3.0-bookworm

# apt
RUN echo 'deb http://ftp.fr.debian.org/debian/ unstable main contrib non-free' > /etc/apt/sources.list
RUN apt-get update -yqq

# USER
ARG user="appuser"
ENV USER $user
RUN echo "USER=$USER" > /etc/profile.d/user.sh
RUN useradd -m $USER -s /bin/bash
RUN apt-get install -yqq sudo
RUN echo "$USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# entrypoint
COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /app

COPY ../. .

RUN chown -R $USER: /app

# PDF_PATH
ARG pdf_path
ENV PDF_PATH $pdf_path

# bundler
ARG BUNDLER_VERSION="2.5.6"
ENV BUNDLER_VERSION $BUNDLER_VERSION
RUN su -c "gem install bundler --no-document -v $BUNDLER_VERSION" $USER
RUN su -c "bundle install" $USER

ENTRYPOINT []

CMD ["/usr/bin/entrypoint.sh", "--rotate"]

