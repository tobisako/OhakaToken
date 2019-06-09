# OhakaToken
DecryptTokyo-Group-01-PROJECT-仮想お墓ゲーム
このゲームは、墓地用の土地不足、管理者がいない無縁墓の増加、といった社会課題へのソリューションを提案するゲームです。 ユーザーはブロックチェーンに記録された故人情報にアクセスすることで仮想的なお墓参りをできます。 ユーザーセグメントによってアクセス許可レベルを分ける機能や、供養（投げ銭）する機能が備わっていることが特徴です。 このゲームはSDGs時代の先祖供養へ向けた実証実験に応用できるでしょう。

## 使い方
~~~
python main.py
~~~

## フォルダ構成

### ohaka_token_solidity
スマートコントラクト環境です。truffleを使い、kovanネットワークにデプロイして使用します。

### ohaka_token_frontend
フロントエンド環境です。

## kovanテストネットについて
テスト環境として、kovanネットワークを利用しており、デプロイの為に、INFURAのPROJECT_IDと、kovan-ether残高を含むアドレスのニーモニック追記が必要です。

truffle-config.js  
~~~~
const INFURA_PROJECT_ID = "";   // input here  
const mnemonic = "";            // input here  
~~~~

