From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci-xenon: implement system standby base on runtime pm
Date: Thu, 24 Aug 2017 15:19:38 -0700
Message-ID: <1503613178-26912-3-git-send-email-zjwu@marvell.com>
References: <1503613178-26912-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34390 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753423AbdHXWQc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2017 18:16:32 -0400
In-Reply-To: <1503613178-26912-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

Implement system standby based on runtime pm API.
Introduce restore_needed to restore the Xenon specific registers
when resume.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
 drivers/mmc/host/sdhci-xenon.c | 41 ++++++++++++-----------------------------
 drivers/mmc/host/sdhci-xenon.h |  1 +
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 517ff2e..d40ec46 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -555,40 +555,15 @@ static int xenon_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = sdhci_suspend_host(host);
-	if (ret)
-		return ret;
+	ret = pm_runtime_force_suspend(dev);
 
-	clk_disable_unprepare(pltfm_host->clk);
+	priv->restore_needed = true;
 	return ret;
 }
-
-static int xenon_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int ret;
-
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret)
-		return ret;
-
-	/*
-	 * If SoCs power off the entire Xenon, registers setting will
-	 * be lost.
-	 * Re-configure Xenon specific register to enable current SDHC
-	 */
-	ret = xenon_sdhc_prepare(host);
-	if (ret)
-		return ret;
-
-	return sdhci_resume_host(host);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
+#endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
 static int xenon_runtime_suspend(struct device *dev)
@@ -617,6 +592,7 @@ static int xenon_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -625,11 +601,18 @@ static int xenon_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	if (priv->restore_needed) {
+		xenon_sdhc_prepare(host);
+		priv->restore_needed = false;
+	}
+
 	return sdhci_runtime_resume_host(host);
 }
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
 			   xenon_runtime_resume,
 			   NULL)
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 01937f1..2bc0510 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -91,6 +91,7 @@ struct xenon_priv {
 	 */
 	void		*phy_params;
 	struct xenon_emmc_phy_regs *emmc_phy_regs;
+	bool restore_needed;
 };
 
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
-- 
1.9.1

