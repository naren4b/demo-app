# Install cosign binary
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign


VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
OS=Linux       # or Darwin, Windows
ARCH=x86_64    # or arm64, x86_64, armv6, i386, s390x
curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz

curl -sL https://github.com/google/go-containerregistry/releases/download/${VERSION}/multiple.intoto.jsonl > provenance.intoto.jsonl
# NOTE: You may be using a different architecture.
slsa-verifier-linux-amd64 verify-artifact go-containerregistry.tar.gz --provenance-path provenance.intoto.jsonl --source-uri github.com/google/go-containerregistry --source-tag "${VERSION}"
tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane


SRC_IMAGE=busybox
SRC_DIGEST=$(crane digest busybox)
IMAGE_URI=ttl.sh/$(uuidgen | head -c 8 | tr 'A-Z' 'a-z')
crane cp $SRC_IMAGE@$SRC_DIGEST $IMAGE_URI:1h
IMAGE_URI_DIGEST=$IMAGE_URI@$SRC_DIGEST
