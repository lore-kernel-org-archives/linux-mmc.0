From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 34/38] mmc: add support for power-on sequencing through DT
Date: Wed, 23 Apr 2014 20:09:04 +0100
Message-ID: <E1Wd2XY-0003wa-3n@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46542 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932511AbaDWTJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:09:14 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

This patch enables support for power-on sequencing of SDIO peripherals through DT.

In general, it's quite common that wifi modules and other similar
peripherals have several signals in addition to the SDIO interface that
needs wiggling before the module will power on. It's common to have a
reference clock, one or several power rails and one or several lines
for reset/enable type functions.

The binding as written today introduces a number of reset gpios,
a regulator and a clock specifier. The code will handle up to 2 gpio
reset lines, but it's trivial to increase to more than that if needed
at some point.

Implementation-wise, the MMC core has been changed to handle this during
host power up, before the host interface is powered on. I have not yet
implemented the power-down side, I wanted people to have a chance for
reporting back w.r.t. issues (or comments on the bindings) first.

I have not tested the regulator portion, since the system and module
I'm working on doesn't need one (Samsung Chromebook with Marvell
8797-based wifi). Testing of those portions (and reporting back) would
be appreciated.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++
 drivers/mmc/core/core.c                       | 42 +++++++++++++++++++++++++++
 drivers/mmc/core/host.c                       | 30 ++++++++++++++++++-
 include/linux/mmc/host.h                      |  5 ++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540771fb..b9b534ebc0c5 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -5,6 +5,8 @@ these definitions.
 Interpreted by the OF core:
 - reg: Registers location and length.
 - interrupts: Interrupts used by the MMC controller.
+- clocks: Clocks needed for the host controller, if any.
+- clock-names: Goes with clocks above.
 
 Card detection:
 If no property below is supplied, host native card detect is used.
@@ -39,6 +41,15 @@ If no property below is supplied, host native card detect is used.
 - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 
+Card power and reset control:
+The following properties can be specified for cases where the MMC
+peripheral needs additional reset, regulator and clock lines. It is for
+example common for WiFi/BT adapters to have these separate from the main
+MMC bus:
+  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
+  - card-external-vcc-supply: Regulator to drive (independent) card VCC
+  - clock with name "card_ext_clock": External clock provided to the card
+
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
 line levels. We choose to follow the SDHCI standard, which specifies both those
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index acbc3f2aaaf9..41c4033ec765 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -13,11 +13,13 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pagemap.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
@@ -1504,6 +1506,43 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_host_clk_release(host);
 }
 
+static void mmc_card_power_up(struct mmc_host *host)
+{
+	int i;
+	struct gpio_desc **gds = host->card_reset_gpios;
+
+	for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
+		if (gds[i]) {
+			dev_dbg(host->parent, "Asserting reset line %d", i);
+			gpiod_set_value(gds[i], 1);
+		}
+	}
+
+	if (host->card_regulator) {
+		dev_dbg(host->parent, "Enabling external regulator");
+		if (regulator_enable(host->card_regulator))
+			dev_err(host->parent, "Failed to enable external regulator");
+	}
+
+	if (host->card_clk) {
+		dev_dbg(host->parent, "Enabling external clock");
+		clk_prepare_enable(host->card_clk);
+	}
+
+	/* 2ms delay to let clocks and power settle */
+	mmc_delay(20);
+
+	for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
+		if (gds[i]) {
+			dev_dbg(host->parent, "Deasserting reset line %d", i);
+			gpiod_set_value(gds[i], 0);
+		}
+	}
+
+	/* 2ms delay to after reset release */
+	mmc_delay(20);
+}
+
 /*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
@@ -1520,6 +1559,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
+	/* Power up the card/module first, if needed */
+	mmc_card_power_up(host);
+
 	mmc_host_clk_hold(host);
 
 	host->ios.vdd = fls(ocr) - 1;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index fdea825dbb24..abc60f39aa7e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -12,14 +12,18 @@
  *  MMC host class device management
  */
 
+#include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/idr.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pagemap.h>
 #include <linux/export.h>
 #include <linux/leds.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -312,7 +316,7 @@ int mmc_of_parse(struct mmc_host *host)
 	u32 bus_width;
 	bool explicit_inv_wp, gpio_inv_wp = false;
 	enum of_gpio_flags flags;
-	int len, ret, gpio;
+	int i, len, ret, gpio;
 
 	if (!host->parent || !host->parent->of_node)
 		return 0;
@@ -415,6 +419,30 @@ int mmc_of_parse(struct mmc_host *host)
 	if (explicit_inv_wp ^ gpio_inv_wp)
 		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
+	/* Parse card power/reset/clock control */
+	if (of_find_property(np, "card-reset-gpios", NULL)) {
+		struct gpio_desc *gpd;
+		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
+			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
+			if (IS_ERR(gpd))
+				break;
+			gpiod_direction_output(gpd, 0);
+			host->card_reset_gpios[i] = gpd;
+		}
+
+		gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
+		if (!IS_ERR(gpd)) {
+			dev_warn(host->parent, "More reset gpios than we can handle");
+			gpiod_put(gpd);
+		}
+	}
+
+	host->card_clk = of_clk_get_by_name(np, "card_ext_clock");
+	if (IS_ERR(host->card_clk))
+		host->card_clk = NULL;
+
+	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
+
 	if (of_find_property(np, "cap-sd-highspeed", &len))
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
 	if (of_find_property(np, "cap-mmc-highspeed", &len))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 28c5e796292f..c3a8c5f6c9b8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -294,6 +294,11 @@ struct mmc_host {
 	unsigned long           clkgate_delay;
 #endif
 
+	/* card specific properties to deal with power and reset */
+	struct regulator	*card_regulator; /* External VCC needed by the card */
+	struct gpio_desc	*card_reset_gpios[2]; /* External resets, active low */
+	struct clk		*card_clk;	/* External clock needed by the card */
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
-- 
1.8.3.1

