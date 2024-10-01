# github-label-workflow-controller

ラベル付与、剥がしで、ワークフローを実行するものです。
リポジトリに以下のようなファイルが必要となります。`/.github/label-workflow-controller.json`を追加してください。
https://github.com/momosetkn/label-controller-test/blob/fc9df5d58b46956576549836fd34ce69bc7affa3/.github/label-controller.json

デプロイ、アンデプロイに使えます。

挙動

| アクション                  | 動作                                                       |
|------------------------|----------------------------------------------------------|
| ラベルを付与                 | 同じラベルが付与された他のPRからラベルを剥がして、ifAddWorkflowIdで指定されたワークフローを実行 |
| ラベルを剥がす                | ifRemoveWorkflowIdで指定したワークフローを実行する                       |
| クローズ             | ラベルを剥がし、ifRemoveWorkflowIdで指定したワークフローを実行する               |
| マージ                    | ラベルを剥がす                                                  |
| ラベルが付与されたPRへ新規コミットをプッシュ | ifAddWorkflowIdで指定されたワークフローを実行                           |

## appの作り方

### AWS

AWS Lambda, S3, API Gatewayを使います

環境変数

- GITHUB_APP_ID: Github側のApp ID（https://github.com/settings/apps で確認）
- GITHUB_APP_PRIVATE_KEY: Private keysを改行を\nへ置き換えたもの（https://github.com/settings/apps で取得可能）

5秒以上かかるものもあるので、Lambdaのタイムアウト値をデフォルトの３秒から変更し、１５秒ぐらいにしておく

### github側での設定

https://github.com/settings/apps/new or https://github.com/organizations/InnoScouter/settings/apps/new

Webhook: Active

以下にAWS LambdaのAPI Gatewayで設定したものを設定
Callback URL, Setup URL (optional), Webhook URL

必要なPermission

- Actions: Read and write
- Contents: Read-only
- Metadata: Read-only
- Pull requests: Read and write

必要なSubscribe to events

- Pull request

## Build

pnpm Build

## Release

pnpm release

以下は各自のAWSのクライアントの設定に合わせて書き換えてください
https://github.com/momosetkn/github-label-workflow-controller/blob/main/tools/release.sh
