From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for MT8516
Date: Sat, 23 Mar 2019 22:16:00 +0100
Message-ID: <20190323211612.860-13-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: sean.wang@kernel.org, ryder.lee@mediatek.com, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, chaotian.jing@mediatek.com, yong.mao@mediatek.com, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

Add binding documentation of infracfg for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/arm/mediatek/mediatek,infracfg.txt          | 1 +
 include/dt-bindings/clock/mt8516-clk.h                   | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 417bd83d1378..cbc38a8ee985 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8516-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
index 8d44cb32efba..956ee2c0748e 100644
--- a/include/dt-bindings/clock/mt8516-clk.h
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -8,6 +8,15 @@
 #ifndef _DT_BINDINGS_CLK_MT8516_H
 #define _DT_BINDINGS_CLK_MT8516_H
 
+/* INFRACFG */
+
+#define CLK_IFR_MUX1_SEL		0
+#define CLK_IFR_ETH_25M_SEL		1
+#define CLK_IFR_I2C0_SEL		2
+#define CLK_IFR_I2C1_SEL		3
+#define CLK_IFR_I2C2_SEL		4
+#define CLK_IFR_NR_CLK			5
+
 /* TOPCKGEN */
 
 #define CLK_TOP_CLK_NULL		0
-- 
2.20.1
