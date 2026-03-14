DOCKER_REGISTRY := "192.168.132.170:5002"

# catalog
[group: 'registry']
catalog:
  curl -X GET {{DOCKER_REGISTRY}}/v2/_catalog | jq

# list tags for a repository
[group: 'registry']
list-tags REPO:
  curl {{DOCKER_REGISTRY}}/v2/{{REPO}}/tags/list | jq

# get the manifest for a repository and tag
[group: 'registry']
manifest REPO TAG:
  curl -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' {{DOCKER_REGISTRY}}/v2/axum-server/manifests/{{TAG}} | jq

# remove a digest in a repository
[group: 'registry']
delete REPO DIGEST:
  curl -X DELETE {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/{{DIGEST}}
  podman exec registry_registry_1 registry garbage-collect /etc/distribution/config.yml
