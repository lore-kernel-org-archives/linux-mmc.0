From: Alexander Kurz <akurz@blala.de>
Subject: [PATCH] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
Date: Sun,  9 Oct 2016 18:34:50 +0200
Message-ID: <1476030890-18274-1-git-send-email-akurz@blala.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vs81.iboxed.net ([185.82.85.146]:44749 "EHLO vs81.iboxed.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbcJIQuW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 9 Oct 2016 12:50:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, linux-mmc@vger.kernel.org, Alexander Kurz <akurz@blala.de>

According to the reference manuals, both imx50/imx53 SOC seem to share
the same eSDHC controller, especially the section on "Multi-block Read"
mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
reads on i.MX53") is identical for both SOC.
Hence, let imx50 use imx53-esdhc.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx50.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index e245713..769eac7 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -99,7 +99,7 @@
 				ranges;
 
 				esdhc1: esdhc@50004000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
 					clocks = <&clks IMX5_CLK_ESDHC1_IPG_GATE>,
@@ -111,7 +111,7 @@
 				};
 
 				esdhc2: esdhc@50008000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
 					clocks = <&clks IMX5_CLK_ESDHC2_IPG_GATE>,
@@ -160,7 +160,7 @@
 				};
 
 				esdhc3: esdhc@50020000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
 					clocks = <&clks IMX5_CLK_ESDHC3_IPG_GATE>,
@@ -172,7 +172,7 @@
 				};
 
 				esdhc4: esdhc@50024000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
 					clocks = <&clks IMX5_CLK_ESDHC4_IPG_GATE>,
-- 
2.1.4

