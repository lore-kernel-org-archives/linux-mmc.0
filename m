From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 2/5] mmc: mxcmmc: add mpc512x SDHC support
Date: Mon,  8 Apr 2013 23:28:06 +0200
Message-ID: <1365456489-13152-3-git-send-email-agust@denx.de>
References: <1365456489-13152-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46646 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009Ab3DHV2j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 17:28:39 -0400
In-Reply-To: <1365456489-13152-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Anatolij Gustschin <agust@denx.de>

The SDHC controller on mpc512x is compatible with i.MX31 SDHC,
so the mxcmmc driver can be used on mpc512x, too. Extend the
driver to support mpc512x as well.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v3:
 - no changes, only add Acked-by tag

v2:
 - change to select register accessors at build time
   and use ioread32be() and iowrite32be() accessors
 - drop 512x specific clk_get() changes for now
 - rebase on top of v3 mxcmmc DT support patch from
   Markus https://patchwork.kernel.org/patch/2368631

 drivers/mmc/host/Kconfig  |   10 ++--
 drivers/mmc/host/mxcmmc.c |  133 ++++++++++++++++++++++++++++++---------------
 2 files changed, 94 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f83f245..9ab8f8d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -320,12 +320,12 @@ config MMC_MSM
 	  support for SDIO devices.
 
 config MMC_MXC
-	tristate "Freescale i.MX21/27/31 Multimedia Card Interface support"
-	depends on ARCH_MXC
+	tristate "Freescale i.MX21/27/31 or MPC512x Multimedia Card support"
+	depends on ARCH_MXC || PPC_MPC512x
 	help
-	  This selects the Freescale i.MX21, i.MX27 and i.MX31 Multimedia card
-	  Interface. If you have a i.MX platform with a Multimedia Card slot,
-	  say Y or M here.
+	  This selects the Freescale i.MX21, i.MX27, i.MX31 or MPC512x
+	  Multimedia Card Interface. If you have an i.MX or MPC512x platform
+	  with a Multimedia Card slot, say Y or M here.
 
 	  If unsure, say N.
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 8ae7cf5..9845b2d 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -41,7 +41,6 @@
 
 #include <asm/dma.h>
 #include <asm/irq.h>
-#include <asm/sizes.h>
 #include <linux/platform_data/mmc-mxcmmc.h>
 
 #include <linux/platform_data/dma-imx.h>
@@ -119,6 +118,7 @@
 enum mxcmci_type {
 	IMX21_MMC,
 	IMX31_MMC,
+	MPC512X_MMC,
 };
 
 struct mxcmci_host {
@@ -172,6 +172,9 @@ static struct platform_device_id mxcmci_devtype[] = {
 		.name = "imx31-mmc",
 		.driver_data = IMX31_MMC,
 	}, {
+		.name = "mpc512x-sdhc",
+		.driver_data = MPC512X_MMC,
+	}, {
 		/* sentinel */
 	}
 };
@@ -185,6 +188,9 @@ static const struct of_device_id mxcmci_of_match[] = {
 		.compatible = "fsl,imx31-mmc",
 		.data = &mxcmci_devtype[IMX31_MMC],
 	}, {
+		.compatible = "fsl,mpc5121-sdhc",
+		.data = &mxcmci_devtype[MPC512X_MMC],
+	}, {
 		/* sentinel */
 	}
 };
@@ -195,6 +201,43 @@ static inline int is_imx31_mmc(struct mxcmci_host *host)
 	return host->devtype == IMX31_MMC;
 }
 
+static inline int is_mpc512x_mmc(struct mxcmci_host *host)
+{
+	return host->devtype == MPC512X_MMC;
+}
+
+static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
+{
+	if (IS_ENABLED(CONFIG_PPC_MPC512x))
+		return ioread32be(host->base + reg);
+	else
+		return readl(host->base + reg);
+}
+
+static inline void mxcmci_writel(struct mxcmci_host *host, u32 val, int reg)
+{
+	if (IS_ENABLED(CONFIG_PPC_MPC512x))
+		iowrite32be(val, host->base + reg);
+	else
+		writel(val, host->base + reg);
+}
+
+static inline u16 mxcmci_readw(struct mxcmci_host *host, int reg)
+{
+	if (IS_ENABLED(CONFIG_PPC_MPC512x))
+		return ioread32be(host->base + reg);
+	else
+		return readw(host->base + reg);
+}
+
+static inline void mxcmci_writew(struct mxcmci_host *host, u16 val, int reg)
+{
+	if (IS_ENABLED(CONFIG_PPC_MPC512x))
+		iowrite32be(val, host->base + reg);
+	else
+		writew(val, host->base + reg);
+}
+
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
 
 static inline void mxcmci_init_ocr(struct mxcmci_host *host)
@@ -246,14 +289,14 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 	dev_dbg(mmc_dev(host->mmc), "mxcmci_softreset\n");
 
 	/* reset sequence */
-	writew(STR_STP_CLK_RESET, host->base + MMC_REG_STR_STP_CLK);
-	writew(STR_STP_CLK_RESET | STR_STP_CLK_START_CLK,
-			host->base + MMC_REG_STR_STP_CLK);
+	mxcmci_writew(host, STR_STP_CLK_RESET, MMC_REG_STR_STP_CLK);
+	mxcmci_writew(host, STR_STP_CLK_RESET | STR_STP_CLK_START_CLK,
+			MMC_REG_STR_STP_CLK);
 
 	for (i = 0; i < 8; i++)
-		writew(STR_STP_CLK_START_CLK, host->base + MMC_REG_STR_STP_CLK);
+		mxcmci_writew(host, STR_STP_CLK_START_CLK, MMC_REG_STR_STP_CLK);
 
-	writew(0xff, host->base + MMC_REG_RES_TO);
+	mxcmci_writew(host, 0xff, MMC_REG_RES_TO);
 }
 static int mxcmci_setup_dma(struct mmc_host *mmc);
 
@@ -272,8 +315,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	host->data = data;
 	data->bytes_xfered = 0;
 
-	writew(nob, host->base + MMC_REG_NOB);
-	writew(blksz, host->base + MMC_REG_BLK_LEN);
+	mxcmci_writew(host, nob, MMC_REG_NOB);
+	mxcmci_writew(host, blksz, MMC_REG_BLK_LEN);
 	host->datasize = datasize;
 
 	if (!mxcmci_use_dma(host))
@@ -329,13 +372,13 @@ static void mxcmci_dma_callback(void *data)
 
 	del_timer(&host->watchdog);
 
-	stat = readl(host->base + MMC_REG_STATUS);
-	writel(stat & ~STATUS_DATA_TRANS_DONE, host->base + MMC_REG_STATUS);
+	stat = mxcmci_readl(host, MMC_REG_STATUS);
+	mxcmci_writel(host, stat & ~STATUS_DATA_TRANS_DONE, MMC_REG_STATUS);
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
 	if (stat & STATUS_READ_OP_DONE)
-		writel(STATUS_READ_OP_DONE, host->base + MMC_REG_STATUS);
+		mxcmci_writel(host, STATUS_READ_OP_DONE, MMC_REG_STATUS);
 
 	mxcmci_data_done(host, stat);
 }
@@ -383,12 +426,12 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->use_sdio)
 		int_cntr |= INT_SDIO_IRQ_EN;
-	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
+	mxcmci_writel(host, int_cntr, MMC_REG_INT_CNTR);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	writew(cmd->opcode, host->base + MMC_REG_CMD);
-	writel(cmd->arg, host->base + MMC_REG_ARG);
-	writew(cmdat, host->base + MMC_REG_CMD_DAT_CONT);
+	mxcmci_writew(host, cmd->opcode, MMC_REG_CMD);
+	mxcmci_writel(host, cmd->arg, MMC_REG_ARG);
+	mxcmci_writew(host, cmdat, MMC_REG_CMD_DAT_CONT);
 
 	return 0;
 }
@@ -402,7 +445,7 @@ static void mxcmci_finish_request(struct mxcmci_host *host,
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->use_sdio)
 		int_cntr |= INT_SDIO_IRQ_EN;
-	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
+	mxcmci_writel(host, int_cntr, MMC_REG_INT_CNTR);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	host->req = NULL;
@@ -477,14 +520,14 @@ static void mxcmci_read_response(struct mxcmci_host *host, unsigned int stat)
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
 			for (i = 0; i < 4; i++) {
-				a = readw(host->base + MMC_REG_RES_FIFO);
-				b = readw(host->base + MMC_REG_RES_FIFO);
+				a = mxcmci_readw(host, MMC_REG_RES_FIFO);
+				b = mxcmci_readw(host, MMC_REG_RES_FIFO);
 				cmd->resp[i] = a << 16 | b;
 			}
 		} else {
-			a = readw(host->base + MMC_REG_RES_FIFO);
-			b = readw(host->base + MMC_REG_RES_FIFO);
-			c = readw(host->base + MMC_REG_RES_FIFO);
+			a = mxcmci_readw(host, MMC_REG_RES_FIFO);
+			b = mxcmci_readw(host, MMC_REG_RES_FIFO);
+			c = mxcmci_readw(host, MMC_REG_RES_FIFO);
 			cmd->resp[0] = a << 24 | b << 8 | c >> 8;
 		}
 	}
@@ -496,7 +539,7 @@ static int mxcmci_poll_status(struct mxcmci_host *host, u32 mask)
 	unsigned long timeout = jiffies + HZ;
 
 	do {
-		stat = readl(host->base + MMC_REG_STATUS);
+		stat = mxcmci_readl(host, MMC_REG_STATUS);
 		if (stat & STATUS_ERR_MASK)
 			return stat;
 		if (time_after(jiffies, timeout)) {
@@ -520,7 +563,7 @@ static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
 				STATUS_BUF_READ_RDY | STATUS_READ_OP_DONE);
 		if (stat)
 			return stat;
-		*buf++ = readl(host->base + MMC_REG_BUFFER_ACCESS);
+		*buf++ = cpu_to_le32(mxcmci_readl(host, MMC_REG_BUFFER_ACCESS));
 		bytes -= 4;
 	}
 
@@ -532,7 +575,7 @@ static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
 				STATUS_BUF_READ_RDY | STATUS_READ_OP_DONE);
 		if (stat)
 			return stat;
-		tmp = readl(host->base + MMC_REG_BUFFER_ACCESS);
+		tmp = cpu_to_le32(mxcmci_readl(host, MMC_REG_BUFFER_ACCESS));
 		memcpy(b, &tmp, bytes);
 	}
 
@@ -548,7 +591,7 @@ static int mxcmci_push(struct mxcmci_host *host, void *_buf, int bytes)
 		stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
 		if (stat)
 			return stat;
-		writel(*buf++, host->base + MMC_REG_BUFFER_ACCESS);
+		mxcmci_writel(host, cpu_to_le32(*buf++), MMC_REG_BUFFER_ACCESS);
 		bytes -= 4;
 	}
 
@@ -561,7 +604,7 @@ static int mxcmci_push(struct mxcmci_host *host, void *_buf, int bytes)
 			return stat;
 
 		memcpy(&tmp, b, bytes);
-		writel(tmp, host->base + MMC_REG_BUFFER_ACCESS);
+		mxcmci_writel(host, cpu_to_le32(tmp), MMC_REG_BUFFER_ACCESS);
 	}
 
 	stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
@@ -607,8 +650,8 @@ static void mxcmci_datawork(struct work_struct *work)
 						  datawork);
 	int datastat = mxcmci_transfer_data(host);
 
-	writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
-		host->base + MMC_REG_STATUS);
+	mxcmci_writel(host, STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
+		MMC_REG_STATUS);
 	mxcmci_finish_data(host, datastat);
 
 	if (host->req->stop) {
@@ -686,9 +729,11 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 	bool sdio_irq;
 	u32 stat;
 
-	stat = readl(host->base + MMC_REG_STATUS);
-	writel(stat & ~(STATUS_SDIO_INT_ACTIVE | STATUS_DATA_TRANS_DONE |
-			STATUS_WRITE_OP_DONE), host->base + MMC_REG_STATUS);
+	stat = mxcmci_readl(host, MMC_REG_STATUS);
+	mxcmci_writel(host,
+		stat & ~(STATUS_SDIO_INT_ACTIVE | STATUS_DATA_TRANS_DONE |
+			 STATUS_WRITE_OP_DONE),
+		MMC_REG_STATUS);
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
@@ -698,11 +743,11 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 
 	if (mxcmci_use_dma(host) &&
 	    (stat & (STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE)))
-		writel(STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
-			host->base + MMC_REG_STATUS);
+		mxcmci_writel(host, STATUS_READ_OP_DONE | STATUS_WRITE_OP_DONE,
+			MMC_REG_STATUS);
 
 	if (sdio_irq) {
-		writel(STATUS_SDIO_INT_ACTIVE, host->base + MMC_REG_STATUS);
+		mxcmci_writel(host, STATUS_SDIO_INT_ACTIVE, MMC_REG_STATUS);
 		mmc_signal_sdio_irq(host->mmc);
 	}
 
@@ -784,7 +829,7 @@ static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios)
 			prescaler <<= 1;
 	}
 
-	writew((prescaler << 4) | divider, host->base + MMC_REG_CLK_RATE);
+	mxcmci_writew(host, (prescaler << 4) | divider, MMC_REG_CLK_RATE);
 
 	dev_dbg(mmc_dev(host->mmc), "scaler: %d divider: %d in: %d out: %d\n",
 			prescaler, divider, clk_in, clk_ios);
@@ -847,9 +892,9 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		mxcmci_set_clk_rate(host, ios->clock);
-		writew(STR_STP_CLK_START_CLK, host->base + MMC_REG_STR_STP_CLK);
+		mxcmci_writew(host, STR_STP_CLK_START_CLK, MMC_REG_STR_STP_CLK);
 	} else {
-		writew(STR_STP_CLK_STOP_CLK, host->base + MMC_REG_STR_STP_CLK);
+		mxcmci_writew(host, STR_STP_CLK_STOP_CLK, MMC_REG_STR_STP_CLK);
 	}
 
 	host->clock = ios->clock;
@@ -886,14 +931,14 @@ static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->use_sdio = enable;
-	int_cntr = readl(host->base + MMC_REG_INT_CNTR);
+	int_cntr = mxcmci_readl(host, MMC_REG_INT_CNTR);
 
 	if (enable)
 		int_cntr |= INT_SDIO_IRQ_EN;
 	else
 		int_cntr &= ~INT_SDIO_IRQ_EN;
 
-	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
+	mxcmci_writel(host, int_cntr, MMC_REG_INT_CNTR);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
@@ -931,7 +976,7 @@ static void mxcmci_watchdog(unsigned long data)
 	struct mmc_host *mmc = (struct mmc_host *)data;
 	struct mxcmci_host *host = mmc_priv(mmc);
 	struct mmc_request *req = host->req;
-	unsigned int stat = readl(host->base + MMC_REG_STATUS);
+	unsigned int stat = mxcmci_readl(host, MMC_REG_STATUS);
 
 	if (host->dma_dir == DMA_FROM_DEVICE) {
 		dmaengine_terminate_all(host->dma);
@@ -974,7 +1019,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
 
-	pr_info("i.MX SDHC driver\n");
+	pr_info("i.MX/MPC512x SDHC driver\n");
 
 	of_id = of_match_device(mxcmci_of_match, &pdev->dev);
 
@@ -1060,7 +1105,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	mxcmci_softreset(host);
 
-	host->rev_no = readw(host->base + MMC_REG_REV_NO);
+	host->rev_no = mxcmci_readw(host, MMC_REG_REV_NO);
 	if (host->rev_no != 0x400) {
 		ret = -ENODEV;
 		dev_err(mmc_dev(host->mmc), "wrong rev.no. 0x%08x. aborting.\n",
@@ -1072,9 +1117,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->f_max = clk_get_rate(host->clk_per) >> 1;
 
 	/* recommended in data sheet */
-	writew(0x2db4, host->base + MMC_REG_READ_TO);
+	mxcmci_writew(host, 0x2db4, MMC_REG_READ_TO);
 
-	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
+	mxcmci_writel(host, host->default_irq_mask, MMC_REG_INT_CNTR);
 
 	if (!host->pdata) {
 		host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
-- 
1.7.5.4

