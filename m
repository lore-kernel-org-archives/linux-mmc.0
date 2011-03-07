From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5] mmc: tmio: add a flag to prohibit access to registers
 above 0xff
Date: Mon, 7 Mar 2011 19:47:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071944200.29543@axis700.grange>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50473 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1CGSr4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 13:47:56 -0500
In-Reply-To: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On some implementations there are no registers above 0xff and any
access to them mirrors to registers at addresses with bit 8 masked
out, which leads to malfunction. Add a flag to prevent such accesses.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.c |   38 +++++++++++++++-----------------------
 include/linux/mfd/tmio.h    |    6 ++++++
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 91a31d2..5e880c06 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -306,19 +306,9 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 	struct mfd_cell *cell = host->pdev->dev.platform_data;
 	struct tmio_mmc_data *pdata = cell->driver_data;
 
-	/*
-	 * Testing on sh-mobile showed that SDIO IRQs are unmasked when
-	 * CTL_CLK_AND_WAIT_CTL gets written, so we have to disable the
-	 * device IRQ here and restore the SDIO IRQ mask before
-	 * re-enabling the device IRQ.
-	 */
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
-		disable_irq(host->irq);
-	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-	msleep(10);
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
-		enable_irq(host->irq);
+	if (!(pdata->flags & TMIO_MMC_HI_REGS_MISSING)) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+		msleep(10);
 	}
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -333,25 +323,27 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(10);
-	/* see comment in tmio_mmc_clk_stop above */
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
-		disable_irq(host->irq);
-	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-	msleep(10);
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		tmio_mmc_enable_sdio_irq(host->mmc, host->sdio_irq_enabled);
-		enable_irq(host->irq);
+	if (!(pdata->flags & TMIO_MMC_HI_REGS_MISSING)) {
+		if (pdata->flags & TMIO_MMC_SDIO_IRQ)
+			disable_irq(host->irq);
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+		msleep(10);
 	}
 }
 
 static void reset(struct tmio_mmc_host *host)
 {
+	struct mfd_cell *cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
+	if (!(pdata->flags & TMIO_MMC_HI_REGS_MISSING))
+		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	msleep(10);
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
-	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
+	if (!(pdata->flags & TMIO_MMC_HI_REGS_MISSING))
+		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	msleep(10);
 }
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 8e70310..243ad58 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -61,6 +61,12 @@
  * Some controllers can support SDIO IRQ signalling.
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
+/*
+ * Some controllers are missing all registers in the 0x100-0x1ff address range,
+ * on them accesses to the CTL_CLK_AND_WAIT_CTL (0x138) register end up in 0x38,
+ * which breaks the SDIO functionality.
+ */
+#define TMIO_MMC_HI_REGS_MISSING	(1 << 3)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
-- 
1.7.2.3

