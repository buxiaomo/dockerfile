docker builder build --platform linux/arm64 -t docker.io/buxiaomo/jenkins-swarm:3.31-arm64 --pull -f Dockerfile --build-arg TARGETARCH=arm64 .
docker builder build --platform linux/amd64 -t docker.io/buxiaomo/jenkins-swarm:3.31-amd64 --pull -f Dockerfile --build-arg TARGETARCH=amd64 .
docker manifest create buxiaomo/jenkins-swarm:3.32 \
docker.io/buxiaomo/jenkins-swarm:3.32-arm64 \
docker.io/buxiaomo/jenkins-swarm:3.32-amd64
docker manifest push buxiaomo/jenkins-swarm:3.32