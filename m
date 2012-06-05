From: Prashant Gaikwad <pgaikwad@nvidia.com>
Subject: [PATCH v2 3/9] mmc: tegra: add clk_prepare/clk_unprepare
Date: Tue, 5 Jun 2012 09:49:20 +0530
Message-ID: <1338869966-8430-4-git-send-email-pgaikwad@nvidia.com>
References: <1338869966-8430-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:9288 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2FEETC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jun 2012 00:19:02 -0400
In-Reply-To: <1338869966-8430-1-git-send-email-pgaikwad@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: pgaikwad@nvidia.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
This patch should go through Tegra tree since other patches to port tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

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

