From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/5] MMC: mmci: Add generic Device Tree bindings to mmci core code
Date: Wed, 14 Mar 2012 14:20:01 +0000
Message-ID: <1331734803-17954-4-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51832 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030524Ab2CNOUN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 10:20:13 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so1729015wej.19
        for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 07:20:12 -0700 (PDT)
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

This adds the necessary bindings for collection of shared
attributes used in the mmci driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mmci.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 23b41a5..9132ca8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -30,6 +30,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/amba/mmci.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_gpio.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1056,11 +1057,47 @@ static const struct mmc_host_ops mmci_ops = {
 	.get_cd		= mmci_get_cd,
 };
 
+#ifdef CONFIG_OF
+static void mmci_dt_populate_generic_pdata(struct device_node *np,
+					struct mmci_platform_data *pdata)
+{
+	const void *prop;
+	int len;
+
+	of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
+	if (!pdata->gpio_wp)
+		pdata->gpio_wp = -1;
+
+	of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
+	if (!pdata->gpio_cd)
+		pdata->gpio_cd = -1;
+
+	if (of_get_property(np, "cd-invert", NULL))
+		pdata->cd_invert = true;
+	else
+		pdata->cd_invert = false;
+
+	of_property_read_u32(np, "clock_frequency", &pdata->f_max);
+	if (!pdata->f_max)
+		pr_warning("%s has no 'clock_frequency' property\n", np->full_name);
+
+	if (of_get_property(np, "mmc_cap_4_bit_data", NULL))
+		pdata->capabilities |= MMC_CAP_4_BIT_DATA;
+	if (of_get_property(np, "mmc_cap_8_bit_data", NULL))
+		pdata->capabilities |= MMC_CAP_8_BIT_DATA;
+	if (of_get_property(np, "mmc_cap_mmc_highspeed", NULL))
+		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_get_property(np, "mmc_cap_sd_highspeed", NULL))
+		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
+}
+#endif
+
 extern int __devinit mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
 	struct variant_data *variant = id->data;
+	struct device_node *np = dev->dev.of_node;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
 	int ret;
@@ -1071,6 +1108,12 @@ extern int __devinit mmci_probe(struct amba_device *dev,
 		goto out;
 	}
 
+#ifdef CONFIG_OF
+	if (np)
+		/* GPIOs, card detect invert, max freq, capabilites etc ... */
+		mmci_dt_populate_generic_pdata(np, plat);
+#endif
+
 	ret = amba_request_regions(dev, DRIVER_NAME);
 	if (ret)
 		goto out;
-- 
1.7.5.4

