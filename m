From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 6/7] mmc: sdhci: disable the clock in sdhci_pltfm_unregister()
Date: Fri, 27 Feb 2015 15:47:30 +0800
Message-ID: <1425023251-4544-7-git-send-email-haokexin@gmail.com>
References: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:42697 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbB0HsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 02:48:17 -0500
Received: by ykq19 with SMTP id 19so6497684ykq.9
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 23:48:16 -0800 (PST)
In-Reply-To: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

So we can avoid to sprinkle the clk_disable_unprepare() in many
drivers.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 drivers/mmc/host/sdhci-bcm-kona.c  | 12 +-----------
 drivers/mmc/host/sdhci-dove.c      |  8 +-------
 drivers/mmc/host/sdhci-of-arasan.c |  1 -
 drivers/mmc/host/sdhci-pltfm.c     |  2 ++
 drivers/mmc/host/sdhci-sirf.c      |  5 +----
 drivers/mmc/host/sdhci-st.c        |  5 -----
 drivers/mmc/host/sdhci-tegra.c     | 12 +-----------
 7 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 5bc263b447b2..91cba26f75af 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -325,17 +325,7 @@ err_pltfm_free:
 
 static int sdhci_bcm_kona_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
-
-	sdhci_remove_host(host, dead);
-
-	clk_disable_unprepare(pltfm_priv->clk);
-
-	sdhci_pltfm_free(pdev);
-
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 static struct platform_driver sdhci_bcm_kona_driver = {
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index f78440ef1ba4..2314ff88d942 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -110,13 +110,7 @@ err_sdhci_add:
 
 static int sdhci_dove_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	clk_disable_unprepare(pltfm_host->clk);
-	sdhci_pltfm_unregister(pdev);
-
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 static const struct of_device_id sdhci_dove_of_match_table[] = {
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index bcb51e9dfdcd..129079fb53bf 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -195,7 +195,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
 
-	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
 	return sdhci_pltfm_unregister(pdev);
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5b01d6bb85d..74c58d9a4fc8 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -225,9 +225,11 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
 int sdhci_pltfm_unregister(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
+	clk_disable_unprepare(pltfm_host->clk);
 	sdhci_pltfm_free(pdev);
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index c30d6f3dd9aa..f7dd68e55b49 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -196,11 +196,8 @@ err_clk_prepare:
 static int sdhci_sirf_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
-	clk_disable_unprepare(pltfm_host->clk);
-	sdhci_pltfm_unregister(pdev);
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 882b07e9667e..0019df452522 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -115,11 +115,6 @@ err_of:
 
 static int sdhci_st_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	clk_disable_unprepare(pltfm_host->clk);
-
 	return sdhci_pltfm_unregister(pdev);
 }
 
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0643f66b4e14..12881e05ff30 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -323,17 +323,7 @@ err_alloc_tegra_host:
 
 static int sdhci_tegra_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
-
-	sdhci_remove_host(host, dead);
-
-	clk_disable_unprepare(pltfm_host->clk);
-
-	sdhci_pltfm_free(pdev);
-
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 static struct platform_driver sdhci_tegra_driver = {
-- 
1.9.3

