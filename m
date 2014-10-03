From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 08/12] mmc: sdhci-pxav3: Get optional core clock
Date: Fri,  3 Oct 2014 17:55:43 +0200
Message-ID: <1412351747-4188-9-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412351747-4188-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412351747-4188-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Besides the I/O clock, some PXAv3 SDHCI IP also requires a core clock to
be enabled. Add an optional core clock to the corresponding driver.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mmc/host/sdhci-pxav3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3dfd97977515..ad0badad0ebc 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -59,6 +59,7 @@
 #define SDCE_MISC_INT_EN	(1<<1)
 
 struct sdhci_pxa {
+	struct clk *clk_core;
 	struct clk *clk_io;
 	u8	power_mode;
 };
@@ -320,6 +321,10 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host->clk = pxa->clk_io;
 	clk_prepare_enable(pxa->clk_io);
 
+	pxa->clk_core = devm_clk_get(dev, "core");
+	if (!IS_ERR(pxa->clk_core))
+		clk_prepare_enable(pxa->clk_core);
+
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
@@ -392,6 +397,8 @@ err_add_host:
 err_of_parse:
 err_cd_req:
 	clk_disable_unprepare(pxa->clk_io);
+	if (!IS_ERR(pxa->clk_core))
+		clk_disable_unprepare(pxa->clk_core);
 err_clk_get:
 err_mbus_win:
 	sdhci_pltfm_free(pdev);
@@ -409,6 +416,8 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(pxa->clk_io);
+	if (!IS_ERR(pxa->clk_core))
+		clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
 
@@ -456,6 +465,8 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	clk_disable_unprepare(pxa->clk_io);
+	if (!IS_ERR(pxa->clk_core))
+		clk_disable_unprepare(pxa->clk_core);
 
 	return 0;
 }
@@ -468,6 +479,8 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	unsigned long flags;
 
 	clk_prepare_enable(pxa->clk_io);
+	if (!IS_ERR(pxa->clk_core))
+		clk_prepare_enable(pxa->clk_core);
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = false;
-- 
2.1.1
