From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 3/7] mmc: sdhci-pxav3: Extend binding with SDIO3 conf reg for the Armada 38x
Date: Thu, 29 Jan 2015 12:36:26 +0100
Message-ID: <1422531390-31038-4-git-send-email-gregory.clement@free-electrons.com>
References: <1422531390-31038-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60351 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753568AbbA2Lgm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 06:36:42 -0500
In-Reply-To: <1422531390-31038-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

The SDHCI unit used on the Armada 38x needs using an extra register to
do specific clock adjustments in order to support the SDR50 and DDR50
modes. This patch extends the binding to allow using this register.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 4dd6deb90719..3d1b449d6097 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -9,9 +9,13 @@ Required properties:
 - reg:
   * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
     the SDHCI registers.
-  * for "marvell,armada-380-sdhci", two register areas. The first one
-    for the SDHCI registers themselves, and the second one for the
-    AXI/Mbus bridge registers of the SDHCI unit.
+
+  * for "marvell,armada-380-sdhci", three register areas. The first
+    one for the SDHCI registers themselves, the second one for the
+    AXI/Mbus bridge registers of the SDHCI unit, the third one for the
+    SDIO3 Configuration register
+- reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
+  for "marvell,armada-380-sdhci"
 - clocks: Array of clocks required for SDHCI; requires at least one for
     I/O clock.
 - clock-names: Array of names corresponding to clocks property; shall be
@@ -35,7 +39,10 @@ sdhci@d4280800 {
 
 sdhci@d8000 {
 	compatible = "marvell,armada-380-sdhci";
-	reg = <0xd8000 0x1000>, <0xdc000 0x100>;
+	reg-names = "sdhci", "mbus", "conf-sdio3";
+	reg = <0xd8000 0x1000>,
+		<0xdc000 0x100>;
+		<0x18454 0x4>;
 	interrupts = <0 25 0x4>;
 	clocks = <&gateclk 17>;
 	clock-names = "io";
-- 
2.1.0

