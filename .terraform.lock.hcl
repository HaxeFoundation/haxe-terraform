# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/cloudflare/cloudflare" {
  version     = "2.27.0"
  constraints = "~> 2.21"
  hashes = [
    "h1:Cbo1qOLvk5KYUp5+EhV3GkcxPMQXY+3mwkKeTqtykkI=",
    "h1:oIaG4g43i2ts961qg2t1OPSgJ7OmvingS6MFscKwPps=",
    "zh:15b7e8f7516ebd37461fb5a3b843dd0c250158c8000a2dc55b7b6f02780bee0f",
    "zh:187eed008324c43be4af075a68cf375ec2f3999c87ead243e64743abf2cb01ab",
    "zh:407e1e32d8e4e72740f8f467b545ee15feedde0999ad756964c5f3a66e7b4f1b",
    "zh:78580cb99e7288f7ec7d9ca8aed7c3be5cf60a8ea09bff65c575aedfe68a2e41",
    "zh:8581ea22cf58e277c793a49037b0156fef9ea5f425262b700912a173bc904820",
    "zh:86a91c81c8ff75216870cd5545aa45a181a20459dd3a29cfea6ce0a6a7292711",
    "zh:a52e1919ce32b9acf66424b10d0e86405ce8f0b56ff2bf787a621739d7275a33",
    "zh:b83842a5f0b5fb3832d5e97e075a0080aa1c1599d2a50531685c4c967ff79d6f",
    "zh:bb905ea2ddd592807a32007cbc34ead882ba6e69bedfdf36e77c8c141a2055df",
    "zh:c3301c6008a851d556fe0a79093116644e07443626ff0191a33f74d0c4684018",
    "zh:c933232a6607cf9a50e3237457cfd242d049bf0621d1fee0f665f55d8d1faafa",
    "zh:cc63056eabb7bbc8e60ac810826878b22411afb82cd1ca1046c629d1f7487fdb",
    "zh:e8c9b155647dff9f41bbee59e5953a6a992a5bab837add23d0cba981ad163a7b",
    "zh:f1cefdc8c82cda6240e371fac00527acc45cacf8046484f967fc2bda2914eb81",
  ]
}

provider "registry.terraform.io/hashicorp/aws" {
  version     = "3.68.0"
  constraints = ">= 3.36.0, >= 3.38.0, >= 3.50.0, >= 3.56.0, ~> 3.56"
  hashes = [
    "h1:6Z90ORvMqC6UvbZ529U2om6CZHsDomgeyedgeKYc/ao=",
    "h1:rAJft4bPPOCRBqUZqfjGwF4Yk/waqytuQZQ4twOZ6aE=",
    "zh:05a43a7dbd409451c08a958610234619d7e0d102e601220b60aad025bf2b6e2c",
    "zh:0d195fa738a348e511550de39caec3f10cfb9afe8d69ed2104b39e9129438739",
    "zh:3d88a19b2a810559bc6953fe92b7a7c6e3251c5501866c94ef34648df3fdf461",
    "zh:3e42fdaf9df636a3741871c4209c9665549d67f07a69dd8700dcdcd43cd367fb",
    "zh:690418e0969eb36807832b48099f09e686e3d0fda42f483efc835bdef6363888",
    "zh:7158d5ef79dc90f2da61b6bc28d450e8d61a58b314d9abed8a03a09b80a41316",
    "zh:7ed4fac5d8de0141559fc4dbf97dd754d5af8c245a946d955b11530293f6f4d6",
    "zh:d0961612800f75321014347b69148e2f326d8b9ff2a9ac99074d35ee3f289d17",
    "zh:e8d35599fc8f7ca796ada775828f1dbf10668e0c7eb1f052330360eb8a2f83e3",
    "zh:e989ac0324fd9d443da317b3d97ec9fb8c8122fa2951ac2356302891a20bb595",
    "zh:ff135b9cac355ecd8f69a64206751503fa9aa41147241c9f99ad766f27a6dcd3",
  ]
}

provider "registry.terraform.io/hashicorp/cloudinit" {
  version     = "2.2.0"
  constraints = ">= 2.0.0"
  hashes = [
    "h1:siiI0wK6/jUDdA5P8ifTO0yc9YmXHml4hz5K9I9N+MA=",
    "h1:tQLNREqesrdCQ/bIJnl0+yUK+XfdWzAG0wo4lp10LvM=",
    "zh:76825122171f9ea2287fd27e23e80a7eb482f6491a4f41a096d77b666896ee96",
    "zh:795a36dee548e30ca9c9d474af9ad6d29290e0a9816154ad38d55381cd0ab12d",
    "zh:9200f02cb917fb99e44b40a68936fd60d338e4d30a718b7e2e48024a795a61b9",
    "zh:a33cf255dc670c20678063aa84218e2c1b7a67d557f480d8ec0f68bc428ed472",
    "zh:ba3c1b2cd0879286c1f531862c027ec04783ece81de67c9a3b97076f1ce7f58f",
    "zh:bd575456394428a1a02191d2e46af0c00e41fd4f28cfe117d57b6aeb5154a0fb",
    "zh:c68dd1db83d8437c36c92dc3fc11d71ced9def3483dd28c45f8640cfcd59de9a",
    "zh:cbfe34a90852ed03cc074601527bb580a648127255c08589bc3ef4bf4f2e7e0c",
    "zh:d6ffd7398c6d1f359b96f5b757e77b99b339fbb91df1b96ac974fe71bc87695c",
    "zh:d9c15285f847d7a52df59e044184fb3ba1b7679fd0386291ed183782683d9517",
    "zh:f7dd02f6d36844da23c9a27bb084503812c29c1aec4aba97237fec16860fdc8c",
  ]
}

provider "registry.terraform.io/hashicorp/helm" {
  version     = "2.4.1"
  constraints = "~> 2.3"
  hashes = [
    "h1:CLb4n9f/hLyqqq0zbc+h5SuNOB7KnO65qOOb+ohwsKA=",
    "h1:Gqwrr+yKWR79esN39X9eRCddxMNapmaGMynLfjrUJJo=",
    "zh:07517b24ea2ce4a1d3be3b88c3efc7fb452cd97aea8fac93ca37a08a8ec06e14",
    "zh:11ef6118ed03a1b40ff66adfe21b8707ece0568dae1347ddfbcff8452c0655d5",
    "zh:1ae07e9cc6b088a6a68421642c05e2fa7d00ed03e9401e78c258cf22a239f526",
    "zh:1c5b4cd44033a0d7bf7546df930c55aa41db27b70b3bca6d145faf9b9a2da772",
    "zh:256413132110ddcb0c3ea17c7b01123ad2d5b70565848a77c5ccc22a3f32b0dd",
    "zh:4ab46fd9aadddef26604382bc9b49100586647e63ef6384e0c0c3f010ff2f66e",
    "zh:5a35d23a9f08c36fceda3cef7ce2c7dc5eca32e5f36494de695e09a5007122f0",
    "zh:8e9823a1e5b985b63fe283b755a821e5011a58112447d42fb969c7258ed57ed3",
    "zh:8f79722eba9bf77d341edf48a1fd51a52d93ec31d9cac9ba8498a3a061ea4a7f",
    "zh:b2ea782848b10a343f586ba8ee0cf4d7ff65aa2d4b144eea5bbd8f9801b54c67",
    "zh:e72d1ccf8a75d8e8456c6bb4d843fd4deb0e962ad8f167fa84cf17f12c12304e",
  ]
}

provider "registry.terraform.io/hashicorp/kubernetes" {
  version     = "2.7.0"
  constraints = ">= 1.11.1, ~> 2.4"
  hashes = [
    "h1:25AS3IS7uBb/Fm/pdjGJbXkrzTujuLfnhQ5WaAY5bYU=",
    "h1:Cd7Kh8JmqhevGx+OsZ33QSa5hBHOs7CT9sfqTR5NEGM=",
    "zh:0ee4ed19d951cf94a1b27bf813827bb5c51b48ac53efe827e77aa077e9d66021",
    "zh:134ae78a19a43f94c2958e87ee8c6c1ae4593c145569bf71bf58a357882c18af",
    "zh:191345c9c0808499378d6ac33237f41d4509769b06367630acbf1586e0fe1540",
    "zh:1c058459ca1705dd97646d06c02df648a19a12789024a16155209bbdd75d03d6",
    "zh:33ac31a72649b85962cf3404edd08e917704b225eb4064d63cfee5704635da56",
    "zh:3dcc51d76711ff58d77a42811d8f65834fdb3632d44f56f2fe58eaca07c83a8a",
    "zh:5d5ea922c72d2eb4abc67d9a34fcf92b3af33049325bb7384e772a9db90120dd",
    "zh:9b02cda7aad45408fa2acbc844505d6a72c3998eb28e3568c1d35e142acd1ffd",
    "zh:b7f4652ec526bc3e7a846a40b136dc4d1d873f643329056eeb8b7ac5dfb4e11e",
    "zh:c8d1617426ca3d91bc0c5188f353dbca55ca777c28830e9bb0b79baef227885e",
    "zh:ed7064a03e15ca6b2f026064f17fa3956775e34a930e5265399ffa7f6ef22ded",
  ]
}

provider "registry.terraform.io/hashicorp/local" {
  version     = "2.1.0"
  constraints = ">= 1.4.0"
  hashes = [
    "h1:EYZdckuGU3n6APs97nS2LxZm3dDtGqyM4qaIvsmac8o=",
    "h1:KfieWtVyGWwplSoLIB5usKAUnrIkDQBkWaR5TI+4WYg=",
    "zh:0f1ec65101fa35050978d483d6e8916664b7556800348456ff3d09454ac1eae2",
    "zh:36e42ac19f5d68467aacf07e6adcf83c7486f2e5b5f4339e9671f68525fc87ab",
    "zh:6db9db2a1819e77b1642ec3b5e95042b202aee8151a0256d289f2e141bf3ceb3",
    "zh:719dfd97bb9ddce99f7d741260b8ece2682b363735c764cac83303f02386075a",
    "zh:7598bb86e0378fd97eaa04638c1a4c75f960f62f69d3662e6d80ffa5a89847fe",
    "zh:ad0a188b52517fec9eca393f1e2c9daea362b33ae2eb38a857b6b09949a727c1",
    "zh:c46846c8df66a13fee6eff7dc5d528a7f868ae0dcf92d79deaac73cc297ed20c",
    "zh:dc1a20a2eec12095d04bf6da5321f535351a594a636912361db20eb2a707ccc4",
    "zh:e57ab4771a9d999401f6badd8b018558357d3cbdf3d33cc0c4f83e818ca8e94b",
    "zh:ebdcde208072b4b0f8d305ebf2bfdc62c926e0717599dcf8ec2fd8c5845031c3",
    "zh:ef34c52b68933bedd0868a13ccfd59ff1c820f299760b3c02e008dc95e2ece91",
  ]
}

provider "registry.terraform.io/hashicorp/random" {
  version     = "3.1.0"
  constraints = "~> 3.1"
  hashes = [
    "h1:BZMEPucF+pbu9gsPk0G0BHx7YP04+tKdq2MrRDF1EDM=",
    "h1:rKYu5ZUbXwrLG1w81k7H3nce/Ys6yAxXhWcbtk36HjY=",
    "zh:2bbb3339f0643b5daa07480ef4397bd23a79963cc364cdfbb4e86354cb7725bc",
    "zh:3cd456047805bf639fbf2c761b1848880ea703a054f76db51852008b11008626",
    "zh:4f251b0eda5bb5e3dc26ea4400dba200018213654b69b4a5f96abee815b4f5ff",
    "zh:7011332745ea061e517fe1319bd6c75054a314155cb2c1199a5b01fe1889a7e2",
    "zh:738ed82858317ccc246691c8b85995bc125ac3b4143043219bd0437adc56c992",
    "zh:7dbe52fac7bb21227acd7529b487511c91f4107db9cc4414f50d04ffc3cab427",
    "zh:a3a9251fb15f93e4cfc1789800fc2d7414bbc18944ad4c5c98f466e6477c42bc",
    "zh:a543ec1a3a8c20635cf374110bd2f87c07374cf2c50617eee2c669b3ceeeaa9f",
    "zh:d9ab41d556a48bd7059f0810cf020500635bfc696c9fc3adab5ea8915c1d886b",
    "zh:d9e13427a7d011dbd654e591b0337e6074eef8c3b9bb11b2e39eaaf257044fd7",
    "zh:f7605bd1437752114baf601bdf6931debe6dc6bfe3006eb7e9bb9080931dca8a",
  ]
}

provider "registry.terraform.io/integrations/github" {
  version     = "4.18.2"
  constraints = "~> 4.11"
  hashes = [
    "h1:7qumrrxL9L9zpwmvNrJhq9GICMgOLIWJeWFu84iK7kU=",
    "h1:yqY14PiCP6ia6PmU9R1ADwXLHazjtfAX01we6WtaPCs=",
    "zh:0905624d48ee1493f0e23942aad742151f3778c5511f6ddd5acb89fe48a35179",
    "zh:19f5ecedbba6dfecd8af625d41da45390936e9684d99d4330d1e415c1aa61064",
    "zh:2a04c4cff4feaaaf47f99929742f17eba29284b7acd06068111fc7ff2161bcd5",
    "zh:3652c758f343f31822816ebd2a593988342c543b0d1374401d453fcffa9abc1c",
    "zh:3b37c217dc8ade666430b375d623fd24237377aa91ab4ba7a4f2c698b03293ab",
    "zh:486ac6f1027e7c38bb1f0ae41eb62d149d94b263886cd9240ecb5ea7d1da5c77",
    "zh:6f0da812a7879332dfa1eec0369b6302ad182abe1151eb46915e6ace497639b7",
    "zh:7c7786b6241829c94c3bd2ecdf0c5c591157344832a0dafc31909430d651aca1",
    "zh:cf44af2b50c0a00d02e545894285e5a2be18ac73a4959ed53ce5e5d2cdbe707e",
    "zh:ecd4eeae228764fcbe7c318174f65d4be82a0fed3820a07de17d9db6ce431763",
    "zh:f24e15ec2b564bccc2f1ff2b57a2631de9545167dc85693fdd5ec5bb55061835",
    "zh:f5e0d357e7ff7b60b59acf60bfb2f24a14a1efe303e510dfc8bae2f5c6b1d0d4",
    "zh:fe8fa19f5184e795ead5be1be7488a88826342f35a2ac81ecde319bb019698d6",
  ]
}

provider "registry.terraform.io/terraform-aws-modules/http" {
  version     = "2.4.1"
  constraints = ">= 2.4.1"
  hashes = [
    "h1:FINkX7/X/cr5NEssB7dMqVWa6YtJtmwzvkfryuR39/k=",
    "h1:ZnkXcawrIr611RvZpoDzbtPU7SVFyHym+7p1t+PQh20=",
    "zh:0111f54de2a9815ded291f23136d41f3d2731c58ea663a2e8f0fef02d377d697",
    "zh:0740152d76f0ccf54f4d0e8e0753739a5233b022acd60b5d2353d248c4c17204",
    "zh:569518f46809ec9cdc082b4dfd4e828236eee2b50f87b301d624cfd83b8f5b0d",
    "zh:7669f7691de91eec9f381e9a4be81aa4560f050348a86c6ea7804925752a01bb",
    "zh:81cd53e796ec806aca2d8e92a2aed9135661e170eeff6cf0418e54f98816cd05",
    "zh:82f01abd905090f978b169ac85d7a5952322a5f0f460269dd981b3596652d304",
    "zh:9a235610066e0f7e567e69c23a53327271a6fc568b06bf152d8fe6594749ed2b",
    "zh:aeabdd8e633d143feb67c52248c85358951321e35b43943aeab577c005abd30a",
    "zh:c20d22dba5c79731918e7192bc3d0b364d47e98a74f47d287e6cc66236bc0ed0",
    "zh:c4fea2cb18c31ed7723deec5ebaff85d6795bb6b6ed3b954794af064d17a7f9f",
    "zh:e21e88b6e7e55b9f29b046730d9928c65a4f181fd5f60a42f1cd41b46a0a938d",
    "zh:eddb888a74dea348a0acdfee13a08875bacddde384bd9c28342a534269665568",
    "zh:f46d5f1403b8d8dfafab9bdd7129d3080bb62a91ea726f477fd43560887b8c4a",
  ]
}
