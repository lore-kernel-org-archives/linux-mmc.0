From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v4 1/3] mmc: dt-bindings: update Mediatek MMC bindings
Date: Sat, 21 Jan 2017 16:55:21 +0800
Message-ID: <1484988923-1543-2-git-send-email-yong.mao@mediatek.com>
References: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:20083 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751240AbdAUIzg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Jan 2017 03:55:36 -0500
In-Reply-To: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

Add description for mediatek,hs200-cmd-int-delay
Add description for mediatek,hs400-cmd-int-delay
Add description for mediatek,hs400-cmd-resp-sel-rising

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 0120c7f..4182ea3 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -21,6 +21,15 @@ Optional properties:
 - assigned-clocks: PLL of the source clock
 - assigned-clock-parents: parent of source clock, used for HS400 mode to get 400Mhz source clock
 - hs400-ds-delay: HS400 DS delay setting
+- mediatek,hs200-cmd-int-delay: HS200 command internal delay setting.
+				This field has total 32 stages.
+				The value is an integer from 0 to 31.
+- mediatek,hs400-cmd-int-delay: HS400 command internal delay setting
+				This field has total 32 stages.
+				The value is an integer from 0 to 31.
+- mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
+				       If present,HS400 command responses are sampled on rising edges.
+				       If not present,HS400 command responses are sampled on falling edges.
 
 Examples:
 mmc0: mmc@11230000 {
@@ -38,4 +47,7 @@ mmc0: mmc@11230000 {
 	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
 	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
 	hs400-ds-delay = <0x14015>;
+	mediatek,hs200-cmd-int-delay = <26>;
+	mediatek,hs400-cmd-int-delay = <14>;
+	mediatek,hs400-cmd-resp-sel-rising;
 };
-- 
1.7.9.5

