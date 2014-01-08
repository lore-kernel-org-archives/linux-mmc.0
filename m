From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] mmc: mmc_spi: use spi_get_drvdata() and spi_set_drvdata()
Date: Wed, 08 Jan 2014 10:49:26 +0900
Message-ID: <000001cf0c13$dcea0570$96be1050$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59909 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbaAHBte (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 20:49:34 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZ200KP97QFARA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Jan 2014 10:49:27 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jiri Kosina' <jkosina@suse.cz>
Cc: trivial@kernel.org, 'Chris Ball' <chris@printf.net>, linux-mmc@vger.kernel.org, 'Sonic Zhang' <sonic.zhang@analog.com>, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
can directly pass a struct spi_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/mmc_spi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 0a87e56..40770a5 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1386,7 +1386,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 			host->powerup_msecs = 250;
 	}
 
-	dev_set_drvdata(&spi->dev, mmc);
+	spi_set_drvdata(spi, mmc);
 
 	/* preallocate dma buffers */
 	host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
@@ -1472,7 +1472,7 @@ fail_glue_init:
 fail_nobuf1:
 	mmc_free_host(mmc);
 	mmc_spi_put_pdata(spi);
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 
 nomem:
 	kfree(ones);
@@ -1482,7 +1482,7 @@ nomem:
 
 static int mmc_spi_remove(struct spi_device *spi)
 {
-	struct mmc_host		*mmc = dev_get_drvdata(&spi->dev);
+	struct mmc_host		*mmc = spi_get_drvdata(spi);
 	struct mmc_spi_host	*host;
 
 	if (mmc) {
@@ -1507,7 +1507,7 @@ static int mmc_spi_remove(struct spi_device *spi)
 		spi->max_speed_hz = mmc->f_max;
 		mmc_free_host(mmc);
 		mmc_spi_put_pdata(spi);
-		dev_set_drvdata(&spi->dev, NULL);
+		spi_set_drvdata(spi, NULL);
 	}
 	return 0;
 }
-- 
1.7.10.4


