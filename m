From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 10/11] s3cmci: Make SDIO IRQ hardware IRQ support build-time configurable.
Date: Mon, 21 Sep 2009 14:36:05 +0100
Message-ID: <20090921133724.521019781@smtp.local.simtec.co.uk>
References: <20090921133555.015075699@smtp.local.simtec.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hull.simtec.co.uk ([78.105.113.97]:39681 "EHLO
	preston.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756274AbZIUOWE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2009 10:22:04 -0400
Content-Disposition: inline; filename=simtec/ready/s3cmci-build-configurable-sdio-hwirq.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: ben-linux@fluff.org

We have found a couple of boards where the SDIO IRQ hardware support
has failed to work properly, and thus we should make it configurable
whether or not to be included in the driver.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/mmc/host/Kconfig  |    7 +++++++
 drivers/mmc/host/s3cmci.c |    9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-09-10 12:27:38.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-09-10 15:48:15.000000000 +0100
@@ -1715,7 +1715,11 @@ static int __devinit s3cmci_probe(struct
 
 	mmc->ops 	= &s3cmci_ops;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
+#ifdef CONFIG_MMC_S3C_HW_SDIO_IRQ
 	mmc->caps	= MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
+#else
+	mmc->caps	= MMC_CAP_4_BIT_DATA;
+#endif
 	mmc->f_min 	= host->clk_rate / (host->clk_div * 256);
 	mmc->f_max 	= host->clk_rate / host->clk_div;
 
@@ -1750,8 +1754,9 @@ static int __devinit s3cmci_probe(struct
 	s3cmci_debugfs_attach(host);
 
 	platform_set_drvdata(pdev, mmc);
-	dev_info(&pdev->dev, "%s - using %s\n", mmc_hostname(mmc),
-		 s3cmci_host_usedma(host) ? "dma" : "pio");
+	dev_info(&pdev->dev, "%s - using %s, %s SDIO IRQ\n", mmc_hostname(mmc),
+		 s3cmci_host_usedma(host) ? "dma" : "pio",
+		 mmc->caps & MMC_CAP_SDIO_IRQ ? "hw" : "sw");
 
 	return 0;
 
Index: b/drivers/mmc/host/Kconfig
===================================================================
--- a/drivers/mmc/host/Kconfig	2009-09-10 15:43:29.000000000 +0100
+++ b/drivers/mmc/host/Kconfig	2009-09-10 15:45:10.000000000 +0100
@@ -261,6 +261,13 @@ config MMC_S3C
 
 	  If unsure, say N.
 
+config MMC_S3C_HW_SDIO_IRQ
+       bool "Hardware support for SDIO IRQ"
+       depends on MMC_S3C
+       help
+         Enable the hardware support for SDIO interrupts instead of using
+	 the generic polling code.
+
 choice
 	prompt "Samsung S3C SD/MMC transfer code"
 	depends on MMC_S3C

--
