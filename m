From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v8 1/3] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Wed,  5 Mar 2014 09:27:48 +0100
Message-ID: <1394008070-30138-2-git-send-email-afenkart@gmail.com>
References: <1394008070-30138-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:48412 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbaCEIcn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 03:32:43 -0500
In-Reply-To: <1394008070-30138-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

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

This patch has been tested on am3730 es1.2 with mwifiex
connected to MMC3 with mwifiex waking to Ethernet traffic
from off-idle mode. Note that for omaps that do not have
the SDIO wake-up path, this patch will not work for idle
modes and further patches for remuxing DAT1 to GPIO are
needed.

Based on earlier patches [1][2] by David Vrabel
<david.vrabel@csr.com>, Steve Sakoman <steve@sakoman.com>
and Andreas Fenkart <afenkart@gmail.com> with the SDIO IRQ
handing improved following how sdhci.c is doing it.

For now, only support SDIO interrupt if we are booted with
a separate wake-irq configued via device tree. This is
because omaps need the wake-irq for idle states, and some
omaps need special quirks. And we don't want to add new
legacy mux platform init code callbacks any longer as we
are moving to DT based booting anyways.

To use it, you need to specify the wake-irq using the
interrupts-extended property.

[1] http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux.git;a=commitdiff_plain;h=010810d22f6f49ac03da4ba384969432e0320453
[2] http://comments.gmane.org/gmane.linux.kernel.mmc/20446

Cc: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f8b9c3b..47206c0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -29,6 +29,7 @@
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/omap-dma.h>
@@ -36,6 +37,7 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
@@ -131,6 +133,7 @@ static void apply_clk_hack(struct device *dev)
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -205,6 +208,8 @@ struct omap_hsmmc_host {
 	u32			sysctl;
 	u32			capa;
 	int			irq;
+	int			wake_irq;
+	int			wake_irq_en;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -215,6 +220,9 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	int                     flags;
+#define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
+#define HSMMC_SWAKEUP_QUIRK	(1 << 1)
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -495,27 +503,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
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
+	/* latch pending CIRQ, but don't signal MMC core */
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
+	/* no transfer running but need to keep cirq if enabled */
+	if (host->flags & HSMMC_SDIO_IRQ_ENABLED)
+		irq_mask |= CIRQ_EN;
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 }
 
 /* Calculate divisor for the given clock frequency */
@@ -1078,8 +1099,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
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
@@ -1088,6 +1113,45 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline void hsmmc_enable_wake_irq(struct omap_hsmmc_host *host)
+{
+	unsigned long flags;
+
+	if (!host->wake_irq)
+		return;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+	enable_irq(host->wake_irq);
+	host->wake_irq_en = true;
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
+static inline void hsmmc_disable_wake_irq(struct omap_hsmmc_host *host)
+{
+	unsigned long flags;
+
+	if (!host->wake_irq)
+		return;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+	if (host->wake_irq_en)
+		disable_irq_nosync(host->wake_irq);
+	host->wake_irq_en = false;
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
+static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+
+	/* cirq is level triggered, disable to avoid infinite loop */
+	hsmmc_disable_wake_irq(host);
+
+	pm_request_resume(host->dev); /* no use counter */
+
+	return IRQ_HANDLED;
+}
+
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1591,6 +1655,70 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
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
+static int omap_hscmm_configure_wake_irq(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	/*
+	 * The wake-irq is needed for omaps with wake-up path and also
+	 * when doing GPIO remuxing.
+	 */
+	if (!host->dev->of_node || !host->wake_irq)
+		return -ENODEV;
+
+	/* Prevent auto-enabling of IRQ */
+	irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
+	ret = request_irq(host->wake_irq, omap_hsmmc_wake_irq,
+			  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			  mmc_hostname(mmc), host);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc),
+			"Unable to request wake IRQ\n");
+		return ret;
+	}
+
+	/*
+	 * Some omaps don't have wake-up path from deeper idle states
+	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
+	 */
+	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING)
+		host->flags |= HSMMC_SWAKEUP_QUIRK;
+
+	return 0;
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1643,7 +1771,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1704,8 +1832,19 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 
 #endif
 
+struct of_data {
+	u16 offset;
+	int flags;
+};
+
 #ifdef CONFIG_OF
-static u16 omap4_reg_offset = 0x100;
+static struct of_data omap4_data = {
+	.offset	= 0x100,
+};
+static struct of_data am33xx_data = {
+	.offset	= 0x100,
+	.flags	= OMAP_HSMMC_SWAKEUP_MISSING,
+};
 
 static const struct of_device_id omap_mmc_of_match[] = {
 	{
@@ -1716,7 +1855,11 @@ static const struct of_device_id omap_mmc_of_match[] = {
 	},
 	{
 		.compatible = "ti,omap4-hsmmc",
-		.data = &omap4_reg_offset,
+		.data = &omap4_data,
+	},
+	{
+		.compatible = "ti,am33xx-hsmmc",
+		.data = &am33xx_data,
 	},
 	{},
 };
@@ -1779,6 +1922,7 @@ static inline struct omap_mmc_platform_data
 {
 	return NULL;
 }
+#define omap_mmc_of_match	NULL
 #endif
 
 static int omap_hsmmc_probe(struct platform_device *pdev)
@@ -1787,7 +1931,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, _wake_irq = 0;
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
@@ -1801,8 +1945,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 			return PTR_ERR(pdata);
 
 		if (match->data) {
-			const u16 *offsetp = match->data;
-			pdata->reg_offset = *offsetp;
+			const struct of_data *d = match->data;
+			pdata->reg_offset = d->offset;
+			pdata->controller_flags |= d->flags;
 		}
 	}
 
@@ -1821,6 +1966,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
+	if (pdev->dev.of_node)
+		_wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1842,6 +1990,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
+	host->wake_irq = _wake_irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
@@ -2018,6 +2167,18 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			"pins are not configured from the driver\n");
 
+	/*
+	 * For now, only support SDIO interrupt if we have a separate
+	 * wake-up interrupt configured from device tree. This is because
+	 * the wake-up interrupt is needed for idle state and some
+	 * platforms need special quirks. And we don't want to add new
+	 * legacy mux platform init code callbacks any longer as we
+	 * are moving to DT based booting anyways.
+	 */
+	ret = omap_hscmm_configure_wake_irq(host);
+	if (!ret)
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
@@ -2042,7 +2203,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	free_irq(mmc_slot(host).card_detect_irq, host);
+	if (host->wake_irq)
+		free_irq(host->wake_irq, host);
+	if (mmc_slot(host).card_detect_irq)
+		free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
@@ -2087,6 +2251,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
+	if (host->wake_irq)
+		free_irq(host->wake_irq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 
@@ -2149,6 +2315,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
+	hsmmc_disable_wake_irq(host);
+
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
@@ -2174,6 +2342,8 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	omap_hsmmc_protect_card(host);
 
+	hsmmc_enable_wake_irq(host);
+
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
@@ -2189,23 +2359,38 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
-	return 0;
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		hsmmc_enable_wake_irq(host);
+	}
+
+	return ret;
 }
 
 static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	int ret = 0;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-	return 0;
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		hsmmc_disable_wake_irq(host);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
+		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+	}
+	return ret;
 }
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 2bf1b30..51e70cf 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -28,6 +28,7 @@
  */
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
+#define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
 
 struct mmc_card;
 
-- 
1.7.10.4

