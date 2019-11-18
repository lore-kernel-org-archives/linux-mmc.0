From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH v7 4/4] mmc: host: sdhci-sprd: Add software queue support
Date: Mon, 18 Nov 2019 18:43:22 +0800
Message-ID: <2f194a08e69e922bb706528cde409b739cda0151.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, baolin.wang7@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index efa4019..54b86f6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -632,6 +632,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_HSQ
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..d346223 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
+		return;
+
+	 mmc_request_done(host->mmc, mrq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -392,6 +403,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
+	.request_done = sdhci_sprd_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -521,6 +533,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct mmc_hsq *hsq;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,18 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = mmc_hsq_init(hsq, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
+	host->always_defer_done = true;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +714,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_hsq_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +743,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	mmc_hsq_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5
