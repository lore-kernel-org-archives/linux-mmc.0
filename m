From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Thu, 27 Feb 2014 13:33:36 -0800
Message-ID: <20140227213335.GJ11654@atomide.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
 <1393331866-28307-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750999AbaB0Vdx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 16:33:53 -0500
Content-Disposition: inline
In-Reply-To: <1393331866-28307-2-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [140225 04:46]:
> For now, only support SDIO interrupt if we are booted with
> DT. This is because some platforms need special quirks. And
> we don't want to add new legacy mux platform init code
> callbacks any longer as we are moving to DT based booting
> anyways.

Thanks for updating this, I finally got around to spend some
time with it again. I've folded in your fixes and quirk support
into my earlier patch from [0] as that had a better changelog
describing the earlier work.

And I've also now made the SDIO support to depend on properly
configured wake-up irq from device tree as otherwise wake from
idle states won't work properly. I've also cleaned up the the
wake-up irq initialization a bit.

The wake-irq is needed for omaps with wake-up path and also
when doing GPIO remuxing. So the wake-up handling is pretty
much the same for both cases.

I've kept your Signed-off-by, can you please check if the patch
below works for you with the second patch I'll post shortly?

Regards,

Tony

[0] https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg22290.html

8< ----------------------------------------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 25 Feb 2014 13:37:43 +0100
Subject: [PATCH] mmc: omap_hsmmc: Enable SDIO interrupt

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
index dbd32ad..e945060 100644
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
@@ -104,6 +106,7 @@
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -178,6 +181,7 @@ struct omap_hsmmc_host {
 	u32			sysctl;
 	u32			capa;
 	int			irq;
+	int			wake_irq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -188,6 +192,9 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	int                     flags;
+#define HSMMC_SDIO_IRQ_ENABLED	(1 << 0)        /* SDIO irq enabled */
+#define HSMMC_SWAKEUP_QUIRK	(1 << 1)
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -468,27 +475,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
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
@@ -1051,8 +1071,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
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
@@ -1061,6 +1085,39 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
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
+	disable_irq_nosync(host->wake_irq);
+	spin_unlock_irqrestore(&host->irq_lock, flags);
+}
+
+static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+
+	pm_request_resume(host->dev); /* no use counter */
+
+	return IRQ_HANDLED;
+}
+
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1564,6 +1621,66 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
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
@@ -1616,7 +1733,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1678,7 +1795,18 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 #endif
 
 #ifdef CONFIG_OF
-static u16 omap4_reg_offset = 0x100;
+struct of_data {
+	u16 offset;
+	int flags;
+};
+
+static struct of_data omap4_data = {
+	.offset	= 0x100,
+};
+static struct of_data am33xx_data = {
+	.offset	= 0x100,
+	.flags	= OMAP_HSMMC_SWAKEUP_MISSING,
+};
 
 static const struct of_device_id omap_mmc_of_match[] = {
 	{
@@ -1689,7 +1817,11 @@ static const struct of_device_id omap_mmc_of_match[] = {
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
@@ -1754,7 +1886,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, _wake_irq = 0;
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
@@ -1768,8 +1900,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 			return PTR_ERR(pdata);
 
 		if (match->data) {
-			const u16 *offsetp = match->data;
-			pdata->reg_offset = *offsetp;
+			const struct of_data *d = match->data;
+			pdata->reg_offset = d->offset;
+			pdata->controller_flags |= d->flags;
 		}
 	}
 
@@ -1788,6 +1921,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
+	if (pdev->dev.of_node)
+		_wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1809,6 +1945,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
+	host->wake_irq = _wake_irq;
 	host->slot_id	= 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
@@ -1975,6 +2112,18 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			"pins are not configured from the driver\n");
 
+	/*
+	 * For now, only support SDIO interrupt if we have a separate
+	 * wake-up interrupt configured from device tree. This is because
+	 * the wake-up interrupt is needed for idle state and some
+	 * platforms need special quirks. And we don't want to add new
+	 * legacy mux platform init code callbacks any longer as we
+	 * are moving to DT based bootinganyways.
+	 */
+	ret = omap_hscmm_configure_wake_irq(host);
+	if (!ret)
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
@@ -1999,7 +2148,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
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
@@ -2044,6 +2196,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
+	if (host->wake_irq)
+		free_irq(host->wake_irq, host);
 	if (mmc_slot(host).card_detect_irq)
 		free_irq(mmc_slot(host).card_detect_irq, host);
 
@@ -2106,6 +2260,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
+	hsmmc_disable_wake_irq(host);
+
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
@@ -2131,6 +2287,8 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	omap_hsmmc_protect_card(host);
 
+	hsmmc_enable_wake_irq(host);
+
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
@@ -2146,23 +2304,38 @@ static int omap_hsmmc_resume(struct device *dev)
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
 
