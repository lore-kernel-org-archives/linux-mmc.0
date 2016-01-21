From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 04/15] mmc: sunxi: Support vqmmc regulator
Date: Thu, 21 Jan 2016 13:26:31 +0800
Message-ID: <1453354002-28366-5-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54850 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbcAUFdj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:39 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

eMMC chips require 2 power supplies, vmmc for internal logic, and vqmmc
for driving output buffers. vqmmc also controls signaling voltage. Most
boards we've seen use the same regulator for both, nevertheless the 2
have different usages, and should be set separately.

This patch adds support for vqmmc regulator supply, including voltage
switching. The MMC core can use this to try different signaling voltages
for eMMC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 0495ae7da6d6..4bec87458317 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -28,6 +28,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/reset.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
@@ -256,6 +257,9 @@ struct sunxi_mmc_host {
 	struct mmc_request *mrq;
 	struct mmc_request *manual_stop_mrq;
 	int		ferror;
+
+	/* vqmmc */
+	bool		vqmmc_enabled;
 };
 
 static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
@@ -716,6 +720,16 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (host->ferror)
 			return;
 
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			host->ferror = regulator_enable(mmc->supply.vqmmc);
+			if (host->ferror) {
+				dev_err(mmc_dev(mmc),
+					"failed to enable vqmmc\n");
+				return;
+			}
+			host->vqmmc_enabled = true;
+		}
+
 		host->ferror = sunxi_mmc_init_host(mmc);
 		if (host->ferror)
 			return;
@@ -727,6 +741,9 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		dev_dbg(mmc_dev(mmc), "power off!\n");
 		sunxi_mmc_reset_host(host);
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
+			regulator_disable(mmc->supply.vqmmc);
+		host->vqmmc_enabled = false;
 		break;
 	}
 
@@ -758,6 +775,19 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 }
 
+static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/* vqmmc regulator is available */
+	if (!IS_ERR(mmc->supply.vqmmc))
+		return mmc_regulator_set_vqmmc(mmc, ios);
+
+	/* no vqmmc regulator, assume fixed regulator at 3/3.3V */
+	if (mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		return 0;
+
+	return -EINVAL;
+}
+
 static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -923,6 +953,7 @@ static struct mmc_host_ops sunxi_mmc_ops = {
 	.get_ro		 = mmc_gpio_get_ro,
 	.get_cd		 = mmc_gpio_get_cd,
 	.enable_sdio_irq = sunxi_mmc_enable_sdio_irq,
+	.start_signal_voltage_switch = sunxi_mmc_volt_switch,
 	.hw_reset	 = sunxi_mmc_hw_reset,
 	.card_busy	 = sunxi_mmc_card_busy,
 };
-- 
2.7.0.rc3

