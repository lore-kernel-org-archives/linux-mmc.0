From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v4 03/12] arm64: dts: mt8173: remove "mediatek,mt8135-mmc" from mmc nodes
Date: Tue, 10 Oct 2017 17:30:22 +0800
Message-ID: <1507627831-29323-4-git-send-email-chaotian.jing@mediatek.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

devicetree bindings has been updated to support multi-platforms,
so that each platform has its owns compatible name.
And, this compatible name may used in driver to distinguish with
other platform.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b99a273..26396ef 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -682,8 +682,7 @@
 		};
 
 		mmc0: mmc@11230000 {
-			compatible = "mediatek,mt8173-mmc",
-				     "mediatek,mt8135-mmc";
+			compatible = "mediatek,mt8173-mmc";
 			reg = <0 0x11230000 0 0x1000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_0>,
@@ -693,8 +692,7 @@
 		};
 
 		mmc1: mmc@11240000 {
-			compatible = "mediatek,mt8173-mmc",
-				     "mediatek,mt8135-mmc";
+			compatible = "mediatek,mt8173-mmc";
 			reg = <0 0x11240000 0 0x1000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_1>,
@@ -704,8 +702,7 @@
 		};
 
 		mmc2: mmc@11250000 {
-			compatible = "mediatek,mt8173-mmc",
-				     "mediatek,mt8135-mmc";
+			compatible = "mediatek,mt8173-mmc";
 			reg = <0 0x11250000 0 0x1000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_2>,
@@ -715,8 +712,7 @@
 		};
 
 		mmc3: mmc@11260000 {
-			compatible = "mediatek,mt8173-mmc",
-				     "mediatek,mt8135-mmc";
+			compatible = "mediatek,mt8173-mmc";
 			reg = <0 0x11260000 0 0x1000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_MSDC30_3>,
-- 
1.8.1.1.dirty
