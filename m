From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 07/13] mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
Date: Tue, 26 Jan 2016 18:15:47 +0800
Message-ID: <1453803353-6266-8-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453803353-6266-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
sdhci-of-at91 driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-of-at91.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7e7d8f0..7db7163 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -58,7 +58,7 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_at91_priv *priv = pltfm_host->priv;
+	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_runtime_suspend_host(host);
@@ -74,7 +74,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_at91_priv *priv = pltfm_host->priv;
+	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = clk_prepare_enable(priv->mainck);
@@ -124,11 +124,12 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return -EINVAL;
 	soc_data = match->data;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "unable to allocate private data\n");
-		return -ENOMEM;
-	}
+	host = sdhci_pltfm_init(pdev, soc_data, sizeof(*priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 
 	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
 	if (IS_ERR(priv->mainck)) {
@@ -148,10 +149,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->gck);
 	}
 
-	host = sdhci_pltfm_init(pdev, soc_data, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
-
 	/*
 	 * The mult clock is provided by as a generated clock by the PMC
 	 * controller. In order to set the rate of gck, we have to get the
@@ -191,9 +188,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	clk_prepare_enable(priv->mainck);
 	clk_prepare_enable(priv->gck);
 
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = priv;
-
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto clocks_disable_unprepare;
@@ -230,7 +224,10 @@ static int sdhci_at91_remove(struct platform_device *pdev)
 {
 	struct sdhci_host	*host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
-	struct sdhci_at91_priv	*priv = pltfm_host->priv;
+	struct sdhci_at91_priv	*priv = sdhci_pltfm_priv(pltfm_host);
+	struct clk *gck = priv->gck;
+	struct clk *hclock = priv->hclock;
+	struct clk *mainck = priv->mainck;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -238,9 +235,9 @@ static int sdhci_at91_remove(struct platform_device *pdev)
 
 	sdhci_pltfm_unregister(pdev);
 
-	clk_disable_unprepare(priv->gck);
-	clk_disable_unprepare(priv->hclock);
-	clk_disable_unprepare(priv->mainck);
+	clk_disable_unprepare(gck);
+	clk_disable_unprepare(hclock);
+	clk_disable_unprepare(mainck);
 
 	return 0;
 }
-- 
2.7.0
