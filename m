From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH v3 2/3] dts: mediatek: configure some fixed mmc parameters
Date: Thu, 19 Jan 2017 18:19:15 +0800
Message-ID: <1484821156-20565-3-git-send-email-yong.mao@mediatek.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-mmc@vger.kernel.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

configure some fixed mmc parameters

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 0ecaad4..403705e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -134,6 +134,9 @@
 	bus-width = <8>;
 	max-frequency = <50000000>;
 	cap-mmc-highspeed;
+	mtk-hs200-cmd-int-delay=<26>;
+	mtk-hs400-cmd-int-delay=<14>;
+	mtk-hs400-cmd-resp-sel=<0>; /* 0:rising, 1:falling */
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
 	non-removable;
-- 
1.7.9.5
