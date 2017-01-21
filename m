From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v4 2/3] ARM64: dts: mediatek: configure some fixed mmc parameters
Date: Sat, 21 Jan 2017 16:55:22 +0800
Message-ID: <1484988923-1543-3-git-send-email-yong.mao@mediatek.com>
References: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:59113 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751244AbdAUIzg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Jan 2017 03:55:36 -0500
In-Reply-To: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: yong mao <yong.mao@mediatek.com>

configure some fixed mmc parameters

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 0ecaad4..1c3634f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -134,6 +134,9 @@
 	bus-width = <8>;
 	max-frequency = <50000000>;
 	cap-mmc-highspeed;
+	mediatek,hs200-cmd-int-delay=<26>;
+	mediatek,hs400-cmd-int-delay=<14>;
+	mediatek,hs400-cmd-resp-sel-rising;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
-- 
1.7.9.5

