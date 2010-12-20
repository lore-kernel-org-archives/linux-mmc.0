From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 1/6 v2] mmc: tmio: implement SDIO IRQ
Date: Mon, 20 Dec 2010 15:53:46 +0000
Message-ID: <1292860431-16195-2-git-send-email-arnd@arndnet.de>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:34189 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758096Ab0LTQFI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Dec 2010 11:05:08 -0500
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>

This patch implements SDIO IRQ support for mfds which
announce the TMIO_MMC_SDIO_IRQ flag for tmio_mmc.
If MMC_CAP_SDIO_IRQ is also set SDIO IRQ signalling is activated.
Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.

This patch applies on top of:
mmc: tmio_mmc: allow multi-element scatter-gather lists
mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
mmc: tmio: merge the private header into the driver
mmc: tmio: implement a bounce buffer for unaligned DMA

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
Changes in v2:
 - added TMIO_MMC_SDIO_IRQ flag to support the case where SDIO IRQ
   interrupts are generated but SDIO IRQ signalling to the core
   should not be used
 - rearranged code, so that either an SDIO IRQ or a normal IRQ is
   handled, this marginally increases interrupt load, but preserves
   the current timing, which seems to be crucial for DMA handling

 drivers/mmc/host/tmio_mmc.c |   61 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/tmio.h    |    4 +++
 2 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 57ece9d..18771b4 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -53,6 +53,8 @@
 #define CTL_SD_ERROR_DETAIL_STATUS 0x2c
 #define CTL_SD_DATA_PORT 0x30
 #define CTL_TRANSACTION_CTL 0x34
+#define CTL_SDIO_STATUS 0x36
+#define CTL_SDIO_IRQ_MASK 0x38
 #define CTL_RESET_SD 0xe0
 #define CTL_SDIO_REGS 0x100
 #define CTL_CLK_AND_WAIT_CTL 0x138
@@ -81,6 +83,12 @@
 #define TMIO_STAT_CMD_BUSY      0x40000000
 #define TMIO_STAT_ILL_ACCESS    0x80000000
 
+/* Definitions for values the CTRL_SDIO_STATUS register can take. */
+#define TMIO_SDIO_STAT_IOIRQ	0x0001
+#define TMIO_SDIO_STAT_EXPUB52	0x4000
+#define TMIO_SDIO_STAT_EXWT	0x8000
+#define TMIO_SDIO_MASK_ALL	0xc007
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
@@ -122,6 +130,7 @@ struct tmio_mmc_host {
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
 	int                     irq;
+	unsigned int		sdio_irq_enabled;
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
@@ -247,6 +256,22 @@ void pr_debug_status(u32 status)
 #define pr_debug_status(s)  do { } while (0)
 #endif
 
+static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (enable) {
+		host->sdio_irq_enabled = 1;
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK,
+		(TMIO_SDIO_MASK_ALL & ~TMIO_SDIO_STAT_IOIRQ));
+	} else {
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, TMIO_SDIO_MASK_ALL);
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
+		host->sdio_irq_enabled = 0;
+	}
+}
+
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 {
 	u32 clk = 0, clock;
@@ -275,10 +300,16 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
+	struct mfd_cell *cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(10);
 	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+	/* restore sdio irq state */
+	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
+		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
 	msleep(10);
 }
 
@@ -556,7 +587,10 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
 	unsigned int ireg, irq_mask, status;
+	unsigned int sdio_ireg, sdio_irq_mask, sdio_status;
 
 	pr_debug("MMC IRQ begin\n");
 
@@ -564,10 +598,33 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
 	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
 
+	sdio_ireg = 0;
+	if (!ireg && pdata->flags & TMIO_MMC_SDIO_IRQ) {
+		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
+		sdio_irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
+		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL & ~sdio_irq_mask;
+
+		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
+
+		if (sdio_ireg && !host->sdio_irq_enabled) {
+			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
+				sdio_status, sdio_irq_mask, sdio_ireg);
+			tmio_mmc_enable_sdio_irq(host, 0);
+			goto out;
+		}
+
+		if (host->mmc->caps & MMC_CAP_SDIO_IRQ &&
+			sdio_ireg & TMIO_SDIO_STAT_IOIRQ)
+			mmc_signal_sdio_irq(host->mmc);
+
+		if (sdio_ireg)
+			goto out;
+	}
+
 	pr_debug_status(status);
 	pr_debug_status(ireg);
 
 	if (!ireg) {
 		disable_mmc_irqs(host, status & ~irq_mask);
 
 		pr_warning("tmio_mmc: Spurious irq, disabling! "
@@ -1033,6 +1089,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= tmio_mmc_get_cd,
+	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_PM
@@ -1147,6 +1204,8 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 		goto cell_disable;
 
 	disable_mmc_irqs(host, TMIO_MASK_ALL);
+	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
+		tmio_mmc_enable_sdio_irq(mmc, 0);
 
 	ret = request_irq(host->irq, tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&dev->dev), host);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index dbfc053..8e70310 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -57,6 +57,10 @@
  * is configured in 4-bit mode.
  */
 #define TMIO_MMC_BLKSZ_2BYTES		(1 << 1)
+/*
+ * Some controllers can support SDIO IRQ signalling.
+ */
+#define TMIO_MMC_SDIO_IRQ		(1 << 2)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
-- 
1.7.2.3

