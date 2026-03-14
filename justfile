DOCKER_REGISTRY := "192.168.132.170:5002"

# catalog
[group: 'registry']
catalog:
  curl -X GET {{DOCKER_REGISTRY}}/v2/_catalog | jq .

# list tags for a repository
[group: 'registry']
list-tags REPO:
  curl {{DOCKER_REGISTRY}}/v2/{{REPO}}/tags/list | jq '.'

# list digests for the 'latest' tag in a repository
[group: 'registry']
list-digests REPO:
  curl -H "Accept: application/vnd.oci.image.manifest.v1+json" -I {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/latest

# remove a digest in a repository
[group: 'registry']
delete REPO DIGEST:
  curl -X DELETE {{DOCKER_REGISTRY}}/v2/{{REPO}}/manifests/{{DIGEST}}
  podman exec registry_registry_1 registry garbage-collect /etc/distribution/config.yml
