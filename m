From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/2 V2] Powerpc: Add voltage support in dts file
Date: Wed, 24 Jul 2013 07:53:33 +0800
Message-ID: <1374623613-16681-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:19751
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755319Ab3GXApL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2013 20:45:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

eSDHC of T4240 had 1.8v voltage support. Add this node to specify
eSDHC voltage capacity. If this node not specified eSDHC driver
still can read from eSDHC host capacity register.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v2:
	- rewrite the voltage-ranges description

 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 4 ++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index bd9be0b..b7943f3 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -19,6 +19,9 @@ Optional properties:
     "bus-width = <1>" property.
   - sdhci,auto-cmd12: specifies that a controller can only handle auto
     CMD12.
+  - voltage-ranges : two cells are required, first cell specifies minimum
+    slot voltage (mV), second cell specifies maximum slot voltage (mV).
+    Several ranges could be specified.
 
 Example:
 
@@ -29,4 +32,5 @@ sdhci@2e000 {
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


