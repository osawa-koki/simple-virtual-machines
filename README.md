# simple-virtual-machines

🫓🫓🫓 Azureで仮想マシンを作成してみる！  

## プロビジョニング方法

`.env.example`をコピーして、`.env`を作成します。  
`.terraform.tfvars.example`をコピーして、`terraform.tfvars`を作成します。  
中身を適切に編集します。  

DevContainerに入り、以下のコマンドを実行します。  
※ `~/.azure/` にAzureの認証情報があることを前提とします。  

セットアップスクリプトを実行します。  

```shell
./setup.sh
```

リソースのプロビジョニングを行います。  

```shell
terraform init
terraform plan
terraform apply
```

## 接続方法

```shell
./connect.sh
```
