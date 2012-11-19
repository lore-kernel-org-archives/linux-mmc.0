From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH 2/3] mmc: omap_hsmmc: Enable the use of SDIO card interrupts.
Date: Mon, 19 Nov 2012 22:42:58 +0100
Message-ID: <1353361379-21002-3-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:58488 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752314Ab2KSVnv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 16:43:51 -0500
In-Reply-To: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: david.vrabel@csr.com, daniel@zonque.org, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

FCLK must be enabled while SDIO interrupts are enabled or the MMC
module won't wake-up (even though ENAWAKEUP in SYSCONFIG and IWE in
HTCL have been set).  Enabling the MMC module to wake-up would require
configuring the MMC module (and the mmci_dat[1] GPIO when the CORE
power domain is OFF) as wake-up sources in the PRCM.

The writes to STAT and ISE when starting a command are unnecessary and
have been removed.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/mmc/host/omap_hsmmc.c          |   99 ++++++++++++++++++++++++++++----
 include/linux/platform_data/mmc-omap.h |    1 +
 2 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 13ef4a0..90f4b32 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -106,7 +106,10 @@ static void apply_clk_hack(void)
 #define INT_EN_MASK		0x307F0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
+#define CIRQ_ENABLE		(1 << 8)
 #define DTO_ENABLE		(1 << 20)
+#define CTPL			(1 << 11)
+#define CLKEXTFREE		(1 << 16)
 #define INIT_STREAM		(1 << 1)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
@@ -115,10 +118,12 @@ static void apply_clk_hack(void)
 #define BCE			(1 << 1)
 #define FOUR_BIT		(1 << 1)
 #define DDR			(1 << 19)
+#define IWE			(1 << 24)
 #define DW8			(1 << 5)
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
+#define CIRQ			(1 << 8)
 #define ERR			(1 << 15)
 #define CMD_TIMEOUT		(1 << 16)
 #define DATA_TIMEOUT		(1 << 20)
@@ -196,6 +201,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	bool			sdio_int;
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
@@ -472,27 +478,45 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 				  struct mmc_command *cmd)
 {
-	unsigned int irq_mask;
+	u32 irq_mask = INT_EN_MASK;
+	unsigned long flags;
 
 	if (host->use_dma)
-		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
-	else
-		irq_mask = INT_EN_MASK;
+		irq_mask &= ~(BRR_ENABLE | BWR_ENABLE);
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_ENABLE;
 
+	spin_lock_irqsave(&host->irq_lock, flags);
+
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+	/* latch pending CIRQ, but don't signal */
+	if (host->sdio_int)
+		irq_mask |= CIRQ_ENABLE;
+
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
 {
-	OMAP_HSMMC_WRITE(host->base, ISE, 0);
-	OMAP_HSMMC_WRITE(host->base, IE, 0);
+	u32 irq_mask = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	if (host->sdio_int)
+		irq_mask |= CIRQ_ENABLE;
+
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -615,7 +639,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	}
 
 	OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
+			OMAP_HSMMC_READ(host->base, HCTL) | hctl | IWE);
 
 	OMAP_HSMMC_WRITE(host->base, CAPA,
 			OMAP_HSMMC_READ(host->base, CAPA) | capa);
@@ -1040,8 +1064,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
-	while (status & INT_EN_MASK && host->req_in_progress) {
-		omap_hsmmc_do_irq(host, status);
+	while (status & (INT_EN_MASK | CIRQ)) {
+
+		if (host->req_in_progress)
+			omap_hsmmc_do_irq(host, status);
+
+		if (status & CIRQ)
+			mmc_signal_sdio_irq(host->mmc);
 
 		/* Flush posted write */
 		OMAP_HSMMC_WRITE(host->base, STAT, status);
@@ -1557,6 +1586,50 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 		mmc_slot(host).init_card(card);
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	struct omap_mmc_platform_data *pdata = host->pdata;
+	u32 con, irq_mask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	con = OMAP_HSMMC_READ(host->base, CON);
+	irq_mask = OMAP_HSMMC_READ(host->base, ISE);
+	if (enable) {
+		irq_mask |= CIRQ_ENABLE;
+		con |= CTPL;
+		host->sdio_int = true;
+	} else {
+		irq_mask &= ~CIRQ_ENABLE;
+		con &= ~CTPL;
+		host->sdio_int = false;
+	}
+	OMAP_HSMMC_WRITE(host->base, CON, con);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_READ(host->base, IE); /* flush posted write */
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+
+	if (pdata->controller_flags & OMAP_HSMMC_SWAKEUP_NOT_IMPLEMENTED) {
+		/* FCLK must be enabled as wake-up does not work. Take care to
+		 * disable FCLK after all the register accesses as they might
+		 * not complete if FCLK is off.
+		 *
+		 * FIXME: if the MMC module (and the mmci_dat[1] GPIO when the
+		 * CORE power domain is OFF) are configured as a wake-up
+		 * sources in the PRCM, then FCLK could be switched off.  This
+		 * might add too much latency.
+		 */
+		if (enable)
+			pm_runtime_get(host->dev);
+		else
+			pm_runtime_put_noidle(host->dev);
+	}
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1571,7 +1644,7 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	}
 
 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
-	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
+	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl | IWE);
 
 	value = OMAP_HSMMC_READ(host->base, CAPA);
 	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
@@ -1609,7 +1682,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1802,6 +1875,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
+	host->sdio_int	= false;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -1879,7 +1953,8 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE |
+		     MMC_CAP_SDIO_IRQ;
 
 	mmc->caps |= mmc_slot(host).caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 2bf6ea8..65b24cd 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -28,6 +28,7 @@
  */
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
+#define OMAP_HSMMC_SWAKEUP_NOT_IMPLEMENTED	BIT(2)
 
 struct mmc_card;
 
-- 
1.7.10.4

