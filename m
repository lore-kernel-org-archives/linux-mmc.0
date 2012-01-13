From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC/RFT 2/3] mmc: omap_hsmmc : Clean up the runtime suspend/resume
Date: Fri, 13 Jan 2012 14:13:13 +0530
Message-ID: <1326444194-13414-3-git-send-email-shubhrajyoti@ti.com>
References: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41528 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab2AMInX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Jan 2012 03:43:23 -0500
In-Reply-To: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

currently omap_hsmmc_context_restore depends on CONFIG_PM.
However the caller runtime resume has no such dependency.
This patch intends to fix the same.

omap_hsmmc_context_save is called from probe
unconditionally. However the defined under CONFIG_PM flag.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  185 +++++++++++++++++++---------------------
 1 files changed, 88 insertions(+), 97 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e6f9aea..e99487a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -673,91 +673,6 @@ static void omap_hsmmc_set_bus_mode(struct omap_hsmmc_host *host)
 }
 
 #ifdef CONFIG_PM
-
-/*
- * Restore the MMC host context, if it was lost as result of a
- * power state change.
- */
-static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
-{
-	struct mmc_ios *ios = &host->mmc->ios;
-	struct omap_mmc_platform_data *pdata = host->pdata;
-	int context_loss = 0;
-	u32 hctl, capa;
-	unsigned long timeout;
-
-	if (pdata->get_context_loss_count) {
-		context_loss = pdata->get_context_loss_count(host->dev);
-		if (context_loss < 0)
-			return 1;
-	}
-
-	dev_dbg(mmc_dev(host->mmc), "context was %slost\n",
-		context_loss == host->context_loss ? "not " : "");
-	if (host->context_loss == context_loss)
-		return 1;
-
-	/* Wait for hardware reset */
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
-		&& time_before(jiffies, timeout))
-		;
-
-	/* Do software reset */
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
-		&& time_before(jiffies, timeout))
-		;
-
-	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
-			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
-
-	if (host->id == OMAP_MMC1_DEVID) {
-		if (host->power_mode != MMC_POWER_OFF &&
-		    (1 << ios->vdd) <= MMC_VDD_23_24)
-			hctl = SDVS18;
-		else
-			hctl = SDVS30;
-		capa = VS30 | VS18;
-	} else {
-		hctl = SDVS18;
-		capa = VS18;
-	}
-
-	OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
-
-	OMAP_HSMMC_WRITE(host->base, CAPA,
-			OMAP_HSMMC_READ(host->base, CAPA) | capa);
-
-	OMAP_HSMMC_WRITE(host->base, HCTL,
-			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
-
-	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
-	while ((OMAP_HSMMC_READ(host->base, HCTL) & SDBP) != SDBP
-		&& time_before(jiffies, timeout))
-		;
-
-	omap_hsmmc_disable_irq(host);
-
-	/* Do not initialize card-specific things if the power is off */
-	if (host->power_mode == MMC_POWER_OFF)
-		goto out;
-
-	omap_hsmmc_set_bus_width(host);
-
-	omap_hsmmc_set_clock(host);
-
-	omap_hsmmc_set_bus_mode(host);
-
-out:
-	host->context_loss = context_loss;
-
-	dev_dbg(mmc_dev(host->mmc), "context is restored\n");
-	return 0;
-}
-
 /*
  * Save the MMC host context (store the number of power state changes so far).
  */
@@ -773,18 +688,6 @@ static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
 		host->context_loss = context_loss;
 	}
 }
-
-#else
-
-static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
-{
-	return 0;
-}
-
-static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
-{
-}
-
 #endif
 
 /*
@@ -1942,7 +1845,9 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+#ifdef CONFIG_PM
 	omap_hsmmc_context_save(host);
+#endif
 
 	mmc->caps |= MMC_CAP_DISABLE;
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
@@ -2249,6 +2154,91 @@ static int omap_hsmmc_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+/*
+ * Restore the MMC host context, if it was lost as result of a
+ * power state change.
+ */
+static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
+{
+	struct mmc_ios *ios = &host->mmc->ios;
+	struct omap_mmc_platform_data *pdata = host->pdata;
+	int context_loss = 0;
+	u32 hctl, capa;
+	unsigned long timeout;
+
+	if (pdata->get_context_loss_count) {
+		context_loss = pdata->get_context_loss_count(host->dev);
+		if (context_loss < 0)
+			return 1;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "context was %slost\n",
+		context_loss == host->context_loss ? "not " : "");
+	if (host->context_loss == context_loss)
+		return 1;
+
+	/* Wait for hardware reset */
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
+		&& time_before(jiffies, timeout))
+		;
+
+	/* Do software reset */
+	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
+		&& time_before(jiffies, timeout))
+		;
+
+	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
+			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
+
+	if (host->id == OMAP_MMC1_DEVID) {
+		if (host->power_mode != MMC_POWER_OFF &&
+		    (1 << ios->vdd) <= MMC_VDD_23_24)
+			hctl = SDVS18;
+		else
+			hctl = SDVS30;
+		capa = VS30 | VS18;
+	} else {
+		hctl = SDVS18;
+		capa = VS18;
+	}
+
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
+
+	OMAP_HSMMC_WRITE(host->base, CAPA,
+			OMAP_HSMMC_READ(host->base, CAPA) | capa);
+
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
+
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((OMAP_HSMMC_READ(host->base, HCTL) & SDBP) != SDBP
+		&& time_before(jiffies, timeout))
+		;
+
+	omap_hsmmc_disable_irq(host);
+
+	/* Do not initialize card-specific things if the power is off */
+	if (host->power_mode == MMC_POWER_OFF)
+		goto out;
+
+	omap_hsmmc_set_bus_width(host);
+
+	omap_hsmmc_set_clock(host);
+
+	omap_hsmmc_set_bus_mode(host);
+
+out:
+	host->context_loss = context_loss;
+
+	dev_dbg(mmc_dev(host->mmc), "context is restored\n");
+	return 0;
+}
+
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
@@ -2270,6 +2260,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
-- 
1.7.1

