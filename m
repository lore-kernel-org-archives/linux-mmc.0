From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] mmc: sh_mmcif: simplify and use meaningful label names
 in error-handling
Date: Fri, 20 Apr 2012 00:09:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204192356380.2110@axis700.grange>
References: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
 <Pine.LNX.4.64.1202022256580.13860@axis700.grange>
 <CANqRtoQ7o=_9uRa3F=4pkNvDWS2g2wZU6oBipttfGuFv4irpzA@mail.gmail.com>
 <Pine.LNX.4.64.1202031156020.6211@axis700.grange>
 <Pine.LNX.4.64.1204191215430.2110@axis700.grange>
 <CANqRtoTq1e7_g82FGZS3S8yb0j7MgCYNhiH7E=a+nHkTWiOgLQ@mail.gmail.com>
 <Pine.LNX.4.64.1204192351190.2110@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204192351190.2110@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

A check for NULL platform data can be conveniently made in the very
beginning of probing. Replace numbered error-handling labels in .probe()
with meaningful names to make any future reorganisation simpler.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bba9742..f8ac0bd 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1247,10 +1247,15 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
 	struct sh_mmcif_host *host;
-	struct sh_mmcif_plat_data *pd;
+	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
 	struct resource *res;
 	void __iomem *reg;
 
+	if (!pd) {
+		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
+		return -ENXIO;
+	}
+
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[0] < 0 || irq[1] < 0) {
@@ -1267,16 +1272,11 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ioremap error.\n");
 		return -ENOMEM;
 	}
-	pd = pdev->dev.platform_data;
-	if (!pd) {
-		dev_err(&pdev->dev, "sh_mmcif plat data error.\n");
-		ret = -ENXIO;
-		goto clean_up;
-	}
+
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
-		goto clean_up;
+		goto ealloch;
 	}
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1287,7 +1287,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	if (IS_ERR(host->hclk)) {
 		ret = PTR_ERR(host->hclk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
-		goto clean_up1;
+		goto eclkget;
 	}
 	clk_enable(host->hclk);
 	host->clk = clk_get_rate(host->hclk);
@@ -1317,7 +1317,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-		goto clean_up2;
+		goto eresume;
 
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
@@ -1326,17 +1326,17 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:error", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
-		goto clean_up3;
+		goto ereqirq0;
 	}
 	ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:int", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-		goto clean_up4;
+		goto ereqirq1;
 	}
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto clean_up5;
+		goto emmcaddh;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
@@ -1345,20 +1345,19 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
-clean_up5:
+emmcaddh:
 	free_irq(irq[1], host);
-clean_up4:
+ereqirq1:
 	free_irq(irq[0], host);
-clean_up3:
+ereqirq0:
 	pm_runtime_suspend(&pdev->dev);
-clean_up2:
+eresume:
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(host->hclk);
-clean_up1:
+eclkget:
 	mmc_free_host(mmc);
-clean_up:
-	if (reg)
-		iounmap(reg);
+ealloch:
+	iounmap(reg);
 	return ret;
 }
 
-- 
1.7.2.5

