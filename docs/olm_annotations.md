# Artifact Hub annotations in OLM operator CSV file

Artifact Hub uses the metadata in the operator's `CSV` file to populate the information for a package of kind OLM. Usually most of the information needed is already there, so there is no extra work required by maintainers to list them on Artifact Hub.

However, sometimes there might be cases in which it may be useful to provide some more context that helps improving users' experience in Artifact Hub. This can be done using some special **annotations** in the [CSV](https://github.com/operator-framework/community-operators/blob/master/docs/packaging-required-fields.md) file.

## Supported annotations

- **khulnasoft.com/alternativeName** *(string)*

Sometimes a package can be identified by two similar names. Some examples would be *postgres* / *postgresql* or *mongodb* / *mongo*. Users often may type any of the options and expect the same results. When searching for packages, Artifact Hub gives preference to **exact** matches in names, so sometimes the top results may not be what users would expect. This situation can be improved by providing an alternative name for your package, which will be given the same weight as the package name when indexing. So in cases like the previous examples, it can help ranking them higher in the search results.

*Please note that the alternative name must be a substring of the name, or the name must be a substring of the alternative name.*

- **khulnasoft.com/category** *(string, see example below)*

This annotation allows publishers to provide the package's category. Please use only *one* category from the following list: `ai-machine-learning`, `database`, `integration-delivery`, `monitoring-logging`, `networking`, `security`, `storage` or `streaming-messaging`.

When a category is not provided, Artifact Hub will **try to predict** one from the package's *keywords* by using a machine learning-based model. If you notice that the prediction isn't correct, we really appreciate that you submit the correct category as it helps us to train and improve the model. In the case that the prediction isn't correct but your package doesn't fit well in any of the categories supported, you can use the special value `skip-prediction` in the category field to prevent an incorrect classification.

- **khulnasoft.com/changes** *(yaml string, see example below)*

This annotation is used to provide some details about the changes introduced by a given operator version. Artifact Hub can generate and display a **ChangeLog** based on the entries in the `changes` field in all your operator versions. You can see an example of how the changelog would look like in the Artifact Hub UI [here](https://khulnasoft.com/packages/helm/artifact-hub/artifact-hub?modal=changelog).

This annotation can be provided using two different formats: using a plain list of strings with the description of the change or using a list of objects with some extra structured information (see example below). Please feel free to use the one that better suits your needs. The UI experience will be slightly different depending on the choice. When using the *list of objects* option the valid **supported kinds** are *added*, *changed*, *deprecated*, *removed*, *fixed* and *security*.

- **khulnasoft.com/containsSecurityUpdates** *(boolean string, see example below)*

Use this annotation to indicate that this operator version contains security updates. When a package release contains security updates, a special message will be displayed in the Artifact Hub UI as well as in the new release email notification.

- **khulnasoft.com/imagesWhitelist** *(yaml string, see example below)*

Use this annotation to provide a list of the images that should not be scanned for security vulnerabilities.

- **khulnasoft.com/install** *(yaml string, see example below)*

This annotation can be used to provide custom installation instructions for your package. They **must** be in markdown format.

- **khulnasoft.com/license** *(string)*

Use this annotation to indicate the operator's license. It must be a valid [SPDX identifier](https://spdx.org/licenses/).

- **khulnasoft.com/prerelease** *(boolean string, see example below)*

Use this annotation to indicate that this operator version is a pre-release. This status will be displayed in the UI's package view, as well as in new releases notifications emails.

- **khulnasoft.com/recommendations** *(yaml string, see example below)*

This annotation allows recommending other related packages. Recommended packages will be featured in the package detail view in Artifact Hub.

- **khulnasoft.com/screenshots** *(yaml string, see example below)*

This annotation can be used to provide some screenshots that will be featured in the package detail view in Artifact Hub.

## Example

Artifact Hub annotations in `CSV` file:

```yaml
metadata:
  annotations:
    khulnasoft.com/category: security
    khulnasoft.com/changes: |
      - Added cool feature
      - Fixed minor bug
    khulnasoft.com/changes: |
      - kind: added
        description: Cool feature
        links:
          - name: GitHub Issue
            url: https://github.com/issue-url
          - name: GitHub PR
            url: https://github.com/pr-url
      - kind: fixed
        description: Minor bug
        links:
          - name: GitHub Issue
            url: https://github.com/issue-url
    khulnasoft.com/containsSecurityUpdates: "true"
    khulnasoft.com/imagesWhitelist: |
      - repo/img2:2.0.0
      - repo/img3:3.0.0
    khulnasoft.com/install: |
      Brief install instructions in markdown format

      Content added here will be displayed when the INSTALL button on the package details page is clicked.
    khulnasoft.com/license: Apache-2.0
    khulnasoft.com/prerelease: "false"
    khulnasoft.com/recommendations: |
      - url: https://khulnasoft.com/packages/helm/artifact-hub/artifact-hub
      - url: https://khulnasoft.com/packages/helm/prometheus-community/kube-prometheus-stack
    khulnasoft.com/screenshots: |
      - title: Sample screenshot 1
        url: https://example.com/screenshot1.jpg
      - title: Sample screenshot 2
        url: https://example.com/screenshot2.jpg
spec:
    ...
```
