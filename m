From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v2 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Tue, 18 Apr 2017 18:13:09 +0800
Message-ID: <1492510391-704-2-git-send-email-yong.mao@mediatek.com>
References: <1492510391-704-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492510391-704-1-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

Add description for mediatek,clk-pad-delay

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 4182ea3..fbb3fd6 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -30,6 +30,7 @@ Optional properties:
 - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
 				       If present,HS400 command responses are sampled on rising edges.
 				       If not present,HS400 command responses are sampled on falling edges.
+- mediatek,clk-pad-delay: clock pad delay setting
 
 Examples:
 mmc0: mmc@11230000 {
@@ -50,4 +51,5 @@ mmc0: mmc@11230000 {
 	mediatek,hs200-cmd-int-delay = <26>;
 	mediatek,hs400-cmd-int-delay = <14>;
 	mediatek,hs400-cmd-resp-sel-rising;
+	mediatek,clk-pad-delay = <5>;
 };
-- 
1.7.9.5
