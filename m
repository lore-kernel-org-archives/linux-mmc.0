From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dt: Deduplicate binding docs by referencing mmc.txt
Date: Mon, 11 Jun 2012 22:01:53 -0400
Message-ID: <87bokp5lv2.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41764 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab2FLCCH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jun 2012 22:02:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Arnd Bergmann <arndb@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Stephen Warren <swarren@wwwdotorg.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>

Now that we have common bindings for MMC, rewrite the individual
bindings to inherit from mmc.txt and describe their differences.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |   25 ++++++++++----------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    8 +++----
 .../devicetree/bindings/mmc/mmc-spi-slot.txt       |    8 +++----
 Documentation/devicetree/bindings/mmc/mmci.txt     |   12 ++++------
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |    8 +++----
 .../devicetree/bindings/mmc/nvidia-sdhci.txt       |    8 +++----
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    7 +++---
 7 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index 0d93b4b..bd9be0b 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -3,21 +3,22 @@
 The Enhanced Secure Digital Host Controller provides an interface
 for MMC, SD, and SDIO types of memory cards.
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the sdhci-esdhc driver.
+
 Required properties:
-  - compatible : should be
-    "fsl,<chip>-esdhc", "fsl,esdhc"
-  - reg : should contain eSDHC registers location and length.
-  - interrupts : should contain eSDHC interrupt.
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
-  - sdhci,wp-inverted : (optional) specifies that eSDHC controller
-    reports inverted write-protect state; New devices should use
-    the generic "wp-inverted" property.
-  - sdhci,1-bit-only : (optional) specifies that a controller can
-    only handle 1-bit data transfers. New devices should use the
-    generic "bus-width = <1>" property.
-  - sdhci,auto-cmd12: (optional) specifies that a controller can
-    only handle auto CMD12.
+
+Optional properties:
+  - sdhci,wp-inverted : specifies that eSDHC controller reports
+    inverted write-protect state; New devices should use the generic
+    "wp-inverted" property.
+  - sdhci,1-bit-only : specifies that a controller can only handle
+    1-bit data transfers. New devices should use the generic
+    "bus-width = <1>" property.
+  - sdhci,auto-cmd12: specifies that a controller can only handle auto
+    CMD12.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index c7e404b..485e497 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -3,17 +3,15 @@
 The Enhanced Secure Digital Host Controller on Freescale i.MX family
 provides an interface for MMC, SD, and SDIO types of memory cards.
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
+
 Required properties:
 - compatible : Should be "fsl,<chip>-esdhc"
-- reg : Should contain eSDHC registers location and length
-- interrupts : Should contain eSDHC interrupt
 
 Optional properties:
-- non-removable : Indicate the card is wired to host permanently
 - fsl,cd-internal : Indicate to use controller internal card detection
 - fsl,wp-internal : Indicate to use controller internal write protection
-- cd-gpios : Specify GPIOs for card detection
-- wp-gpios : Specify GPIOs for write protection
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
index d64aea5..0e5e2ec 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
@@ -1,8 +1,9 @@
 MMC/SD/SDIO slot directly connected to a SPI bus
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the mmc_spi driver.
+
 Required properties:
-- compatible : should be "mmc-spi-slot".
-- reg : should specify SPI address (chip-select number).
 - spi-max-frequency : maximum frequency for this device (Hz).
 - voltage-ranges : two cells are required, first cell specifies minimum
   slot voltage (mV), second cell specifies maximum slot voltage (mV).
@@ -11,8 +12,7 @@ Required properties:
 Optional properties:
 - gpios : may specify GPIOs in this order: Card-Detect GPIO,
   Write-Protect GPIO. Note that this does not follow the
-  binding from mmc.txt, for historic reasons.
-- interrupts : the interrupt of a card detect interrupt.
+  binding from mmc.txt, for historical reasons.
 - interrupt-parent : the phandle for the interrupt controller that
   services interrupts for this device.
 
diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 14a81d5..2b584ca 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -1,19 +1,15 @@
 * ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
 
-The ARM PrimeCell MMCI PL180 and PL181 provides and interface for
+The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
 reading and writing to MultiMedia and SD cards alike.
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the mmci driver.
+
 Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
-- reg                    : contains pl18x registers and length.
-- interrupts             : contains the device IRQ(s).
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID.
 
 Optional properties:
-- wp-gpios               : contains any write protect (ro) gpios
-- cd-gpios               : contains any card detection gpios
-- cd-inverted            : indicates whether the cd gpio is inverted
-- max-frequency          : contains the maximum operating frequency
-- bus-width              : number of data lines, can be <1>, <4>, or <8>
 - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
 - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
index 14d870a..54949f6 100644
--- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
@@ -3,16 +3,14 @@
 The Freescale MXS Synchronous Serial Ports (SSP) can act as a MMC controller
 to support MMC, SD, and SDIO types of memory cards.
 
+This file documents differences between the core properties in mmc.txt
+and the properties used by the mxsmmc driver.
+
 Required properties:
 - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
   imx23 and imx28.
-- reg: Should contain registers location and length
 - interrupts: Should contain ERROR and DMA interrupts
 - fsl,ssp-dma-channel: APBH DMA channel for the SSP
-- bus-width: Number of data lines, can be <1>, <4>, or <8>
-
-Optional properties:
-- wp-gpios: Specify GPIOs for write protection
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
index f77c303..c6d7b11 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
@@ -3,15 +3,13 @@
 This controller on Tegra family SoCs provides an interface for MMC, SD,
 and SDIO types of memory cards.
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the sdhci-tegra driver.
+
 Required properties:
 - compatible : Should be "nvidia,<chip>-sdhci"
-- reg : Should contain SD/MMC registers location and length
-- interrupts : Should contain SD/MMC interrupt
-- bus-width : Number of data lines, can be <1>, <4>, or <8>
 
 Optional properties:
-- cd-gpios : Specify GPIOs for card detection
-- wp-gpios : Specify GPIOs for write protection
 - power-gpios : Specify GPIOs for power control
 
 Example:
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8a53958..be76a23 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -3,21 +3,20 @@
 The Highspeed MMC Host Controller on TI OMAP family
 provides an interface for MMC, SD, and SDIO types of memory cards.
 
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the omap_hsmmc driver.
+
 Required properties:
 - compatible:
  Should be "ti,omap2-hsmmc", for OMAP2 controllers
  Should be "ti,omap3-hsmmc", for OMAP3 controllers
  Should be "ti,omap4-hsmmc", for OMAP4 controllers
 - ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
-- reg : should contain hsmmc registers location and length
 
 Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
-bus-width: Number of data lines, default assumed is 1 if the property is missing.
-cd-gpios: GPIOs for card detection
-wp-gpios: GPIOs for write protection
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
