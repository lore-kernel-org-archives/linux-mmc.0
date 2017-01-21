From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v4 0/3] mmc: mediatek: Use data tune for CMD line tune
Date: Sat, 21 Jan 2017 16:55:20 +0800
Message-ID: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

yong mao (3):
  mmc: dt-bindings: update Mediatek MMC bindings
  ARM64: dts: mediatek: configure some fixed mmc parameters
  mmc: mediatek: Use data tune for CMD line tune

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  12 ++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |   3 +
 drivers/mmc/host/mtk-sd.c                        | 168 ++++++++++++++++++++---
 3 files changed, 167 insertions(+), 16 deletions(-)

-- 
1.8.1.1.dirty
