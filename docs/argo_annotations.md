# Argo templates annotations

You can provide some extra information about your Argo templates by using the `annotations` field in the [Artifact Hub package metadata file](https://github.com/khulnasoft/hub/blob/master/docs/metadata/khulnasoft-pkg.yml).

## Supported annotations

- **argo/version** *(string)*

Argo Workflows version required.

## Example

```yaml
...
annotations:
  argo/version: ">= 2.9.0"
```
