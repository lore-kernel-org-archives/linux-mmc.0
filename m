From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 1/4] mmc: tmio: Implement SDIO IRQ
Date: Mon,  6 Dec 2010 12:35:39 -0500
Message-ID: <1291656942-18100-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:56220 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753242Ab0LFRgI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Dec 2010 12:36:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Arnd Hannemann <arnd@arndnet.de>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

This patch implements SDIO IRQ support for mfds which
announce the MMC_CAP_SDIO_IRQ capability for tmio_mmc.
Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.

This patch applies on top of:
mmc: tmio_mmc: allow multi-element scatter-gather lists
mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
mmc: tmio: merge the private header into the driver
mmc: tmio: implement a bounce buffer for unaligned DMA

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
CC: Ian Molton <ian@mnementh.co.uk>
CC: Samuel Ortiz <sameo@linux.intel.com>
CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |   54 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 57ece9d..dbb1105 100644
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
@@ -279,6 +304,9 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(10);
 	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+	/* restore sdio irq state */
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
 	msleep(10);
 }
 
@@ -557,6 +585,7 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	unsigned int ireg, irq_mask, status;
+	unsigned int sdio_ireg, sdio_irq_mask, sdio_status;
 
 	pr_debug("MMC IRQ begin\n");
 
@@ -564,10 +593,30 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
 	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
 
+	sdio_ireg = 0;
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
+		sdio_irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
+		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL & ~sdio_irq_mask;
+
+		if (sdio_ireg || (!ireg && !host->sdio_irq_enabled))
+			pr_debug("%s: sdio_i=0x%04x sdio_s=0x%04x "
+				"mask=0x%04x ireg=0x%08x spur=%u\n",
+				mmc_hostname(host->mmc),
+				sdio_ireg, sdio_status, sdio_irq_mask, ireg,
+				!ireg && !host->sdio_irq_enabled);
+
+		/* ack all sdio interrupts... */
+		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
+
+		if (sdio_ireg & TMIO_SDIO_STAT_IOIRQ)
+			mmc_signal_sdio_irq(host->mmc);
+	}
+
 	pr_debug_status(status);
 	pr_debug_status(ireg);
 
-	if (!ireg) {
+	if (!ireg && !sdio_ireg) {
 		disable_mmc_irqs(host, status & ~irq_mask);
 
 		pr_warning("tmio_mmc: Spurious irq, disabling! "
@@ -1033,6 +1082,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= tmio_mmc_get_cd,
+	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_PM
@@ -1147,6 +1197,8 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 		goto cell_disable;
 
 	disable_mmc_irqs(host, TMIO_MASK_ALL);
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		tmio_mmc_enable_sdio_irq(mmc, 0);
 
 	ret = request_irq(host->irq, tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&dev->dev), host);
-- 
1.7.0.4

