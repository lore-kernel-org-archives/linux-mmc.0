From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: mmc: mediatek: add bus_clk control
Date: Fri, 28 Sep 2018 19:40:53 +0800
Message-ID: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org


Chaotian Jing (2):
  mmc: dt-bindings: add "bus-clk" for MT2712
  mmc: mediatek: add bus_clk control

 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 drivers/mmc/host/mtk-sd.c                        | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
1.8.1.1.dirty
