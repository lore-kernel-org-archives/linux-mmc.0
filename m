From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/6] mmc: dt-bindings: add support for MT8183 SoC
Date: Sat, 13 Oct 2018 15:20:45 +0800
Message-ID: <1539415250-32337-2-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Add the devicetree binding for MT8183 SoC

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f2208f4..f5bcda3 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -10,6 +10,7 @@ Required properties:
 - compatible: value should be either of the following.
 	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
+	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
-- 
1.8.1.1.dirty
