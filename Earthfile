VERSION 0.6
ARG UBUNTU_RELEASE=focal
FROM mcr.microsoft.com/vscode/devcontainers/base:0-$UBUNTU_RELEASE
ARG DEVCONTAINER_IMAGE_NAME_DEFAULT=haxe/terraform_devcontainer_workspace

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# https://github.com/docker-library/mysql/blob/master/5.7/Dockerfile.debian
mysql-public-key:
    ARG KEY=859BE8D7C586F538430B19C2467B942D3A79BD29
    RUN gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$KEY"
    RUN gpg --batch --armor --export "$KEY" > mysql-public-key
    SAVE ARTIFACT mysql-public-key AS LOCAL .devcontainer/mysql-public-key

devcontainer-base:
    ARG TARGETARCH

    # Avoid warnings by switching to noninteractive
    ENV DEBIAN_FRONTEND=noninteractive

    ARG INSTALL_ZSH="false"
    ARG UPGRADE_PACKAGES="true"
    ARG ENABLE_NONROOT_DOCKER="true"
    ARG USE_MOBY="true"
    COPY .devcontainer/library-scripts/*.sh /tmp/library-scripts/
    RUN apt-get update \
        && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
        # Use Docker script from script library to set things up
        && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}" \
        # Clean up
        && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

    # +mysql-public-key
    COPY .devcontainer/mysql-public-key /tmp/mysql-public-key
    RUN apt-key add /tmp/mysql-public-key

    # Configure apt and install packages
    RUN apt-get update \
        && apt-get install -y --no-install-recommends apt-utils dialog 2>&1 \
        && apt-get install -y \
            iproute2 \
            procps \
            sudo \
            bash-completion \
            build-essential \
            curl \
            wget \
            software-properties-common \
            direnv \
            tzdata \
            python3-pip \
            jq \
        && add-apt-repository ppa:git-core/ppa \
        && apt-get install -y git \
        && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
        && apt-get install -y nodejs=14.* \
        && add-apt-repository ppa:haxe/haxe4.2 \
        && apt-get install -y neko haxe \
        # install kubectl
        && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
        && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
        && apt-get update \
        && apt-get -y install --no-install-recommends kubectl \
        # install helm
        && curl -fsSL https://baltocdn.com/helm/signing.asc | apt-key add - \
        && echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
        && apt-get update \
        && apt-get -y install --no-install-recommends helm \
        # Install mysql-client
        # https://github.com/docker-library/mysql/blob/master/5.7/Dockerfile.debian
        && echo 'deb http://repo.mysql.com/apt/ubuntu/ bionic mysql-5.7' > /etc/apt/sources.list.d/mysql.list \
        && apt-get update \
        && apt-get -y install mysql-client=5.7.* \
        #
        # Clean up
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*

    RUN mkdir -m 777 "/workspace"

    # Switch back to dialog for any ad-hoc use of apt-get
    ENV DEBIAN_FRONTEND=

    # Setting the ENTRYPOINT to docker-init.sh will configure non-root access 
    # to the Docker socket. The script will also execute CMD as needed.
    ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
    CMD [ "sleep", "infinity" ]
    WORKDIR /workspace

# Usage:
# RUN /aws/install
awscli:
    FROM +devcontainer-base
    RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/tmp/awscliv2.zip" \
        && unzip -qq /tmp/awscliv2.zip -d / \
        && rm /tmp/awscliv2.zip
    SAVE ARTIFACT /aws

# Usage:
# COPY +doctl/doctl /usr/local/bin/
doctl:
    ARG TARGETARCH
    ARG DOCTL_VERSION=1.66.0
    RUN curl -fsSL "https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-${TARGETARCH}.tar.gz" | tar xvz -C /usr/local/bin/
    SAVE ARTIFACT /usr/local/bin/doctl

github-src:
    ARG --required REPO
    ARG --required COMMIT
    ARG DIR=/src
    WORKDIR $DIR
    RUN curl -fsSL "https://github.com/${REPO}/archive/${COMMIT}.tar.gz" | tar xz --strip-components=1 -C "$DIR"
    SAVE ARTIFACT "$DIR"

# Usage:
# COPY +terraform-ls/terraform-ls /usr/local/bin/
terraform-ls:
    ARG --required TARGETARCH
    ARG TERRAFORM_LS_VERSION=0.28.0
    RUN curl -fsSL -o terraform-ls.zip https://github.com/hashicorp/terraform-ls/releases/download/v${TERRAFORM_LS_VERSION}/terraform-ls_${TERRAFORM_LS_VERSION}_linux_${TARGETARCH}.zip \
        && unzip -qq terraform-ls.zip \
        && mv ./terraform-ls /usr/local/bin/ \
        && rm terraform-ls.zip
    SAVE ARTIFACT /usr/local/bin/terraform-ls

# Usage:
# COPY +tfk8s/tfk8s /usr/local/bin/
tfk8s:
    FROM golang:1.17
    RUN go install github.com/jrhouston/tfk8s@v0.1.7
    SAVE ARTIFACT /go/bin/tfk8s

cert-manager.crds:
    FROM +devcontainer
    RUN curl -fsSL https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.crds.yaml \
        | tfk8s --output cert-manager.crds.tf
    SAVE ARTIFACT --keep-ts cert-manager.crds.tf AS LOCAL cert-manager.crds/cert-manager.crds.tf

# Usage:
# COPY +earthly/earthly /usr/local/bin/
# RUN earthly bootstrap --no-buildkit --with-autocomplete
earthly:
    FROM +devcontainer-base
    ARG --required TARGETARCH
    RUN curl -fsSL https://github.com/earthly/earthly/releases/download/v0.6.15/earthly-linux-${TARGETARCH} -o /usr/local/bin/earthly \
        && chmod +x /usr/local/bin/earthly
    SAVE ARTIFACT /usr/local/bin/earthly

devcontainer:
    FROM +devcontainer-base

    # AWS cli
    COPY +awscli/aws /aws
    RUN /aws/install

    # doctl
    COPY +doctl/doctl /usr/local/bin/

    # tfenv
    COPY (+github-src/src --REPO=tfutils/tfenv --COMMIT=459d15b63f55c2f507bfa6a18e9dec5937e45daf) /tfenv
    RUN ln -s /tfenv/bin/* /usr/local/bin/
    COPY --chown=$USER_UID:$USER_GID .terraform-version "/home/$USERNAME/"
    RUN tfenv install "$(cat /home/$USERNAME/.terraform-version)"
    RUN tfenv use "$(cat /home/$USERNAME/.terraform-version)"
    COPY +terraform-ls/terraform-ls /usr/local/bin/

    COPY +tfk8s/tfk8s /usr/local/bin/

    # Install earthly
    COPY +earthly/earthly /usr/local/bin/
    RUN earthly bootstrap --no-buildkit --with-autocomplete

    RUN mkdir -m 777 /haxelib

    USER $USERNAME

    # Config direnv
    COPY --chown=$USER_UID:$USER_GID .devcontainer/direnv.toml /home/$USERNAME/.config/direnv/config.toml

    RUN haxelib setup /haxelib

    # Config bash
    RUN echo 'eval "$(direnv hook bash)"' >> ~/.bashrc \
        && echo 'complete -C terraform terraform' >> ~/.bashrc \
        && echo "complete -C '/usr/local/bin/aws_completer' aws" >> ~/.bashrc \
        && echo 'source <(helm completion bash)' >> ~/.bashrc \
        && echo 'source <(kubectl completion bash)' >> ~/.bashrc \
        && echo 'source <(doctl completion bash)' >> ~/.bashrc

    # Create kubeconfig for storing current-context,
    # such that the project kubeconfig_* files wouldn't be touched.
    RUN mkdir -p ~/.kube && install -m 600 /dev/null ~/.kube/config

    USER root

    ARG DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME_DEFAULT"
    ARG DEVCONTAINER_IMAGE_TAG=latest
    SAVE IMAGE --push "$DEVCONTAINER_IMAGE_NAME:$DEVCONTAINER_IMAGE_TAG" "$DEVCONTAINER_IMAGE_NAME:latest"

devcontainer-rebuild:
    RUN --no-cache date +%Y%m%d%H%M%S | tee buildtime
    ARG DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME_DEFAULT"
    BUILD \
        --platform=linux/amd64 \
        +devcontainer \
        --DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME" \
        --DEVCONTAINER_IMAGE_TAG="$(cat buildtime)"
    BUILD +devcontainer-update-refs \
        --DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME" \
        --DEVCONTAINER_IMAGE_TAG="$(cat buildtime)"

devcontainer-update-refs:
    ARG --required DEVCONTAINER_IMAGE_NAME
    ARG --required DEVCONTAINER_IMAGE_TAG
    BUILD +devcontainer-update-ref \
        --DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME" \
        --DEVCONTAINER_IMAGE_TAG="$DEVCONTAINER_IMAGE_TAG" \
        --FILE='./.devcontainer/docker-compose.yml' \
        --FILE='./.github/workflows/ci.yml'

devcontainer-update-ref:
    ARG --required DEVCONTAINER_IMAGE_NAME
    ARG --required DEVCONTAINER_IMAGE_TAG
    ARG --required FILE
    COPY "$FILE" file.src
    RUN sed -e "s#$DEVCONTAINER_IMAGE_NAME:[a-z0-9]*#$DEVCONTAINER_IMAGE_NAME:$DEVCONTAINER_IMAGE_TAG#g" file.src > file.out
    SAVE ARTIFACT --keep-ts file.out $FILE AS LOCAL $FILE

do-kubeconfig:
    FROM +doctl
    ARG --required CLUSTER_ID
    RUN --mount=type=secret,id=+secrets/.envrc,target=.envrc \
        . ./.envrc \
        && KUBECONFIG="kubeconfig" doctl kubernetes cluster kubeconfig save "$CLUSTER_ID"
    SAVE ARTIFACT --keep-ts kubeconfig

kube-prometheus-stack.crds:
    FROM +devcontainer
    COPY (+github-src/src/charts/kube-prometheus-stack/crds/*.yaml --REPO=prometheus-community/helm-charts --COMMIT=f9140a1a9f929964e96e62818368d2ae9f54b1ab) .
    RUN find . -name '*.yaml' -exec tfk8s --strip --file {} --output {}.tf \;
    SAVE ARTIFACT --keep-ts *.tf AS LOCAL kube-prometheus-stack.crds/

mysql-operator.crds:
    FROM +devcontainer
    COPY mysql-operator/helm/mysql-operator/crds/*.yaml .
    RUN find . -name '*.yaml' -exec tfk8s --strip --file {} --output {}.tf \;
    SAVE ARTIFACT --keep-ts *.tf AS LOCAL mysql-operator.crds/
