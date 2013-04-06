From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: mmc_spi: use spi_get_drvdata() and spi_set_drvdata()
Date: Sat, 06 Apr 2013 15:39:52 +0900
Message-ID: <001301ce3291$8ae3e180$a0aba480$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27086 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab3DFGjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Apr 2013 02:39:53 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKT008XPMIG0E00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 06 Apr 2013 15:39:52 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
can directly pass a struct spi_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/mmc_spi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 74145d1..5bc7a90 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1406,7 +1406,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 			host->powerup_msecs = 250;
 	}
 
-	dev_set_drvdata(&spi->dev, mmc);
+	spi_set_drvdata(spi, mmc);
 
 	/* preallocate dma buffers */
 	host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
@@ -1477,7 +1477,7 @@ fail_glue_init:
 fail_nobuf1:
 	mmc_free_host(mmc);
 	mmc_spi_put_pdata(spi);
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 
 nomem:
 	kfree(ones);
@@ -1487,7 +1487,7 @@ nomem:
 
 static int mmc_spi_remove(struct spi_device *spi)
 {
-	struct mmc_host		*mmc = dev_get_drvdata(&spi->dev);
+	struct mmc_host		*mmc = spi_get_drvdata(spi);
 	struct mmc_spi_host	*host;
 
 	if (mmc) {
@@ -1512,7 +1512,7 @@ static int mmc_spi_remove(struct spi_device *spi)
 		spi->max_speed_hz = mmc->f_max;
 		mmc_free_host(mmc);
 		mmc_spi_put_pdata(spi);
-		dev_set_drvdata(&spi->dev, NULL);
+		spi_set_drvdata(spi, NULL);
 	}
 	return 0;
 }
-- 
1.7.2.5


