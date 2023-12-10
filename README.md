This repository contains a _collection_ of one Feature - `nvim`.

### `nvim`

Running `nvim` inside the built container will install neovim with plugins.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
      "ghcr.io/gvital3230/devcontainer-features/nvim:latest": {}
    }
}
```

