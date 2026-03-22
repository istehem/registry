DOCKER_REGISTRY := "192.168.132.170:5002"

# catalog
[group: 'registry']
catalog:
  curl -X GET {{DOCKER_REGISTRY}}/v2/_catalog | jq

# list tags for a repository
[group: 'api']
list-tags REPO:
  curl -s {{DOCKER_REGISTRY}}/v2/{{REPO}}/tags/list | jq

# get the manifest for a repository and tag
[group: 'api']
manifest REPO TAG:
  curl -s -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/{{TAG}} | jq

# get the manifest header for a repository and tag
[group: 'api']
manifest-header REPO TAG:
  curl -s -I -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/{{TAG}}

[group: 'podman']
garbage-collect:
  podman exec registry_registry_1 registry garbage-collect /etc/distribution/config.yml

# remove a digest in a repository
[group: 'registry']
delete REPO DIGEST:
  curl -X DELETE {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/{{DIGEST}}
  podman exec registry_registry_1 registry garbage-collect /etc/distribution/config.yml
