From: akpm@linux-foundation.org
Subject: [patch 049/177] sdhci-s3c: add SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk
Date: Tue, 10 Aug 2010 18:01:55 -0700
Message-ID: <201008110101.o7B11tDC027093@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36941 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932453Ab0HKBWg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:22:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, hyuk1.lee@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com, linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

On Samsung's SDMMC hosts the timeout clock is derivied from the SD Clock
which is set dynamically.  So checked SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
quirk and removed 'sdhci_s3c_get_timeout_clk' callback which doesn't need
any more.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-sdhci_quirk_data_timeout_uses_sdclk-quirk drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-sdhci_quirk_data_timeout_uses_sdclk-quirk
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -110,11 +110,6 @@ static unsigned int sdhci_s3c_get_max_cl
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
@@ -188,7 +183,6 @@ static void sdhci_s3c_set_clock(struct s
 
 		ourhost->cur_clk = best_src;
 		host->max_clk = clk_get_rate(clk);
-		host->timeout_clk = sdhci_s3c_get_timeout_clk(host);
 
 		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
 		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
@@ -211,7 +205,6 @@ static void sdhci_s3c_set_clock(struct s
 
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
-	.get_timeout_clock	= sdhci_s3c_get_timeout_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 };
 
@@ -335,6 +328,9 @@ static int __devinit sdhci_s3c_probe(str
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
+	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
+	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
_
