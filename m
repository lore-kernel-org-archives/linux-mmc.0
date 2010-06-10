From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] sdhci-s3c: Add SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk for Samsung SoC
Date: Thu, 10 Jun 2010 20:39:51 +0900
Message-ID: <1276169991-16396-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:56646 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0FJLnW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 07:43:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, Lee Hyuk <hyuk1.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Lee Hyuk <hyuk1.lee@samsung.com>

On Samsung's SDMMC hosts the timeout clock is derivied from the SD
Clock, which is set dynamically.
So, checked 'SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK' quirk and removed
'sdhci_s3c_get_timeout_clk' callback which doesn't need any more.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index af21792..ca09382 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -110,11 +110,6 @@ static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
 	return max;
 }
 
-static unsigned int sdhci_s3c_get_timeout_clk(struct sdhci_host *host)
-{
-	return sdhci_s3c_get_max_clk(host) / 1000000;
-}
-
 /**
  * sdhci_s3c_consider_clock - consider one the bus clocks for current setting
  * @ourhost: Our SDHCI instance.
@@ -188,7 +183,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 
 		ourhost->cur_clk = best_src;
 		host->max_clk = clk_get_rate(clk);
-		host->timeout_clk = sdhci_s3c_get_timeout_clk(host);
 
 		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
 		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
@@ -211,7 +205,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
-	.get_timeout_clock	= sdhci_s3c_get_timeout_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 };
 
@@ -335,6 +328,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
+	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock. */
+	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
-- 
1.6.2.5

