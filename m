From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: mmc: mediatek: add MT8183 MMC driver support
Date: Sat, 13 Oct 2018 15:20:44 +0800
Message-ID: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org

this series of patch include below changes:
1. Add MT8183 SoC support in Mediatek MMC DT bindings
2. Fill mmc->actual_clock
3. Fix cannot receive new request issue
4. Tune CMD/DATA together to save tuning time
5. Add MT8183 MMC driver support
6. Refine the tuning method to drop too much redundant code

Chaotian Jing (6):
  mmc: dt-bindings: add support for MT8183 SoC
  mmc: mediatek: fill the actual clock for mmc debugfs
  mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready
    fail
  mmc: mediatek: tune CMD/DATA together
  mmc: mediatek: add MT8183 MMC driver support
  mmc: mediatek: drop too much code of tuning method

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   1 +
 drivers/mmc/host/mtk-sd.c                        | 292 ++++++++++++++++++++---
 2 files changed, 254 insertions(+), 39 deletions(-)

-- 
1.8.1.1.dirty
