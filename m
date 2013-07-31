From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] mmc:of_spi: Update the code of getting voltage-ranges
Date: Wed, 31 Jul 2013 14:25:27 +0800
Message-ID: <1375251927-3330-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:19095 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754Ab3GaHR7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jul 2013 03:17:59 -0400
In-Reply-To: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Using function mmc_of_parse_voltage() to get voltage-ranges.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/of_mmc_spi.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..7d10991 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -92,6 +92,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	struct of_mmc_spi *oms;
 	const u32 *voltage_ranges;
 	int num_ranges;
+	u32 ocr_mask;
 	int i;
 	int ret = -EINVAL;
 
@@ -102,26 +103,11 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (!oms)
 		return NULL;
 
-	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
-	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-	if (!voltage_ranges || !num_ranges) {
-		dev_err(dev, "OF: voltage-ranges unspecified\n");
+	ocr_mask = mmc_of_parse_voltage(np);
+	if (ocr_mask <= 0)
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


