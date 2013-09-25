From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Wed, 25 Sep 2013 16:47:40 -0700
Message-ID: <20130925234740.3745.50637.stgit@localhost>
References: <20130925234544.3745.55170.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130925234544.3745.55170.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

There have been various patches floating around for enabling
the SDIO IRQ for hsmmc, but none of them ever got merged.

Probably the reason for not merging the SDIO interrupt patches
has been the lack of wake-up path for SDIO on some omaps that
has also needed remuxing the SDIO DAT1 line to a GPIO making
the patches complex.

This patch adds the minimal SDIO IRQ support to hsmmc for
omaps that do have the wake-up path. For those omaps, the
DAT1 line need to have the wake-up enable bit set, and the
wake-up interrupt is the same as for the MMC controller.

This patch has been tested on am3730 es1.2 with wl12xx
connected to MMC2 with wl12xx waking to Ethernet traffic
from off-idle mode. Note that for omaps that do not have
the SDIO wake-up path, this patch will not work for idle
modes and further patches for remuxing DAT1 to GPIO are
needed.

Based on earlier patches [1][2] by David Vrabel
<david.vrabel@csr.com>, Steve Sakoman <steve@sakoman.com>
and Andreas Fenkart <andreas.fenkart@streamunlimited.com>
with the SDIO IRQ handing improved following how sdhci.c
is doing it.

[1] http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux.git;a=commitdiff_plain;h=010810d22f6f49ac03da4ba384969432e0320453
[2] http://comments.gmane.org/gmane.linux.kernel.mmc/20446

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   75 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index aa97497..e925c0e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -103,6 +103,7 @@
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -183,6 +184,11 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+
+	int			flags;
+#define HSMMC_RUNTIME_SUSPENDED	(1 << 0)	/* Runtime suspended */
+#define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)	/* SDIO irq enabled */
+
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -463,27 +469,34 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 				  struct mmc_command *cmd)
 {
-	unsigned int irq_mask;
+	u32 irq_mask = INT_EN_MASK;
+	unsigned long flags;
 
 	if (host->use_dma)
-		irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
-	else
-		irq_mask = INT_EN_MASK;
+		irq_mask &= ~(BRR_EN | BWR_EN);
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_EN;
 
+	spin_lock_irqsave(&host->irq_lock, flags);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
+		irq_mask |= CIRQ_EN;
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
 	OMAP_HSMMC_WRITE(host->base, ISE, 0);
 	OMAP_HSMMC_WRITE(host->base, IE, 0);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -1040,8 +1053,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
-	while (status & INT_EN_MASK && host->req_in_progress) {
-		omap_hsmmc_do_irq(host, status);
+	while (status & (INT_EN_MASK | CIRQ_EN)) {
+		if (host->req_in_progress)
+			omap_hsmmc_do_irq(host, status);
+
+		if (status & CIRQ_EN)
+			mmc_signal_sdio_irq(host->mmc);
 
 		/* Flush posted write */
 		status = OMAP_HSMMC_READ(host->base, STAT);
@@ -1556,6 +1573,43 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 		mmc_slot(host).init_card(card);
 }
 
+static void omap_hsmmc_enable_sdio_irq_nolock(struct omap_hsmmc_host *host,
+					 int enable)
+{
+	u32 irq_mask;
+
+	if (enable)
+		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
+	else
+		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
+
+	/* SDIO IRQ will be enabled as appropriate in runtime resume */
+	if (host->flags & HSMMC_RUNTIME_SUSPENDED)
+		goto out;
+
+	irq_mask = OMAP_HSMMC_READ(host->base, IE);
+	if (enable)
+		irq_mask |= CIRQ_EN;
+	else
+		irq_mask &= ~CIRQ_EN;
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+	if (!host->req_in_progress)
+		OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+out:
+	OMAP_HSMMC_READ(host->base, IE);
+}
+
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+	omap_hsmmc_enable_sdio_irq_nolock(host, enable);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1608,7 +1662,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1874,7 +1928,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE |
+		     MMC_CAP_SDIO_IRQ;
 
 	mmc->caps |= mmc_slot(host).caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
@@ -2172,6 +2227,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
+	host->flags |= HSMMC_RUNTIME_SUSPENDED;
 	dev_dbg(dev, "disabled\n");
 
 	return 0;
@@ -2183,6 +2239,9 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
+	host->flags &= ~HSMMC_RUNTIME_SUSPENDED;
+	if ((host->flags & HSMMC_SDIO_IRQ_ENABLED))
+		omap_hsmmc_enable_sdio_irq_nolock(host, true);
 	dev_dbg(dev, "enabled\n");
 
 	return 0;

