From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 36/38] mmc: fix power-on sequencing for esdhc-imx driver
Date: Wed, 23 Apr 2014 20:09:14 +0100
Message-ID: <E1Wd2Xi-0003wi-Av@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46546 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751182AbaDWTJS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:09:18 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

There's no reason that this can't be applied to all MMC interfaces as
it's all core code, so tie this into the core rather than it being
optional for each host.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/host.c | 90 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abc60f39aa7e..c523f55b317c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -316,7 +316,7 @@ int mmc_of_parse(struct mmc_host *host)
 	u32 bus_width;
 	bool explicit_inv_wp, gpio_inv_wp = false;
 	enum of_gpio_flags flags;
-	int i, len, ret, gpio;
+	int len, ret, gpio;
 
 	if (!host->parent || !host->parent->of_node)
 		return 0;
@@ -419,30 +419,6 @@ int mmc_of_parse(struct mmc_host *host)
 	if (explicit_inv_wp ^ gpio_inv_wp)
 		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	/* Parse card power/reset/clock control */
-	if (of_find_property(np, "card-reset-gpios", NULL)) {
-		struct gpio_desc *gpd;
-		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
-			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
-			if (IS_ERR(gpd))
-				break;
-			gpiod_direction_output(gpd, 0);
-			host->card_reset_gpios[i] = gpd;
-		}
-
-		gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
-		if (!IS_ERR(gpd)) {
-			dev_warn(host->parent, "More reset gpios than we can handle");
-			gpiod_put(gpd);
-		}
-	}
-
-	host->card_clk = of_clk_get_by_name(np, "card_ext_clock");
-	if (IS_ERR(host->card_clk))
-		host->card_clk = NULL;
-
-	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
-
 	if (of_find_property(np, "cap-sd-highspeed", &len))
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
 	if (of_find_property(np, "cap-mmc-highspeed", &len))
@@ -485,6 +461,66 @@ int mmc_of_parse(struct mmc_host *host)
 
 EXPORT_SYMBOL(mmc_of_parse);
 
+static int mmc_of_parse_child(struct mmc_host *host)
+{
+	struct device_node *np;
+	struct clk *clk;
+	int i;
+
+	if (!host->parent || !host->parent->of_node)
+		return 0;
+
+	np = host->parent->of_node;
+
+	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
+	if (IS_ERR(host->card_regulator)) {
+		if (PTR_ERR(host->card_regulator) == -EPROBE_DEFER)
+			return PTR_ERR(host->card_regulator);
+		host->card_regulator = NULL;
+	}
+
+	/* Parse card power/reset/clock control */
+	if (of_find_property(np, "card-reset-gpios", NULL)) {
+		struct gpio_desc *gpd;
+		int level = 0;
+
+		/*
+		 * If the regulator is enabled, then we can hold the
+		 * card in reset with an active high resets.  Otherwise,
+		 * hold the resets low.
+		 */
+		if (host->card_regulator && regulator_is_enabled(host->card_regulator))
+			level = 1;
+
+		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
+			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
+			if (IS_ERR(gpd)) {
+				if (PTR_ERR(gpd) == -EPROBE_DEFER)
+					return PTR_ERR(gpd);
+				break;
+			}
+			gpiod_direction_output(gpd, gpiod_is_active_low(gpd) | level);
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
+	clk = of_clk_get_by_name(np, "card_ext_clock");
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
+			return PTR_ERR(clk);
+		clk = NULL;
+	}
+	host->card_clk = clk;
+
+	return 0;
+}
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -564,6 +600,10 @@ int mmc_add_host(struct mmc_host *host)
 {
 	int err;
 
+	err = mmc_of_parse_child(host);
+	if (err)
+		return err;
+
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
-- 
1.8.3.1

