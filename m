From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4] mmc: davinci: add support for SDIO irq handling
Date: Mon,  3 Jan 2011 10:42:51 +0530
Message-ID: <1294031571-19187-1-git-send-email-nsekhar@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51387 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab1ACFNJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Jan 2011 00:13:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, davinci-linux-open-source@linux.davincidsp.com, Alagu Sankar <alagusankar@embwise.com>, Sekhar Nori <nsekhar@ti.com>

From: Alagu Sankar <alagusankar@embwise.com>

This patch adds support for handing SDIO interrupt on
DaVinci MMC/SD controller.

The patch has been tested on DM355 and DA850 EVMs with
Marvell Libertas based SDIO wireless LAN card.

Signed-off-by: Alagu Sankar <alagusankar@embwise.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies to mmc-next branch of the mmc tree

Since v3, fixed the check for no SDIO IRQ from platform.

 drivers/mmc/host/davinci_mmc.c |   78 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index b643dde..6b09752 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -66,8 +66,8 @@
 #define DAVINCI_MMCBLNC      0x60
 #define DAVINCI_SDIOCTL      0x64
 #define DAVINCI_SDIOST0      0x68
-#define DAVINCI_SDIOEN       0x6C
-#define DAVINCI_SDIOST       0x70
+#define DAVINCI_SDIOIEN      0x6C
+#define DAVINCI_SDIOIST      0x70
 #define DAVINCI_MMCFIFOCTL   0x74 /* FIFO Control Register             */
 
 /* DAVINCI_MMCCTL definitions */
@@ -131,6 +131,14 @@
 #define MMCFIFOCTL_ACCWD_2    (2 << 3) /* access width of 2 bytes    */
 #define MMCFIFOCTL_ACCWD_1    (3 << 3) /* access width of 1 byte     */
 
+/* DAVINCI_SDIOST0 definitions */
+#define SDIOST0_DAT1_HI       BIT(0)
+
+/* DAVINCI_SDIOIEN definitions */
+#define SDIOIEN_IOINTEN       BIT(0)
+
+/* DAVINCI_SDIOIST definitions */
+#define SDIOIST_IOINT         BIT(0)
 
 /* MMCSD Init clock in Hz in opendrain mode */
 #define MMCSD_INIT_CLOCK		200000
@@ -164,7 +172,7 @@ struct mmc_davinci_host {
 	unsigned int mmc_input_clk;
 	void __iomem *base;
 	struct resource *mem_res;
-	int irq;
+	int mmc_irq, sdio_irq;
 	unsigned char bus_mode;
 
 #define DAVINCI_MMC_DATADIR_NONE	0
@@ -184,6 +192,7 @@ struct mmc_davinci_host {
 	u32 rxdma, txdma;
 	bool use_dma;
 	bool do_dma;
+	bool sdio_int;
 
 	/* Scatterlist DMA uses one or more parameter RAM entries:
 	 * the main one (associated with rxdma or txdma) plus zero or
@@ -866,6 +875,19 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 {
 	host->data = NULL;
 
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		/*
+		 * SDIO Interrupt Detection work-around as suggested by
+		 * Davinci Errata (TMS320DM355 Silicon Revision 1.1 Errata
+		 * 2.1.6): Signal SDIO interrupt only if it is enabled by core
+		 */
+		if (host->sdio_int && !(readl(host->base + DAVINCI_SDIOST0) &
+							SDIOST0_DAT1_HI)) {
+			writel(SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
+			mmc_signal_sdio_irq(host->mmc);
+		}
+	}
+
 	if (host->do_dma) {
 		davinci_abort_dma(host);
 
@@ -932,6 +954,21 @@ davinci_abort_data(struct mmc_davinci_host *host, struct mmc_data *data)
 	mmc_davinci_reset_ctrl(host, 0);
 }
 
+static irqreturn_t mmc_davinci_sdio_irq(int irq, void *dev_id)
+{
+	struct mmc_davinci_host *host = dev_id;
+	unsigned int status;
+
+	status = readl(host->base + DAVINCI_SDIOIST);
+	if (status & SDIOIST_IOINT) {
+		dev_dbg(mmc_dev(host->mmc),
+				"SDIO interrupt status %x\n", status);
+		writel(status | SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
+		mmc_signal_sdio_irq(host->mmc);
+	}
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 {
 	struct mmc_davinci_host *host = (struct mmc_davinci_host *)dev_id;
@@ -1076,11 +1113,32 @@ static int mmc_davinci_get_ro(struct mmc_host *mmc)
 	return config->get_ro(pdev->id);
 }
 
+static void mmc_davinci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mmc_davinci_host *host = mmc_priv(mmc);
+
+	if (enable) {
+		if (!(readl(host->base + DAVINCI_SDIOST0) & SDIOST0_DAT1_HI)) {
+			writel(SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
+			mmc_signal_sdio_irq(host->mmc);
+		} else {
+			host->sdio_int = true;
+			writel(readl(host->base + DAVINCI_SDIOIEN) |
+				SDIOIEN_IOINTEN, host->base + DAVINCI_SDIOIEN);
+		}
+	} else {
+		host->sdio_int = false;
+		writel(readl(host->base + DAVINCI_SDIOIEN) & ~SDIOIEN_IOINTEN,
+				host->base + DAVINCI_SDIOIEN);
+	}
+}
+
 static struct mmc_host_ops mmc_davinci_ops = {
 	.request	= mmc_davinci_request,
 	.set_ios	= mmc_davinci_set_ios,
 	.get_cd		= mmc_davinci_get_cd,
 	.get_ro		= mmc_davinci_get_ro,
+	.enable_sdio_irq = mmc_davinci_enable_sdio_irq,
 };
 
 /*----------------------------------------------------------------------*/
@@ -1209,7 +1267,8 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		host->nr_sg = MAX_NR_SG;
 
 	host->use_dma = use_dma;
-	host->irq = irq;
+	host->mmc_irq = irq;
+	host->sdio_irq = platform_get_irq(pdev, 1);
 
 	if (host->use_dma && davinci_acquire_dma_channels(host) != 0)
 		host->use_dma = 0;
@@ -1270,6 +1329,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
+	if (host->sdio_irq >= 0) {
+		ret = request_irq(host->sdio_irq, mmc_davinci_sdio_irq, 0,
+				mmc_hostname(mmc), host);
+		if (!ret)
+			mmc->caps |= MMC_CAP_SDIO_IRQ;
+	}
+
 	rename_region(mem, mmc_hostname(mmc));
 
 	dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
@@ -1313,7 +1379,9 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 		mmc_davinci_cpufreq_deregister(host);
 
 		mmc_remove_host(host->mmc);
-		free_irq(host->irq, host);
+		free_irq(host->mmc_irq, host);
+		if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+			free_irq(host->sdio_irq, host);
 
 		davinci_release_dma_channels(host);
 
-- 
1.7.3.2

