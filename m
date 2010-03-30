From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/3] ARM: MXC: mxcmmc: Teach the driver SDIO operations
Date: Tue, 30 Mar 2010 20:32:00 +0200
Message-ID: <1269973921-29611-2-git-send-email-daniel@caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:44819 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848Ab0C3ScT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 14:32:19 -0400
In-Reply-To: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, Volker Ernst <volker.ernst@txtr.com>, Jiri Kosina <jkosina@suse.cz>

Successfully tested on MX31 hardware using libertas SDIO peripherals.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Volker Ernst <volker.ernst@txtr.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/mmc/host/mxcmmc.c |   55 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 21037ff..83a4545 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -119,6 +119,7 @@ struct mxcmci_host {
 	int			detect_irq;
 	int			dma;
 	int			do_dma;
+	int			use_sdio;
 	unsigned int		power_mode;
 	struct imxmmc_platform_data *pdata;
 
@@ -138,6 +139,7 @@ struct mxcmci_host {
 	int			clock;
 
 	struct work_struct	datawork;
+	spinlock_t		lock;
 };
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
@@ -226,6 +228,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 		unsigned int cmdat)
 {
+	u32 int_cntr;
+
 	WARN_ON(host->cmd != NULL);
 	host->cmd = cmd;
 
@@ -249,13 +253,15 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 		return -EINVAL;
 	}
 
+	int_cntr = INT_END_CMD_RES_EN;
+
 	if (mxcmci_use_dma(host))
-		writel(INT_READ_OP_EN | INT_WRITE_OP_DONE_EN |
-				INT_END_CMD_RES_EN,
-				host->base + MMC_REG_INT_CNTR);
-	else
-		writel(INT_END_CMD_RES_EN, host->base + MMC_REG_INT_CNTR);
+		int_cntr |= INT_READ_OP_EN | INT_WRITE_OP_DONE_EN;
+
+	if (host->use_sdio)
+		int_cntr |= INT_SDIO_IRQ_EN;
 
+	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
 	writew(cmd->opcode, host->base + MMC_REG_CMD);
 	writel(cmd->arg, host->base + MMC_REG_ARG);
 	writew(cmdat, host->base + MMC_REG_CMD_DAT_CONT);
@@ -266,7 +272,12 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 static void mxcmci_finish_request(struct mxcmci_host *host,
 		struct mmc_request *req)
 {
-	writel(0, host->base + MMC_REG_INT_CNTR);
+	u32 int_cntr = 0;
+
+	if (host->use_sdio)
+		int_cntr |= INT_SDIO_IRQ_EN;
+
+	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
 
 	host->req = NULL;
 	host->cmd = NULL;
@@ -536,8 +547,12 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
+	if ((stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio)
+		mmc_signal_sdio_irq(host->mmc);
+
 	if (stat & STATUS_END_CMD_RESP)
 		mxcmci_cmd_done(host, stat);
+
 #ifdef HAS_DMA
 	if (mxcmci_use_dma(host) &&
 		  (stat & (STATUS_DATA_TRANS_DONE | STATUS_WRITE_OP_DONE)))
@@ -674,11 +689,30 @@ static int mxcmci_get_ro(struct mmc_host *mmc)
 	return -ENOSYS;
 }
 
+static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mxcmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 int_cntr;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->use_sdio = enable;
+	int_cntr = readl(host->base + MMC_REG_INT_CNTR);
+
+	if (enable)
+		int_cntr |= INT_SDIO_IRQ_EN;
+	else
+		int_cntr &= ~INT_SDIO_IRQ_EN;
+
+	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
 
 static const struct mmc_host_ops mxcmci_ops = {
-	.request	= mxcmci_request,
-	.set_ios	= mxcmci_set_ios,
-	.get_ro		= mxcmci_get_ro,
+	.request		= mxcmci_request,
+	.set_ios		= mxcmci_set_ios,
+	.get_ro			= mxcmci_get_ro,
+	.enable_sdio_irq	= mxcmci_enable_sdio_irq,
 };
 
 static int mxcmci_probe(struct platform_device *pdev)
@@ -706,7 +740,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	}
 
 	mmc->ops = &mxcmci_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
 
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_hw_segs = 64;
@@ -725,6 +759,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->pdata = pdev->dev.platform_data;
+	spin_lock_init(&host->lock);
 
 	if (host->pdata && host->pdata->ocr_avail)
 		mmc->ocr_avail = host->pdata->ocr_avail;
-- 
1.7.0

