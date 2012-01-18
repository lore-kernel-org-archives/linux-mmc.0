From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc: use PM QoS instead of delayed clock gating
 for PM
Date: Wed, 18 Jan 2012 20:06:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201182004090.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62298 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab2ARTGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 14:06:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

Using delayed clock gating to prevent too frequent gating of the clock
is simple and efficient, but too inflexible. We use PM QoS instead to
let the runtime PM subsystem decide, which power states can be entered
at any specific time, depending on the currently active governor.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    2 ++
 drivers/mmc/host/tmio_mmc_pio.c |   21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b4519bf..8afaf4f 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -20,6 +20,7 @@
 #include <linux/mmc/tmio.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/pm_qos.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 
@@ -50,6 +51,7 @@ struct tmio_mmc_host {
 
 	/* Controller power state */
 	bool			power;
+	struct dev_pm_qos_request pm_qos;
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0e72f1a..576baf5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -853,11 +854,27 @@ static int tmio_mmc_get_cd(struct mmc_host *mmc)
 		return pdata->get_cd(host->pdev);
 }
 
+static int tmio_mmc_enable(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	dev_pm_qos_add_request(mmc->parent, &host->pm_qos, 100);
+	return 0;
+}
+
+static int tmio_mmc_disable(struct mmc_host *mmc, int lazy)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	dev_pm_qos_remove_request(&host->pm_qos);
+	return 0;
+}
+
 static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= tmio_mmc_get_cd,
+	.enable		= tmio_mmc_enable,
+	.disable	= tmio_mmc_disable,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
@@ -879,6 +896,8 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
+	/* disable delayed clock gating, we use PM QoS for precise PM */
+	mmc->clkgate_delay = 0;
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
 	_host->pdata = pdata;
@@ -899,7 +918,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	}
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_DISABLE | pdata->capabilities;
 	if (pdata->get_clk_rate)
 		mmc->f_max = pdata->get_clk_rate(pdev);
 	else
-- 
1.7.2.5

