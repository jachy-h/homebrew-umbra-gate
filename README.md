# homebrew-umbragate

Homebrew tap for `umbragate`.

## Install

```bash
brew tap jachy-h/umbragate
brew trust --tap jachy-h/umbragate
brew install umbragate
```

Homebrew 6 requires explicit trust for non-official taps. If you see an
`untrusted tap` error, run:

```bash
brew trust --tap jachy-h/umbragate
```

## Development

Stable installs use macOS tarballs published from `jachy-h/umbra-gate` releases.

The main repository's release workflow can also update this formula automatically
when the `HOMEBREW_TAP_TOKEN` secret is configured in `jachy-h/umbra-gate`.
