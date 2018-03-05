From: <sean.wang@mediatek.com>
Subject: [PATCH 1/2] mmc: dt-bindings: add support for MT7622 SoC
Date: Mon, 5 Mar 2018 15:03:19 +0800
Message-ID: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add the devicetree binding for MT7622 SoC

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 9b80176..f33467a 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -12,6 +12,7 @@ Required properties:
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
+	"mediatek,mt7622-mmc": for MT7622 SoC
 	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
 
 - reg: physical base address of the controller and length
-- 
2.7.4
