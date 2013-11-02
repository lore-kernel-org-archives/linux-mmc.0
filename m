From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Sat,  2 Nov 2013 21:26:14 +0100
Message-ID: <1383423976-24798-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

For now, only support SDIO interrupt if we are booted with
DT. This is because some platforms need special quirks. And
we don't want to add new legacy mux platform init code
callbacks any longer as we are moving to DT based booting
anyways.

Broken hardware, missing the swakueup line, should fallback
to polling, by setting 'ti,quirk-swakup-missing' in the
device tree. Otherwise pending SDIO IRQ are not detected
while in suspend. This affects am33xx processors.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
For the DT-Binding portion:
Acked-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   18 ++++
 drivers/mmc/host/omap_hsmmc.c                      |   86 ++++++++++++++++++--
 2 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index ed271fc..1136e6b 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -20,6 +20,24 @@ ti,dual-volt: boolean, supports dual voltage cards
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
+ti,quirk-swakup-missing: SOC missing the swakeup line, will not detect
+SDIO irq while in suspend. Fallback to polling. Affected chips are
+am335x,
+
+                            ------
+                            | PRCM |
+                             ------
+                              ^ |
+                      swakeup | | fclk
+                              | v
+      ------                -------               -----
+     | card | -- CIRQ -->  | hsmmc | -- IRQ -->  | CPU |
+      ------                -------               -----
+
+In suspend the fclk is off and the module is disfunctional. Even
+register reads will fail. A small logic in the host will request fclk
+restore, when an external event is detected. Once the clock is
+restored, the host detects the event normally.
 
 Example:
 	mmc1: mmc@0x4809c000 {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b392130..6b0ec55 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -130,6 +130,7 @@ static void apply_clk_hack(struct device *dev)
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -210,6 +211,9 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	int                     flags;
+#define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
+
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -490,27 +494,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
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
+
+	/* latch pending CIRQ, but don't signal */
+	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
+		irq_mask |= CIRQ_EN;
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
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
+	/* no transfer running, need to signal cirq if enabled */
+	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
+		irq_mask |= CIRQ_EN;
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -1067,8 +1084,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
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
@@ -1583,6 +1604,37 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 		mmc_slot(host).init_card(card);
 }
 
+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	u32 irq_mask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+
+	irq_mask = OMAP_HSMMC_READ(host->base, ISE);
+	if (enable) {
+		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
+		irq_mask |= CIRQ_EN;
+	} else {
+		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
+		irq_mask &= ~CIRQ_EN;
+	}
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+
+	/*
+	 * if enable, piggy back detection on current request
+	 * but always disable immediately
+	 */
+	if (!host->req_in_progress || !enable)
+		OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+
+	/* flush posted write */
+	OMAP_HSMMC_READ(host->base, IE);
+
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1635,7 +1687,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -2021,6 +2073,22 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			"pins are not configured from the driver\n");
 
+	/*
+	 * For now, only support SDIO interrupt if we are booted with
+	 * DT. This is because some platforms need special quirks. And
+	 * we don't want to add new legacy mux platform init code
+	 * callbacks any longer as we are moving to DT based booting
+	 * anyways.
+	 */
+	if (pdev->dev.of_node) {
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+		if (of_find_property(host->dev->of_node,
+				     "ti,quirk-swakeup-missing", NULL)) {
+			/* no wakeup from deeper power states, use polling */
+			mmc->caps &= ~MMC_CAP_SDIO_IRQ;
+		}
+	}
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
-- 
1.7.10.4

