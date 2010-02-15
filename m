From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/3] [MMCI] remove custom DBG macro and printk
Date: Mon, 15 Feb 2010 12:23:36 +0100
Message-ID: <1266233016-16554-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:55601 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754963Ab0BOLXi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Feb 2010 06:23:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>

This removes the custom DBG macro in favor of the in-kernel
dev_dbg() macro. Probably a leftover from a time when dev_dbg()
didn't yet exist. Also remove a printk() in favor of dev_err().

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 72f23e9..2ea7dad 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,9 +37,6 @@
 
 #define DRIVER_NAME "mmci-pl18x"
 
-#define DBG(host,fmt,args...)	\
-	pr_debug("%s: %s: " fmt, mmc_hostname(host->mmc), __func__ , args)
-
 static unsigned int fmax = 515633;
 
 /*
@@ -106,8 +103,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
 
-	DBG(host, "op %02x arg %08x flags %08x\n",
-	    cmd->opcode, cmd->arg, cmd->flags);
+	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
+		cmd->opcode, cmd->arg, cmd->flags);
 
 	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
 		writel(0, base + MMCICOMMAND);
@@ -291,8 +288,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	int blksz_bits;
 	int ret;
 
-	DBG(host, "blksz %04x blks %04x flags %08x\n",
-	    data->blksz, data->blocks, data->flags);
+	dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
+		data->blksz, data->blocks, data->flags);
 
 	host->data = data;
 	host->size = data->blksz;
@@ -498,7 +495,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 
 	status = readl(base + MMCISTATUS);
 
-	DBG(host, "irq1 %08x\n", status);
+	dev_dbg(mmc_dev(host->mmc), "irq1 (pio) %08x\n", status);
 
 	do {
 		unsigned long flags;
@@ -592,7 +589,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
-		DBG(host, "irq0 %08x\n", status);
+		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
 		data = host->data;
 		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
@@ -619,8 +616,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq != NULL);
 
 	if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
-		printk(KERN_ERR "%s: Unsupported block size (%d bytes)\n",
-			mmc_hostname(mmc), mrq->data->blksz);
+		dev_err(mmc_dev(mmc), "unsupported block size (%d bytes)\n",
+			mrq->data->blksz);
 		mrq->cmd->error = -EINVAL;
 		mmc_request_done(mmc, mrq);
 		return;
@@ -773,8 +770,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
-	DBG(host, "designer ID = 0x%02x\n", host->hw_designer);
-	DBG(host, "revision = 0x%01x\n", host->hw_revision);
+	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
+	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
 	host->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(host->clk)) {
@@ -799,7 +796,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		if (ret < 0)
 			goto clk_disable;
 		host->mclk = clk_get_rate(host->clk);
-		DBG(host, "eventual mclk rate: %u Hz\n", host->mclk);
+		dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
+			host->mclk);
 	}
 	host->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!host->base) {
-- 
1.6.3.3

