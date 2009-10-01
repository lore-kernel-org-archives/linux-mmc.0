From: akpm@linux-foundation.org
Subject: [patch 27/42] s3cmci: make SDIO IRQ hardware IRQ support build-time configurable
Date: Thu, 01 Oct 2009 15:44:20 -0700
Message-ID: <200910012244.n91MiKN3009049@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753858AbZJAWoV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 18:44:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben@simtec.co.uk, linux-mmc@vger.kernel.org

From: Ben Dooks <ben@simtec.co.uk>

We have found a couple of boards where the SDIO IRQ hardware support has
failed to work properly, and thus we should make it configurable whether
or not to be included in the driver.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Kconfig  |    7 +++++++
 drivers/mmc/host/s3cmci.c |    9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/Kconfig~s3cmci-make-sdio-irq-hardware-irq-support-build-time-configurable drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~s3cmci-make-sdio-irq-hardware-irq-support-build-time-configurable
+++ a/drivers/mmc/host/Kconfig
@@ -276,6 +276,13 @@ config MMC_S3C
 
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
diff -puN drivers/mmc/host/s3cmci.c~s3cmci-make-sdio-irq-hardware-irq-support-build-time-configurable drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~s3cmci-make-sdio-irq-hardware-irq-support-build-time-configurable
+++ a/drivers/mmc/host/s3cmci.c
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
 
_
