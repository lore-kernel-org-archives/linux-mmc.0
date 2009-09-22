From: akpm@linux-foundation.org
Subject: [patch 081/232] powerpc: introduce and document sdhci,wp-inverted property for eSDHC
Date: Tue, 22 Sep 2009 16:45:14 -0700
Message-ID: <200909222345.n8MNjEJ0013917@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58758 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439AbZIWAQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:16:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, benh@kernel.crashing.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Anton Vorontsov <avorontsov@ru.mvista.com>

eSDHC block in MPC837x SOCs reports inverted write-protect state, soon
sdhci-of driver will look for sdhci,wp-inverted properties to decide
whether apply a specific quirk.

So, document the property and add it to device tree source files.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Ben Dooks <ben@fluff.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
 arch/powerpc/boot/dts/mpc8377_mds.dts            |    1 +
 arch/powerpc/boot/dts/mpc8377_rdb.dts            |    1 +
 arch/powerpc/boot/dts/mpc8377_wlan.dts           |    1 +
 arch/powerpc/boot/dts/mpc8378_mds.dts            |    1 +
 arch/powerpc/boot/dts/mpc8378_rdb.dts            |    1 +
 arch/powerpc/boot/dts/mpc8379_mds.dts            |    1 +
 arch/powerpc/boot/dts/mpc8379_rdb.dts            |    1 +
 8 files changed, 9 insertions(+)

diff -puN Documentation/powerpc/dts-bindings/fsl/esdhc.txt~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc Documentation/powerpc/dts-bindings/fsl/esdhc.txt
--- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -10,6 +10,8 @@ Required properties:
   - interrupts : should contain eSDHC interrupt.
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
+  - sdhci,wp-inverted : (optional) specifies that eSDHC controller
+    reports inverted write-protect state;
   - sdhci,1-bit-only : (optional) specifies that a controller can
     only handle 1-bit data transfers.
 
diff -puN arch/powerpc/boot/dts/mpc8377_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8377_mds.dts
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -159,6 +159,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <0>;
 			};
diff -puN arch/powerpc/boot/dts/mpc8377_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8377_rdb.dts
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -173,6 +173,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <111111111>;
 			};
diff -puN arch/powerpc/boot/dts/mpc8377_wlan.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8377_wlan.dts
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -150,6 +150,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				clock-frequency = <133333333>;
 			};
 		};
diff -puN arch/powerpc/boot/dts/mpc8378_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8378_mds.dts
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -159,6 +159,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <0>;
 			};
diff -puN arch/powerpc/boot/dts/mpc8378_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8378_rdb.dts
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -173,6 +173,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <111111111>;
 			};
diff -puN arch/powerpc/boot/dts/mpc8379_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8379_mds.dts
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -157,6 +157,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <0>;
 			};
diff -puN arch/powerpc/boot/dts/mpc8379_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc arch/powerpc/boot/dts/mpc8379_rdb.dts
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts~powerpc-introduce-and-document-sdhciwp-inverted-property-for-esdhc
+++ a/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -171,6 +171,7 @@
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
+				sdhci,wp-inverted;
 				/* Filled in by U-Boot */
 				clock-frequency = <111111111>;
 			};
_
