VERSION 0.8

# https://github.com/devcontainers/images/tree/main/src/base-ubuntu
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ARG --global DEVCONTAINER_IMAGE_NAME_DEFAULT=haxe/terraform_devcontainer_workspace

ARG --global USERNAME=vscode
ARG --global USER_UID=1001
ARG --global USER_GID=$USER_UID

# https://github.com/devcontainers/images/issues/1056
RUN userdel -r ubuntu || true

WORKDIR /tmp

docker-compose:
    ARG TARGETARCH
    ARG VERSION=2.27.1 # https://github.com/docker/compose/releases/
    RUN curl -fsSL https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-linux-$(uname -m) -o /usr/local/bin/docker-compose \
        && chmod +x /usr/local/bin/docker-compose
    SAVE ARTIFACT /usr/local/bin/docker-compose

devcontainer-library-scripts:
    RUN curl -fsSL https://raw.githubusercontent.com/devcontainers/features/main/src/docker-outside-of-docker/install.sh -o docker-outside-of-docker.sh
    SAVE ARTIFACT *.sh AS LOCAL .devcontainer/library-scripts/

devcontainer-base:
    # Maunally install docker-compose to avoid the following error:
    # pip seemed to fail to build package: PyYAML<6,>=3.10
    COPY +docker-compose/docker-compose /usr/local/bin/

    # Avoid warnings by switching to noninteractive
    ENV DEBIAN_FRONTEND=noninteractive

    COPY .devcontainer/library-scripts/*.sh /tmp/library-scripts/
    RUN /bin/bash /tmp/library-scripts/docker-outside-of-docker.sh

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
            apt-transport-https \
            gpg \
            software-properties-common \
            direnv \
            tzdata \
            python3-pip \
            jq \
        && apt-get install -y neko haxe \
        # install helm
        && curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
        && echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
        && apt-get update \
        && apt-get -y install --no-install-recommends helm \
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
    ARG DOCTL_VERSION=1.106.0 # https://github.com/digitalocean/doctl/releases
    RUN curl -fsSL "https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-${TARGETARCH}.tar.gz" | tar xvz -C /usr/local/bin/
    SAVE ARTIFACT /usr/local/bin/doctl

# Usage:
# COPY +mise/mise /usr/local/bin/
mise:
    ARG TARGETARCH
    ARG VERSION=2026.10.4 # https://github.com/jdx/mise/releases
    RUN apt-get update \
        && apt-get install -y --no-install-recommends minisign \
        && rm -rf /var/lib/apt/lists/*
    # https://mise.jdx.dev/installing-mise.html#github-releases
    RUN case "$TARGETARCH" in \
            amd64) mise_platform=linux-x64 ;; \
            arm64) mise_platform=linux-arm64 ;; \
            *) echo "Unsupported TARGETARCH: $TARGETARCH" >&2; exit 1 ;; \
        esac \
        && base="https://github.com/jdx/mise/releases/download/v${VERSION}" \
        && curl -fsSL -o mise "$base/mise-v${VERSION}-${mise_platform}" \
        && curl -fsSL -O "$base/SHASUMS256.txt" -O "$base/SHASUMS256.txt.minisig" \
        && minisign -Vm SHASUMS256.txt -P RWTC3g8W3z4RZK3V3qv7fa1QY4JEWyBtqIHW+85QlJpZc5yG+uNYNBSZ \
        && grep " ./mise-v${VERSION}-${mise_platform}$" SHASUMS256.txt | sed 's| ./mise-.*| mise|' | sha256sum -c \
        && install -m 755 mise /usr/local/bin/mise \
        && /usr/local/bin/mise --version
    SAVE ARTIFACT /usr/local/bin/mise

github-src:
    ARG --required REPO
    ARG --required COMMIT
    ARG DIR=/src
    WORKDIR $DIR
    RUN curl -fsSL "https://github.com/${REPO}/archive/${COMMIT}.tar.gz" | tar xz --strip-components=1 -C "$DIR"
    SAVE ARTIFACT "$DIR"

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
    ARG TARGETARCH
    ARG VERSION=0.8.16 # https://github.com/earthly/earthly/releases
    RUN curl -fsSL "https://github.com/earthly/earthly/releases/download/v${VERSION}/earthly-linux-${TARGETARCH}" -o /usr/local/bin/earthly \
        && chmod +x /usr/local/bin/earthly
    SAVE ARTIFACT /usr/local/bin/earthly

devcontainer:
    FROM +devcontainer-base

    # AWS cli
    COPY +awscli/aws /aws
    RUN /aws/install

    # tfk8s
    COPY +tfk8s/tfk8s /usr/local/bin/

    # Install earthly
    COPY +earthly/earthly /usr/local/bin/
    RUN earthly bootstrap --no-buildkit --with-autocomplete

    RUN mkdir -m 777 /haxelib

    # Install mise
    # Tools are installed to a fixed location instead of $HOME,
    # because GitHub Actions overrides HOME (and runs as root) in container jobs.
    # The system config makes the tools available outside of the project directory too.
    COPY +mise/mise /usr/local/bin/
    ENV MISE_DATA_DIR="/mise"
    ENV PATH="$MISE_DATA_DIR/shims:$PATH"
    # /workspace for the devcontainer, /__w for GitHub Actions checkouts
    ENV MISE_TRUSTED_CONFIG_PATHS="/workspace:/__w"
    RUN install -d -o "$USERNAME" -g "$USERNAME" "$MISE_DATA_DIR"
    COPY mise.toml /etc/mise/config.toml

    USER $USERNAME

    RUN mise install

    # Config direnv
    COPY --chown=$USER_UID:$USER_GID .devcontainer/direnv.toml /home/$USERNAME/.config/direnv/config.toml

    RUN haxelib setup /haxelib

    # Config bash
    RUN echo 'eval "$(mise activate bash)"' >> ~/.bashrc \
        && echo 'eval "$(direnv hook bash)"' >> ~/.bashrc \
        && echo 'complete -C tofu tofu' >> ~/.bashrc \
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
    SAVE IMAGE --push "$DEVCONTAINER_IMAGE_NAME:$DEVCONTAINER_IMAGE_TAG"

devcontainer-rebuild:
    RUN --no-cache date +%Y%m%d%H%M%S | tee buildtime
    ARG DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME_DEFAULT"
    BUILD \
        --platform=linux/amd64 \
        --platform=linux/arm64 \
        +devcontainer \
        --DEVCONTAINER_IMAGE_NAME="$DEVCONTAINER_IMAGE_NAME" \
        --DEVCONTAINER_IMAGE_TAG="$(cat buildtime)" \
        --DEVCONTAINER_IMAGE_TAG=latest
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
    RUN --mount=type=secret,id=+secrets/envrc,target=.envrc \
        . ./.envrc \
        && KUBECONFIG="kubeconfig" doctl kubernetes cluster kubeconfig save "$CLUSTER_ID"
    SAVE ARTIFACT --keep-ts kubeconfig AS LOCAL kubeconfig_do

kube-prometheus-stack.crds:
    FROM +devcontainer
    COPY (+github-src/src/charts/kube-prometheus-stack/crds/*.yaml --REPO=prometheus-community/helm-charts --COMMIT=0b928f341240c76d8513534035a825686ed28a4b) .
    RUN find . -name '*.yaml' -exec tfk8s --strip --file {} --output {}.tf \;
    SAVE ARTIFACT --keep-ts *.tf AS LOCAL kube-prometheus-stack.crds/

mysql-operator.crds:
    FROM +devcontainer
    COPY mysql-operator/helm/mysql-operator/crds/*.yaml .
    RUN find . -name '*.yaml' -exec tfk8s --strip --file {} --output {}.tf \;
    SAVE ARTIFACT --keep-ts *.tf AS LOCAL mysql-operator.crds/

terraform.lock:
    FROM +devcontainer
    COPY --dir cert-manager.crds kube-prometheus-stack.crds grafana mysql-operator mysql-operator.crds .
    COPY *.tf .terraform.lock.hcl .

    # We need to run `tofu init` locally to generate the .terraform directory.
    # It's not done in Earthly because it requires the provider credentials.
    COPY --dir .terraform .

    RUN tofu providers lock -platform=linux_amd64 -platform=linux_arm64 -platform=darwin_amd64 -platform=darwin_arm64
    SAVE ARTIFACT --keep-ts .terraform.lock.hcl AS LOCAL .terraform.lock.hcl
