From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/6] mmc: tmio / sdhi: break out interrupt request/free
Date: Mon,  9 May 2011 09:55:13 +0900
Message-ID: <1304902516-14150-4-git-send-email-horms@verge.net.au>
References: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50159 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab1EIAzf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 20:55:35 -0400
In-Reply-To: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Move request_irq()/free_irq() from the shared code
in tmio_mmc.c into the SDHI/tmio specific portion
in sh_mobile_sdhi.c and tmio_mmc_pio.c.

This is ground work to allow us to adjust the SDHI
code with IRQ flags and number of interupt sources.

Based on work by Magnus Damm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
[horms@verge.net.au: edited changelog, cleaned up sob lines]
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   18 ++++++++++++++++--
 drivers/mmc/host/tmio_mmc.c       |   21 ++++++++++++++++++---
 drivers/mmc/host/tmio_mmc.h       |    2 +-
 drivers/mmc/host/tmio_mmc_pio.c   |   17 ++---------------
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f60e954..9ee51ac 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -62,7 +62,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int ret;
+	int irq, ret;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -116,11 +116,24 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eprobe;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto eirq;
+	}
+
+	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	if (ret)
+		goto eirq;
+
 	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, host->irq);
+		(unsigned long)host->ctl, irq);
 
 	return ret;
 
+eirq:
+	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
@@ -135,6 +148,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 
+	free_irq(platform_get_irq(pdev, 0), host);
 	tmio_mmc_host_remove(host);
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index be739f7..14479f9 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -64,7 +64,7 @@ static int __devinit tmio_mmc_probe(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct tmio_mmc_data *pdata;
 	struct tmio_mmc_host *host;
-	int ret = -EINVAL;
+	int ret = -EINVAL, irq;
 
 	if (pdev->num_resources != 2)
 		goto out;
@@ -73,6 +73,12 @@ static int __devinit tmio_mmc_probe(struct platform_device *pdev)
 	if (!pdata || !pdata->hclk)
 		goto out;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto out;
+	}
+
 	/* Tell the MFD core we are ready to be enabled */
 	if (cell->enable) {
 		ret = cell->enable(pdev);
@@ -84,11 +90,18 @@ static int __devinit tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto cell_disable;
 
+	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	if (ret)
+		goto host_remove;
+
 	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, host->irq);
+		(unsigned long)host->ctl, irq);
 
 	return 0;
 
+host_remove:
+	tmio_mmc_host_remove(host);
 cell_disable:
 	if (cell->disable)
 		cell->disable(pdev);
@@ -104,7 +117,9 @@ static int __devexit tmio_mmc_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	if (mmc) {
-		tmio_mmc_host_remove(mmc_priv(mmc));
+		struct tmio_mmc_host *host = mmc_priv(mmc);
+		free_irq(platform_get_irq(pdev, 0), host);
+		tmio_mmc_host_remove(host);
 		if (cell->disable)
 			cell->disable(pdev);
 	}
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 58138a2..c6bf726 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -45,7 +45,6 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
-	int                     irq;
 	unsigned int		sdio_irq_enabled;
 
 	/* Callbacks for clock / power control */
@@ -86,6 +85,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
+irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index fb1d990..6337424 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -564,7 +564,7 @@ out:
 	spin_unlock(&host->lock);
 }
 
-static irqreturn_t tmio_mmc_irq(int irq, void *devid)
+irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	struct tmio_mmc_data *pdata = host->pdata;
@@ -659,6 +659,7 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 out:
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(tmio_mmc_irq);
 
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
@@ -893,21 +894,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto pm_suspend;
-
-	_host->irq = ret;
-
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
-	ret = request_irq(_host->irq, tmio_mmc_irq, IRQF_DISABLED |
-		IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), _host);
-	if (ret)
-		goto pm_suspend;
-
 	spin_lock_init(&_host->lock);
 
 	/* Init delayed work for request timeouts */
@@ -933,8 +923,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	return 0;
 
-pm_suspend:
-	pm_runtime_suspend(&pdev->dev);
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	iounmap(_host->ctl);
@@ -952,7 +940,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	mmc_remove_host(host->mmc);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	free_irq(host->irq, host);
 	iounmap(host->ctl);
 	mmc_free_host(host->mmc);
 
-- 
1.7.4.4

