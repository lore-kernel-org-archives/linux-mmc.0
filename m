From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v5 07/13] mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
Date: Tue, 16 Feb 2016 21:08:25 +0800
Message-ID: <1455628111-5583-8-git-send-email-jszhang@marvell.com>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, kernel@stlinux.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
sdhci-of-at91 driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 9cb86fb..35c02fc 100644
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
@@ -231,7 +225,10 @@ static int sdhci_at91_remove(struct platform_device *pdev)
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
@@ -239,9 +236,9 @@ static int sdhci_at91_remove(struct platform_device *pdev)
 
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
