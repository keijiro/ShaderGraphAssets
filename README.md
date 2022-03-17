ShaderGraphAssets
=================

Basic asset collection for Unity Shader Graph

System requirements
-------------------

- Unity 2021.2 or later
- Shader Graph 12.1 or later

How to install the package
--------------------------

This package uses the [scoped registry] feature to import dependent packages.
Please add the following sections to the package manifest file
(`Packages/manifest.json`).

To the `scopedRegistries` section:

```
{
  "name": "Keijiro",
  "url": "https://registry.npmjs.com",
  "scopes": [ "jp.keijiro" ]
}
```

To the `dependencies` section:

```
"jp.keijiro.shadergraphassets": "2.1.0"
```

After changes, the manifest file should look like below:

```
{
  "scopedRegistries": [
    {
      "name": "Keijiro",
      "url": "https://registry.npmjs.com",
      "scopes": [ "jp.keijiro" ]
    }
  ],
  "dependencies": {
    "jp.keijiro.shadergraphassets": "2.1.0",
...
```

[scoped registry]: https://docs.unity3d.com/Manual/upm-scoped.html
