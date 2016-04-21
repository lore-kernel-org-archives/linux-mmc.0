From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v4 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Thu, 21 Apr 2016 15:55:43 +0200
Message-ID: <f53bfd4b14c36df41449d0bfdaadabd2c8d3ab1d.1461246772.git.larper@axis.com>
References: <cover.1461246772.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:45007 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcDUNzx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 09:55:53 -0400
In-Reply-To: <cover.1461246772.git.larper@axis.com>
In-Reply-To: <cover.1461246772.git.larper@axis.com>
References: <cover.1461246772.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Add a start_signal_voltage_switch() operation to support enabling of
UHS modes.

Signed-off-by: Lars Persson <larper@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 807c06e..28fe5c7 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -1147,12 +1148,22 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
+
+	return ret;
+}
+
 static struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
 	.get_cd		= usdhi6_get_cd,
 	.get_ro		= usdhi6_get_ro,
 	.enable_sdio_irq = usdhi6_enable_sdio_irq,
+	.start_signal_voltage_switch = usdhi6_sig_volt_switch,
 };
 
 /*			State machine handlers				*/
@@ -1785,7 +1796,17 @@ static int usdhi6_probe(struct platform_device *pdev)
 
 	mmc->ops = &usdhi6_ops;
 	mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ;
+		     MMC_CAP_SDIO_IRQ;
+
+	/*
+	 * A vqmmc regulator with a 1.8V mode is mandatory to support
+	 * UHS modes.
+	 */
+	if (!of_property_read_bool(dev->of_node, "no-1-8-v") &&
+	    !IS_ERR(mmc->supply.vqmmc)) {
+		mmc->caps |= MMC_CAP_UHS_DDR50 | MMC_CAP_UHS_SDR50;
+	}
+
 	/* Set .max_segs to some random number. Feel free to adjust. */
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
-- 
2.1.4

