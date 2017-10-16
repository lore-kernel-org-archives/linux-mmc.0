From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v6 00/12] mmc: mediatek: add support of mt2701/mt2712
Date: Mon, 16 Oct 2017 09:46:27 +0800
Message-ID: <1508118399-21828-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:27715 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751506AbdJPBq5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Oct 2017 21:46:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com

  This serial of patches are adding support of mt2701/mt2712.
there are many changes and HW improvement between mt8173 and
mt2701/mt2712, below is a list of these changes:
  1. enlarge CLKDIV bits from 8 to 12
  2. remove the PAD_TUNE register and add a new PAD_TUNE0 register
  3. add data sync and async fifo feature
  4. add busy_check feature
  5. add stop_clk fix
  6. add enhance_rx support
  7. add a seperate CG of source clock

  mt2712 supports full of these features, mt2701 supports part of it, and
add a "mediatek,latch-ck" to work-around as it do not support stop-clk fix.

Note: As Pinctrl/CCF are not ready now, so that current patches do not
include DTS part.

Changed vs v5:
  based on Rob's comments, explain why MT8173 no longer compatible with
driver that supports "mediatek,mt8135-mmc", add more clearly description
of "mediatek,latch-ck".

Changed vs v4:
  based on Julien's comment, change the "bool pad_tune0" to "u32 pad_tune_reg".

Changed vs v3:
  based on Ulf's comments, make the bindings change to be the first patch.

Changed vs v2:
  based on Matthias's comments, merge binding file changes to one patch,
add "hs400_tune" flag in dev_comp.

Changed vs v1:
  based on Ulf/Rob/Matthias's comments of DTS binding file, make the binding
file clearly and fix probe issue.


Chaotian Jing (12):
  mmc: dt-bindings: Add reg/source_cg/latch-ck for Mediatek MMC bindings
  mmc: mediatek: add support of mt2701/mt2712
  arm64: dts: mt8173: remove "mediatek,mt8135-mmc" from mmc nodes
  mmc: mediatek: make hs400_tune_response only for mt8173
  mmc: mediatek: add pad_tune0 support
  mmc: mediatek: add async fifo and data tune support
  mmc: mediatek: add busy_check support
  mmc: mediatek: add stop_clk fix and enhance_rx support
  mmc: mediatek: add support of source_cg clock
  mmc: mediatek: add latch-ck support
  mmc: mediatek: improve eMMC hs400 mode read performance
  mmc: mediatek: perfer to use rise edge latching for cmd line

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  18 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |  12 +-
 drivers/mmc/host/mtk-sd.c                        | 283 ++++++++++++++++++++---
 3 files changed, 265 insertions(+), 48 deletions(-)

-- 
1.8.1.1.dirty

