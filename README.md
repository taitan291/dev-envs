# dev-envs

適当におためししたいときかつちょっと長いコードを書きたいとき用の環境集

## 環境一覧

| ディレクトリ | 内容 | 主なツール |
| --- | --- | --- |
| `envs/go` | Go | go, gopls, delve |
| `envs/python` | Python | uv, ruff, basedpyright |
| `envs/rust` | Rust | fenix (stable toolchain) |
| `envs/typst` | Typst | typst, tinymist, typstyle |

## 使い方

Nix (flakes 有効) が必要です。使いたい環境のディレクトリで開発シェルに入ります。

```sh
cd envs/rust
nix develop
```

またはリポジトリのルートから:

```sh
nix develop ./envs/rust
```

## ライセンス

[Everyone'sWare](LICENSE) ライセンスで公開しています。
