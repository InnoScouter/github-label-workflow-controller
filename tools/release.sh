rm -rf artifact && mkdir artifact
(cd dist && zip -r ../artifact/function.zip .)

aws-vault exec is-dev -- aws \
  s3api put-object \
  --bucket dev-innoscouter-lambda-function \
  --key github-label-workflow-controller/function.zip \
  --body artifact/function.zip

aws-vault exec is-dev -- aws \
  lambda update-function-code --function-name github-label-workflow-controller \
  --s3-bucket dev-innoscouter-lambda-function --s3-key github-label-workflow-controller/function.zip
