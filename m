From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:01 +0530
Message-ID: <1340372890-10091-3-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
probe() and remove() routines.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Balaji T K <balajitk@ti.com>
Cc: <linux-mmc@vger.kernel.org>
---
 drivers/mmc/host/omap.c       |    9 ++++++---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 552196c..331fa89 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1466,13 +1466,14 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		ret = PTR_ERR(host->iclk);
 		goto err_free_mmc_host;
 	}
-	clk_enable(host->iclk);
+	clk_prepare_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
 		goto err_free_iclk;
 	}
+	clk_prepare(host->fclk);
 
 	ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
 	if (ret)
@@ -1509,9 +1510,10 @@ err_plat_cleanup:
 err_free_irq:
 	free_irq(host->irq, host);
 err_free_fclk:
+	clk_unprepare(host->fclk);
 	clk_put(host->fclk);
 err_free_iclk:
-	clk_disable(host->iclk);
+	clk_disable_unprepare(host->iclk);
 	clk_put(host->iclk);
 err_free_mmc_host:
 	iounmap(host->virt_base);
@@ -1539,8 +1541,9 @@ static int __devexit mmc_omap_remove(struct platform_device *pdev)
 
 	mmc_omap_fclk_enable(host, 0);
 	free_irq(host->irq, host);
+	clk_unprepare(host->fclk);
 	clk_put(host->fclk);
-	clk_disable(host->iclk);
+	clk_disable_unprepare(host->iclk);
 	clk_put(host->iclk);
 
 	iounmap(host->virt_base);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9a7a60a..154baa5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1908,7 +1908,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(host->dbclk)) {
 		dev_warn(mmc_dev(host->mmc), "Failed to get debounce clk\n");
 		host->dbclk = NULL;
-	} else if (clk_enable(host->dbclk) != 0) {
+	} else if (clk_prepare_enable(host->dbclk) != 0) {
 		dev_warn(mmc_dev(host->mmc), "Failed to enable debounce clk\n");
 		clk_put(host->dbclk);
 		host->dbclk = NULL;
@@ -2032,7 +2032,7 @@ err_irq:
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->dbclk) {
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 		clk_put(host->dbclk);
 	}
 err1:
@@ -2067,7 +2067,7 @@ static int __devexit omap_hsmmc_remove(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->dbclk) {
-		clk_disable(host->dbclk);
+		clk_disable_unprepare(host->dbclk);
 		clk_put(host->dbclk);
 	}
 
-- 
1.7.1

