From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] mmc: of_mmc_spi: fix unused warning
Date: Mon,  7 Mar 2016 15:36:39 -0800
Message-ID: <1457393799-121767-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34674 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbcCGXgv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 18:36:51 -0500
Received: by mail-pf0-f177.google.com with SMTP id 129so44126511pfw.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2016 15:36:50 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <computersforpeace@gmail.com>

drivers/mmc/host/of_mmc_spi.c: In function 'mmc_spi_get_pdata':
drivers/mmc/host/of_mmc_spi.c:77:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
  int ret = -EINVAL;
      ^

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
Compile tested only

 drivers/mmc/host/of_mmc_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 660170cd04d9..85bbebfde02e 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -74,7 +74,6 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	const u32 *voltage_ranges;
 	int num_ranges;
 	int i;
-	int ret = -EINVAL;
 
 	if (dev->platform_data || !np)
 		return dev->platform_data;
@@ -97,7 +96,6 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
 					       be32_to_cpu(voltage_ranges[j + 1]));
 		if (!mask) {
-			ret = -EINVAL;
 			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
 			goto err_ocr;
 		}
-- 
2.7.0.rc3.207.g0ac5344

