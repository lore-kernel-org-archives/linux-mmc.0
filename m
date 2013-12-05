From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/6] mmc: mxs: use mmc_gpio_get_ro for detecting read-only status
Date: Thu,  5 Dec 2013 14:34:50 +0100
Message-ID: <1386250491-4708-6-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab3LENfC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 08:35:02 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

This also fixes that the read-only gpio was used without being
requested.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 3dd2f4c..13016e2 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -38,6 +38,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
@@ -69,26 +70,8 @@ struct mxs_mmc_host {
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
-	int				wp_gpio;
-	bool				wp_inverted;
 };
 
-static int mxs_mmc_get_ro(struct mmc_host *mmc)
-{
-	struct mxs_mmc_host *host = mmc_priv(mmc);
-	int ret;
-
-	if (!gpio_is_valid(host->wp_gpio))
-		return -EINVAL;
-
-	ret = gpio_get_value(host->wp_gpio);
-
-	if (host->wp_inverted)
-		ret = !ret;
-
-	return ret;
-}
-
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
@@ -551,7 +534,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 static const struct mmc_host_ops mxs_mmc_ops = {
 	.request = mxs_mmc_request,
-	.get_ro = mxs_mmc_get_ro,
+	.get_ro = mmc_gpio_get_ro,
 	.get_cd = mxs_mmc_get_cd,
 	.set_ios = mxs_mmc_set_ios,
 	.enable_sdio_irq = mxs_mmc_enable_sdio_irq,
@@ -585,7 +568,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
 	struct resource *iores;
-	int ret = 0, irq_err;
+	int ret = 0, irq_err, gpio;
 	struct regulator *reg_vmmc;
 	enum of_gpio_flags flags;
 	struct mxs_ssp *ssp;
@@ -659,9 +642,14 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 	if (of_property_read_bool(np, "non-removable"))
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
-	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-	if (flags & OF_GPIO_ACTIVE_LOW)
-		host->wp_inverted = 1;
+	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
+	if (gpio_is_valid(gpio)) {
+		ret = mmc_gpio_request_ro(mmc, gpio);
+		if (ret)
+			goto out_clk_disable;
+		if (!(flags & OF_GPIO_ACTIVE_LOW))
+			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	}
 
 	if (of_property_read_bool(np, "cd-inverted"))
 		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
-- 
1.8.4.3

