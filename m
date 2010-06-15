From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT for Samsung SoC
Date: Tue, 15 Jun 2010 20:27:48 +0900
Message-ID: <1276601268-7226-4-git-send-email-kgene.kim@samsung.com>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:36924 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0FOLe1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2010 07:34:27 -0400
In-Reply-To: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, Lee Hyuk <hyuk1.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Lee Hyuk <hyuk1.lee@samsung.com>

S5PV210 HSMMC host controller doesn't have the WP pin which should be
connnected with SDMMC card WP pin. So if there are the cfg_wp and get_ro
in pdata, configure the WP pin and replace get_ro function in sdhci with
get_ro function in pdata.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   12 ++++++++++++
 drivers/mmc/host/sdhci.c     |    3 +++
 drivers/mmc/host/sdhci.h     |    3 +++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index af21792..857cbed 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -311,6 +311,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cfg_gpio)
 		pdata->cfg_gpio(pdev, pdata->max_width);
 
+	if (pdata->get_ro)
+		sdhci_s3c_ops.get_ro = pdata->get_ro;
+
 	host->hw_name = "samsung-hsmmc";
 	host->ops = &sdhci_s3c_ops;
 	host->quirks = 0;
@@ -335,6 +338,15 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
+	/* Controller's WP pin donsn't connected with SD card. So we allocate
+	 * a GPIO for getting WP data form SD card  and use that data as
+	 * the return value of the get_ro function */
+	host->quirks |= SDHCI_QUIRK_NO_WP_BIT;
+
+	/* to configure gpio pin as a card write protection signal */
+	if (pdata->cfg_wp)
+		pdata->cfg_wp(pdev->id);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..2f8dfbc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1192,6 +1192,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	host = mmc_priv(mmc);
 
+	if ((host->quirks & SDHCI_QUIRK_NO_WP_BIT) && host->ops->get_ro)
+		return host->ops->get_ro(mmc);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..f479e22 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -240,6 +240,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller has no write-protect pin connected with SD card */
+#define SDHCI_QUIRK_NO_WP_BIT                          (1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -312,6 +314,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int		(*get_ro)(struct mmc_host *mmc);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.2.5

