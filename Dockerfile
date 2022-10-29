# 2022/10 Michael Grate

FROM alpine:3.16.0

ENV BUILD_PACKAGES \
  bash \
  make \
  gcc \
  docker \
  openrc \
  docker-cli \
  libffi \
  libffi-dev \
  libc-dev \
  musl-dev \
  openssl-dev \
  python3-dev \
  rsync \
  curl \
  wget \
  tar \
  openssh-client \
  git \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-pip \
  py-yaml \
  jq \
  ca-certificates \
  zip


ENV PYTHON_PACKAGES \
    pip \
    boto3 \
    pyyaml \
    yamllint \
    j2cli

ENV TERRAFORM_VERSION="1.3.3"
ENV PACKER_VERSION="1.8.4"

# General packages
RUN set -x && \
    echo "==> Upgrading packages and system..."  && \
    apk update && \
    apk upgrade && \
    echo "==> Installing packages..."  && \
    apk add ${BUILD_PACKAGES}

# Python 3
RUN echo "==> Install Python 3..."  && \
    apk add python3 py3-pip && \
    echo "==> Install Python-pip packages" && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip; fi && \
    pip3 install --upgrade pip --user && \
    python3 -m pip install --user --upgrade ${PYTHON_PACKAGES}

# J2
RUN echo "==> Checking J2 Installation..."  && \
    pip3 --version && \
    ls -al /root/.local/bin && \
    chmod 775 -R /root/.local/bin/j2 && \
    ln -s /root/.local/bin/j2 /usr/bin/j2 && \
    j2 --version

# GlibC AWS CLI Dependency
ENV GLIBC_VER=2.31-r0

# AWS CLI v2 Installation # Reference: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# install glibc compatibility for alpine
# release-cli installaion: https://docs.gitlab.com/ee/user/project/releases/release_cli.html
RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk \
    && apk add --no-cache --force-overwrite \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        glibc-i18n-${GLIBC_VER}.apk \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest \
    && chmod +x /usr/local/bin/ecs-cli \
    && curl -Lo /usr/local/bin/release-cli https://release-cli-downloads.s3.amazonaws.com/latest/release-cli-linux-amd64 \
    && chmod +x /usr/local/bin/release-cli \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/current/dist/aws_completer \
        /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/current/dist/awscli/examples \
        glibc-*.apk \
    && find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete \
    && apk --no-cache del \
        binutils \
        curl \
    && rm -rf /var/cache/apk/*

RUN rm -rf /root/.cache

# Terraform # Reference: https://www.terraform.io/downloads
RUN echo "==> Install Terraform..."  && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    chmod 755 /usr/bin/terraform && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Packer Installation # Reference: https://www.packer.io/downloads
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin && chmod 755 /usr/bin/packer && rm packer_${PACKER_VERSION}_linux_amd64.zip

# Tell us what versions of software we're using.
RUN python3 --version \
        && aws --version \
        && terraform --version \
        && packer --version

# Location where builds occur
WORKDIR /build

# Configure the SSH agent when .bashrc file is read
RUN echo 'eval $(ssh-agent)' >> /root/.bashrc

ENTRYPOINT ["/bin/bash","-l","-c"]

