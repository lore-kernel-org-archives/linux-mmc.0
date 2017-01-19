From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v3 0/3] mmc: mediatek: Use data tune for CMD line tune
Date: Thu, 19 Jan 2017 18:19:13 +0800
Message-ID: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

yong mao (3):
  mmc: dt-bindings: update Mediatek MMC bindings
  dts: mediatek: configure some fixed mmc parameters
  mmc: mediatek: Use data tune for CMD line tune

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   9 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |   3 +
 drivers/mmc/host/mtk-sd.c                        | 170 ++++++++++++++++++++---
 3 files changed, 165 insertions(+), 17 deletions(-)

-- 
1.8.1.1.dirty
