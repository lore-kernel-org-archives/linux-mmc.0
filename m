From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/2] Powerpc: Add voltage support in dts file
Date: Tue, 23 Jul 2013 10:59:04 +0800
Message-ID: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:35095
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559Ab3GWDuc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2013 23:50:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

eSDHC of T4240 had 1.8v voltage support. Add this node to specify
eSDHC voltage capacity. If this node not specified eSDHC driver
still can read from eSDHC host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for this patch set:
	- split from patch [PATCH 1/2] Powerpc: Add 
	- voltage ranges support for T4

 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 3 +++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index bd9be0b..f1ac253 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -19,6 +19,8 @@ Optional properties:
     "bus-width = <1>" property.
   - sdhci,auto-cmd12: specifies that a controller can only handle auto
     CMD12.
+  - 3300 3300: specifies that eSDHC controller can support voltages ranges
+    from 3300 to 3300.
 
 Example:
 
@@ -29,4 +31,5 @@ sdhci@2e000 {
 	interrupt-parent = <&ipic>;
 	/* Filled in by U-Boot */
 	clock-frequency = <0>;
+	voltage-ranges = <3300 3300>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..567d0fb 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -399,6 +399,7 @@
 	sdhc@114000 {
 		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
+		voltage-ranges = <1800 1800>;
 	};
 /include/ "qoriq-i2c-0.dtsi"
 /include/ "qoriq-i2c-1.dtsi"
-- 
1.8.0


