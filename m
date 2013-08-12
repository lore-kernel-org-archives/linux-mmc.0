From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH V3] mmc:of_spi: Update the code of getting voltage-ranges
Date: Mon, 12 Aug 2013 09:39:05 +0800
Message-ID: <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.24] ([207.46.163.24]:29381 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755460Ab3HLCdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Aug 2013 22:33:23 -0400
In-Reply-To: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Using function mmc_of_parse_voltage() to get voltage-ranges.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V3:
	- changes the type of ocr_mask and function mmc_of_parse_voltage

 drivers/mmc/host/of_mmc_spi.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..fd1928d 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -90,8 +90,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms;
-	const u32 *voltage_ranges;
-	int num_ranges;
+	u32 ocr_mask;
 	int i;
 	int ret = -EINVAL;
 
@@ -102,26 +101,10 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (!oms)
 		return NULL;
 
-	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
-	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-	if (!voltage_ranges || !num_ranges) {
-		dev_err(dev, "OF: voltage-ranges unspecified\n");
+	if (mmc_of_parse_voltage(np, &ocr_mask))
 		goto err_ocr;
-	}
-
-	for (i = 0; i < num_ranges; i++) {
-		const int j = i * 2;
-		u32 mask;
 
-		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
-					       be32_to_cpu(voltage_ranges[j + 1]));
-		if (!mask) {
-			ret = -EINVAL;
-			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
-			goto err_ocr;
-		}
-		oms->pdata.ocr_mask |= mask;
-	}
+	oms->pdata.ocr_mask |= ocr_mask;
 
 	for (i = 0; i < ARRAY_SIZE(oms->gpios); i++) {
 		enum of_gpio_flags gpio_flags;
-- 
1.8.0


