From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v4 09/13] mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
Date: Tue, 26 Jan 2016 18:15:49 +0800
Message-ID: <1453803353-6266-10-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38926 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965076AbcAZKUn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 05:20:43 -0500
In-Reply-To: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-pxav3
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
2.7.0

