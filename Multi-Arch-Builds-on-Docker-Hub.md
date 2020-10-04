# Multi-arch builds on Docker Hub

The [Custom build phase hooks](https://docs.docker.com/docker-hub/builds/advanced/#override-build-test-or-push-commands) build all variants for all platforms, e.g. `amd64` and `arm32v7`, on Docker Hub.

More specifically, the hooks

- Build the image variants in the `build` phase
- Push all images in the `push` phase
- Update the multi-arch manifest in the `post_push` phase

The `post_push` hook generates and pushes the manifest which - simply put - is just a list of references to other images.

```yaml
# Manifest for resilio/sync:release-2.6.3 which points to the amd64 and arm32v7 images
image: resilio/sync:release-2.6.3
manifests:
  - image: resilio/sync:release-2.6.3-amd64
    platform:
      architecture: amd64
      os: linux
  - image: resilio/sync:release-2.6.3-arm32v7
    platform:
      architecture: arm
      os: linux
      variant: v7
```

## Setting up Docker Hub Automated Builds

The following Docker Hub configuration for Automated Builds results in the tags listed in the [README.md](./README.md).

| Source Type | Source | Docker Tag          | Dockerfile location | Build Context |
| ----------- | ------ | ------------------- | ------------------- | ------------- |
| Branch      | master | latest              | Dockerfile          | /             |
| Tag         | /.\*/  | release-{sourceref} | Dockerfile          | /             |

The `master` branch creates the multi-arch `latest` image and its the platform specific `latest-*` variants.

The tags are published as `release-*` images, e.g. the Git tag `2.6.3` creates the multi-arch `release-2.6.3` image and its platform specific `release-2.6.3-*` variants.

## References

For more details, see [Advanced options for Autobuild and Autotest](https://docs.docker.com/docker-hub/builds/advanced/).
