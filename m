From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add support for non v3 controllers to support 8 bit
 data
Date: Fri, 8 Oct 2010 12:32:15 -0700
Message-ID: <8DF87361-9A12-4678-8661-06C55CFB574C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58753 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754162Ab0JHTdQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Oct 2010 15:33:16 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Our v2 controller supports 8 bit data.  add software hooks to
allow adaptation layer to control 8 bit width support.

new callback -- platform_8_bit_width

patch builds upon other patch for v3 8 bit support

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   42 ++++++++++++++++++++++--------------------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 90cfdfb..21b4ff9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1188,29 +1188,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-	if (ios->bus_width == MMC_BUS_WIDTH_8) {
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
-		if (host->version >= SDHCI_SPEC_300)
-			ctrl |= SDHCI_CTRL_8BITBUS;
-	} else {
-		if (host->version >= SDHCI_SPEC_300)
-			ctrl &= ~SDHCI_CTRL_8BITBUS;
-		if (ios->bus_width == MMC_BUS_WIDTH_4)
-			ctrl |= SDHCI_CTRL_4BITBUS;
-		else
+	/*
+	 * use platform_8_bit_width if not v3 controller
+	 * or if special hw/board specific processing is needed
+	 */
+	if (host->ops->platform_8_bit_width)
+		host->ops->platform_8_bit_width(host, ios->bus_width);
+	else {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		if (ios->bus_width == MMC_BUS_WIDTH_8) {
 			ctrl &= ~SDHCI_CTRL_4BITBUS;
+			if (host->version >= SDHCI_SPEC_300)
+				ctrl |= SDHCI_CTRL_8BITBUS;
+		} else {
+			if (host->version >= SDHCI_SPEC_300)
+				ctrl &= ~SDHCI_CTRL_8BITBUS;
+			if (ios->bus_width == MMC_BUS_WIDTH_4)
+				ctrl |= SDHCI_CTRL_4BITBUS;
+			else
+				ctrl &= ~SDHCI_CTRL_4BITBUS;
+		}
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 	}
 
-	if (ios->bus_width == MMC_BUS_WIDTH_8)
-		ctrl |= SDHCI_CTRL_8BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
-
-	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if ((ios->timing == MMC_TIMING_SD_HS ||
 	     ios->timing == MMC_TIMING_MMC_HS)
@@ -1857,6 +1858,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
+
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c87e3c4..ae30f7d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -215,6 +215,8 @@ struct sdhci_ops {
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
+	void 		(*platform_8_bit_width)(struct sdhci_host *host,
+				int width);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

