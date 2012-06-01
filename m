From: Prashant Gaikwad <pgaikwad@nvidia.com>
Subject: [PATCH 3/9] mmc: tegra: add clk_prepare/clk_unprepare
Date: Fri, 1 Jun 2012 14:42:42 +0530
Message-ID: <1338541968-7961-4-git-send-email-pgaikwad@nvidia.com>
References: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, olof@lixom.net, Prashant Gaikwad <pgaikwad@nvidia.com>, paul.gortmaker@windriver.com, shawn.guo@linaro.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

This patch should go through Tegra tree since other patches to port tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index b38d8a7..2789656 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -334,7 +334,7 @@ static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
 		rc = PTR_ERR(clk);
 		goto err_clk_get;
 	}
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
 	host->mmc->pm_caps = plat->pm_flags;
@@ -349,7 +349,7 @@ static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_host:
-	clk_disable(pltfm_host->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
 	if (gpio_is_valid(plat->wp_gpio))
@@ -390,7 +390,7 @@ static int __devexit sdhci_tegra_remove(struct platform_device *pdev)
 	if (gpio_is_valid(plat->power_gpio))
 		gpio_free(plat->power_gpio);
 
-	clk_disable(pltfm_host->clk);
+	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-- 
1.7.4.1
