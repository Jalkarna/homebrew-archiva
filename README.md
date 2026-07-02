# Homebrew Archiva Tap

Install the latest stable Archiva formula:

```sh
brew install jalkarna/archiva/archiva
```

Or add the tap once, then install by formula name:

```sh
brew tap jalkarna/archiva
brew install archiva
```

To build from the current `main` branch instead of the stable tagged release:

```sh
brew install --HEAD jalkarna/archiva/archiva
```

The formula builds the Rust binary directly with Cargo. It does not install the npm package and does not require Node.
