# Variables
UID := "1000"
GID := "1000"
USERNAME := "bitcoin"
IMAGE_NAME := "ruanbekker/blockchain-btc"
TAG := "latest"

# Build Docker image with VERSION argument
build VERSION:
    @echo building VERSION={{VERSION}}
    docker build \
        --build-arg VERSION={{VERSION}} \
        --build-arg UID={{UID}} \
        --build-arg GID={{GID}} \
        --build-arg USERNAME={{USERNAME}} \
        -t {{IMAGE_NAME}}:{{TAG}} .

# Tag Docker image with version
tag VERSION:
    @echo tagging {{IMAGE_NAME}}:{{TAG}} to {{IMAGE_NAME}}:{{VERSION}} 
    docker tag {{IMAGE_NAME}}:{{TAG}} {{IMAGE_NAME}}:{{VERSION}}

# Push Docker image to registry
push_only VERSION:
    @echo pushing to {{IMAGE_NAME}}:{{VERSION}}
    docker push {{IMAGE_NAME}}:{{TAG}}
    docker push {{IMAGE_NAME}}:{{VERSION}}

# Complete build and push process with VERSION argument
push VERSION:
    just build {{VERSION}}
    just tag {{VERSION}}
    just push_only {{VERSION}}

