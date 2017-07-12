From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific system-level PM support
Date: Wed, 12 Jul 2017 15:16:19 -0700
Message-ID: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54229 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750705AbdGLWOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jul 2017 18:14:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zjwu@marvell.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

From: Hu Ziji <huziji@marvell.com>

Add Xenon specific system-level suspend and resume support.
Especially during resume, re-configure Xenon specific registers
since registers setting will be lost in suspend if Xenon is power off.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Tested-by: Jisheng Zhang <jszhang@marvell.com>
---
Hu Ziji has left marvell, submit the patch for him.
I will submit a patch to change xenon driver maintainer information and take over the ownership.
v2:
 Add Signed-off-by Hu Ziji <huziji@marvell.com>.
v3:
 Since Hu Ziji wrote the patch, correct the author information.
 drivers/mmc/host/sdhci-xenon.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bc1781b..9f399c4 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -519,6 +519,46 @@ static int xenon_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int xenon_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+	return ret;
+}
+
+static int xenon_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * If SoCs power off the entire Xenon, registers setting will
+	 * be lost.
+	 * Re-configure Xenon specific register to enable current SDHC
+	 */
+	ret = xenon_sdhc_prepare(host);
+	if (ret)
+		return ret;
+
+	return sdhci_resume_host(host);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
+
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap806-sdhci",},
 	{ .compatible = "marvell,armada-cp110-sdhci",},
@@ -531,7 +571,7 @@ static int xenon_remove(struct platform_device *pdev)
 	.driver	= {
 		.name	= "xenon-sdhci",
 		.of_match_table = sdhci_xenon_dt_ids,
-		.pm = &sdhci_pltfm_pmops,
+		.pm = &xenon_pmops,
 	},
 	.probe	= xenon_probe,
 	.remove	= xenon_remove,
-- 
1.9.1

