From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 08/12] mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
Date: Wed, 6 Jan 2016 18:31:39 +0800
Message-ID: <1452076303-1960-9-git-send-email-jszhang@marvell.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452076303-1960-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-pxav3
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d..c88d2ba 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -132,7 +132,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 	struct resource *res;
 
 	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
@@ -201,7 +201,7 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 	u16 tmp;
 	int count;
 
@@ -250,7 +250,7 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2;
 
 	/*
@@ -370,16 +370,12 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	int ret;
 
-	pxa = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_pxa), GFP_KERNEL);
-	if (!pxa)
-		return -ENOMEM;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, sizeof(*pxa));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = pxa;
+	pxa = sdhci_pltfm_priv(pltfm_host);
 
 	pxa->clk_io = devm_clk_get(dev, "io");
 	if (IS_ERR(pxa->clk_io))
@@ -486,7 +482,7 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -535,7 +531,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_runtime_suspend_host(host);
@@ -553,7 +549,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 
 	clk_prepare_enable(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
-- 
2.7.0.rc3
