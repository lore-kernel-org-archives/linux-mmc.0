From: Marek Vasut <marex@denx.de>
Subject: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Mon, 21 May 2012 05:36:06 +0200
Message-ID: <1337571366-7779-1-git-send-email-marex@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44591 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2EUDgV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 23:36:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

The write-protect GPIO is inverted on some boards. Handle such case.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
 drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

V2: Adjust the subject, Cc linux-mmc

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
index 14d870a..0a7d2cd 100644
--- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
@@ -13,6 +13,7 @@ Required properties:
 
 Optional properties:
 - wp-gpios: Specify GPIOs for write protection
+- wp-inverted: Set if the write protection GPIO is inverted
 
 Examples:
 
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 277161d..119beb9 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -164,16 +164,23 @@ struct mxs_mmc_host {
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	int				wp_gpio;
+	int				wp_inverted:1;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
+	int ret;
 
 	if (!gpio_is_valid(host->wp_gpio))
 		return -EINVAL;
 
-	return gpio_get_value(host->wp_gpio);
+	ret = gpio_get_value(host->wp_gpio);
+
+	if (host->wp_inverted)
+		ret = !ret;
+
+	return ret;
 }
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -786,6 +793,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		else if (bus_width == 8)
 			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 		host->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
+		if (of_find_property(np, "wp-inverted", NULL))
+			host->wp_inverted = 1;
 	} else {
 		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
 			mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-- 
1.7.10

