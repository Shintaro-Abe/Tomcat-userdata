# Tomcat-userdata
## 使用について
* __AmazonLinux2023対応。__
* __EC2のインスタンスプロファイルにIAMロールを設定。__
    * ` ssm:GetParameter `ポリシーが必要。


## スクリプトについて
以下の流れでインストールを実施。
* __Tomcatユーザーの作成__
* __Apacheのインストールと起動設定__
* __Javaのインストール__
* __Tomcatのダウンロード__
* __シンボリックリンクの作成__
* __Tomcatサービスの作成__
* __Tomcatの起動設定__
