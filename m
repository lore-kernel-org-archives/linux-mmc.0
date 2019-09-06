From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] mmc: host: sdhci-sprd: Add virtual command queue support
Date: Fri,  6 Sep 2019 11:52:01 +0800
Message-ID: <c8cb69b48dd8b6317a9e53e87c5669fbfbeedc30.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add virtual command queue support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e2a12c3..851e947 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_VIRTUAL_CQHCI
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 19a2104..ff4886a3 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -515,6 +516,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct cqhci_host *cqv_host;
 	struct clk *clk;
 	int ret = 0;
 
@@ -625,6 +627,17 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	cqv_host = devm_kzalloc(&pdev->dev,
+				sizeof(*cqv_host), GFP_KERNEL);
+	if (!cqv_host) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = cqhci_virt_init(cqv_host, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -685,6 +698,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	cqhci_virt_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -713,6 +727,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	cqhci_virt_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5
