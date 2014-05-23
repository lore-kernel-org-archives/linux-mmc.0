From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v13 2/7] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Fri, 23 May 2014 10:30:29 +0200
Message-ID: <1400833834-15893-3-git-send-email-afenkart@gmail.com>
References: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:53191 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaEWIbW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 04:31:22 -0400
In-Reply-To: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

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

Acked-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index ce80561..0233ba7 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -12,6 +12,7 @@ Required properties:
  Should be "ti,omap3-hsmmc", for OMAP3 controllers
  Should be "ti,omap3-pre-es3-hsmmc" for OMAP3 controllers pre ES3.0
  Should be "ti,omap4-hsmmc", for OMAP4 controllers
+ Should be "ti,am33xx-hsmmc", for AM335x controllers
 - ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
 
 Optional properties:
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c62d9dd..0125eea 100644
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
@@ -106,6 +108,7 @@
 #define TC_EN			(1 << 1)
 #define BWR_EN			(1 << 4)
 #define BRR_EN			(1 << 5)
+#define CIRQ_EN			(1 << 8)
 #define ERR_EN			(1 << 15)
 #define CTO_EN			(1 << 16)
 #define CCRC_EN			(1 << 17)
@@ -140,7 +143,6 @@
 #define VDD_3V0			3000000		/* 300000 uV */
 #define VDD_165_195		(ffs(MMC_VDD_165_195) - 1)
 
-#define AUTO_CMD23		(1 << 1)	/* Auto CMD23 support */
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -200,6 +202,7 @@ struct omap_hsmmc_host {
 	int			slot_id;
 	int			response_busy;
 #ifdef CONFIG_PM
+	int			wake_irq;
 	int			context_loss;
 #endif
 	int			protect_card;
@@ -208,6 +211,9 @@ struct omap_hsmmc_host {
 	int			req_in_progress;
 	unsigned long		clk_rate;
 	unsigned int		flags;
+#define AUTO_CMD23		(1 << 0)        /* Auto CMD23 support */
+#define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
+#define HSMMC_WAKE_IRQ_ENABLED	(1 << 2)
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -512,27 +518,40 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
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
@@ -683,7 +702,9 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		;
 
-	omap_hsmmc_disable_irq(host);
+	OMAP_HSMMC_WRITE(host->base, ISE, 0);
+	OMAP_HSMMC_WRITE(host->base, IE, 0);
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 
 	/* Do not initialize card-specific things if the power is off */
 	if (host->power_mode == MMC_POWER_OFF)
@@ -1113,8 +1134,12 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
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
@@ -1123,6 +1148,24 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_PM
+static irqreturn_t omap_hsmmc_wake_irq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+
+	/* cirq is level triggered, disable to avoid infinite loop */
+	spin_lock(&host->irq_lock);
+	if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
+		disable_irq_nosync(host->wake_irq);
+		host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
+	}
+	spin_unlock(&host->irq_lock);
+	pm_request_resume(host->dev); /* no use counter */
+
+	return IRQ_HANDLED;
+}
+#endif
+
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1634,6 +1677,84 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
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
+#ifdef CONFIG_PM
+static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	/*
+	 * For omaps with wake-up path, wakeirq will be irq from pinctrl and
+	 * for other omaps, wakeirq will be from GPIO (dat line remuxed to
+	 * gpio). wakeirq is needed to detect sdio irq in runtime suspend state
+	 * with functional clock disabled.
+	 */
+	if (!host->dev->of_node || !host->wake_irq)
+		return -ENODEV;
+
+	/* Prevent auto-enabling of IRQ */
+	irq_set_status_flags(host->wake_irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(host->dev, host->wake_irq, omap_hsmmc_wake_irq,
+			       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			       mmc_hostname(mmc), host);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "Unable to request wake IRQ\n");
+		goto err;
+	}
+
+	/*
+	 * Some omaps don't have wake-up path from deeper idle states
+	 * and need to remux SDIO DAT1 to GPIO for wake-up from idle.
+	 */
+	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
+		ret = -ENODEV;
+		devm_free_irq(host->dev, host->wake_irq, host);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(host->dev, "no SDIO IRQ support, falling back to polling\n");
+	host->wake_irq = 0;
+	return ret;
+}
+#else
+/* without suspend no wakeup needed */
+#define omap_hsmmc_configure_wake_irq(x)  (0)
+#endif
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
 	u32 hctl, capa, value;
@@ -1686,7 +1807,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
 	.init_card = omap_hsmmc_init_card,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1759,6 +1880,10 @@ static const struct omap_mmc_of_data omap3_pre_es3_mmc_of_data = {
 static const struct omap_mmc_of_data omap4_mmc_of_data = {
 	.reg_offset = 0x100,
 };
+static const struct omap_mmc_of_data am33xx_mmc_of_data = {
+	.reg_offset = 0x100,
+	.controller_flags = OMAP_HSMMC_SWAKEUP_MISSING,
+};
 
 static const struct of_device_id omap_mmc_of_match[] = {
 	{
@@ -1775,6 +1900,10 @@ static const struct of_device_id omap_mmc_of_match[] = {
 		.compatible = "ti,omap4-hsmmc",
 		.data = &omap4_mmc_of_data,
 	},
+	{
+		.compatible = "ti,am33xx-hsmmc",
+		.data = &am33xx_mmc_of_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
@@ -1910,6 +2039,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+#ifdef CONFIG_PM
+	if (pdev->dev.of_node)
+		host->wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+#endif
+
 	mmc->ops	= &omap_hsmmc_ops;
 
 	mmc->f_min = OMAP_MMC_MIN_CLOCK;
@@ -2074,6 +2208,18 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
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
+	ret = omap_hsmmc_configure_wake_irq(host);
+	if (!ret)
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
@@ -2200,11 +2346,18 @@ static int omap_hsmmc_suspend(struct device *dev)
 	pm_runtime_get_sync(host->dev);
 
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
-		omap_hsmmc_disable_irq(host);
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		OMAP_HSMMC_WRITE(host->base, HCTL,
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 	}
 
+	/* do not wake up due to sdio irq */
+	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
+	    !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
+		disable_irq(host->wake_irq);
+
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
@@ -2230,6 +2383,10 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	omap_hsmmc_protect_card(host);
 
+	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
+	    !(host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ))
+		enable_irq(host->wake_irq);
+
 	pm_runtime_mark_last_busy(host->dev);
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
@@ -2246,22 +2403,51 @@ static int omap_hsmmc_resume(struct device *dev)
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	unsigned long flags;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
+	spin_lock_irqsave(&host->irq_lock, flags);
+	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
+	    (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
+		/* disable sdio irq handling to prevent race */
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+
+		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
+		enable_irq(host->wake_irq);
+		host->flags |= HSMMC_WAKE_IRQ_ENABLED;
+	}
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return 0;
 }
 
 static int omap_hsmmc_runtime_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
+	unsigned long flags;
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
+	spin_lock_irqsave(&host->irq_lock, flags);
+	if ((host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
+	    (host->flags & HSMMC_SDIO_IRQ_ENABLED)) {
+		/* sdio irq flag can't change while in runtime suspend */
+		if (host->flags & HSMMC_WAKE_IRQ_ENABLED) {
+			disable_irq_nosync(host->wake_irq);
+			host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
+		}
+
+		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
+		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+	}
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return 0;
 }
 #else
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

