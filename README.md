# simple-virtual-machines

🫓🫓🫓 Azureで仮想マシンを作成してみる！  

## プロビジョニング方法

`.env.example`をコピーして、`.env`を作成します。  
`.tfbackend.example`をコピーして、`.tfbackend`を作成します。  
`.terraform.tfvars.example`をコピーして、`terraform.tfvars`を作成します。  
中身を適切に編集します。  

DevContainerに入り、以下のコマンドを実行します。  
※ `~/.azure/` にAzureの認証情報があることを前提とします。  

セットアップスクリプトを実行します。  

```shell
gh auth login

source ./setup.sh
source ./az_setup.sh
source ./tf_setup.sh
```

リソースのプロビジョニングを行います。  

```shell
terraform init -backend-config=.tfbackend
terraform plan
terraform apply
```

## 接続方法

```shell
./connect.sh
```

## ファイル構成

以下のファイル構成が良い？？？  

```files
project/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── provider.tf
├── backend.tf
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ...
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
└── README.md
```
