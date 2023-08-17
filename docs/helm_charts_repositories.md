## Helm charts repositories

Artifact Hub is able to process chart repositories as defined by the Helm project. For more information about the repository structure and different options to host your own, please check their [documentation](https://helm.sh/docs/topics/chart_repository/).

Most of the metadata Artifact Hub needs is extracted from the `Chart.yaml` file and other files in the chart package, like the `README` or `LICENSE` files. However, there is some extra Artifact Hub specific metadata that you can set using some special annotations in the `Chart.yaml` file. For more information, please see the [Artifact Hub Helm annotations documentation](https://github.com/khulnasoft/hub/blob/master/docs/helm_annotations.md).

There is an extra metadata file that you can add at the repository URL's path named [khulnasoft-repo.yml](https://github.com/khulnasoft/hub/blob/master/docs/metadata/khulnasoft-repo.yml), which can be used to setup features like [Verified publisher](https://github.com/khulnasoft/hub/blob/master/docs/repositories.md#verified-publisher) or [Ownership claim](https://github.com/khulnasoft/hub/blob/master/docs/repositories.md#ownership-claim). *Please note that the **khulnasoft-repo.yml** metadata file must be located at the same level of the chart repository **index.yaml** file, and it must be served from the chart repository HTTP server as well.*

Once you have added your repository, you are all set up. As you add new versions of your charts or even new charts to your repository, they'll be automatically indexed and listed in Artifact Hub.

### OCI support

Artifact Hub is able to process chart repositories stored in [OCI registries](https://github.com/opencontainers/distribution-spec/blob/master/spec.md).

To add a repository stored in a OCI registry, the url used **must** follow the following format:

- `oci://registry/namespace/chart-name`

Each of the chart versions are expected to match an OCI reference tag, which are expected to be valid [semver](https://semver.org) versions. OCI specific installation instructions will be provided in the Artifact Hub UI when appropriate (only for Helm >=3.7). For additional information about Helm OCI support, please see the [HIP-0006](https://github.com/helm/community/blob/master/hips/hip-0006.md).

There is an extra Artifact Hub specific metadata file named [khulnasoft-repo.yml](https://github.com/khulnasoft/hub/blob/master/docs/metadata/khulnasoft-repo.yml), which can be used to setup features like [Verified publisher](https://github.com/khulnasoft/hub/blob/master/docs/repositories.md#verified-publisher) or [Ownership claim](https://github.com/khulnasoft/hub/blob/master/docs/repositories.md#ownership-claim). Once your repository metadata file is ready, you can push it to the OCI registry using [oras](https://oras.land/cli/):

```bash
oras push \
  registry/namespace/chart-name:khulnasoft.com \
  --config /dev/null:application/vnd.cncf.khulnasoft.config.v1+yaml \
  khulnasoft-repo.yml:application/vnd.cncf.khulnasoft.repository-metadata.layer.v1.yaml
```

The repository metadata file is pushed to the registry using a special tag named `khulnasoft.com`. Artifact Hub will pull that artifact looking for the `application/vnd.cncf.khulnasoft.repository-metadata.layer.v1.yaml` layer when the repository metadata is needed.

Please note that there are some features that are not yet available for Helm repositories stored in OCI registries:

- Force an existing version to be reindexed by changing its digest
