From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 06/12] mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
Date: Wed, 6 Jan 2016 11:55:59 +0800
Message-ID: <1452052565-4232-7-git-send-email-jszhang@marvell.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
sdhci-of-at91 driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-of-at91.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 06d0b50..765eb09 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -68,11 +68,13 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return -EINVAL;
 	soc_data = match->data;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "unable to allocate private data\n");
-		return -ENOMEM;
-	}
+	host = sdhci_pltfm_init(pdev, soc_data,
+				sizeof(*priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 
 	priv->mainck = devm_clk_get(&pdev->dev, "baseclk");
 	if (IS_ERR(priv->mainck)) {
@@ -92,10 +94,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->gck);
 	}
 
-	host = sdhci_pltfm_init(pdev, soc_data, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
-
 	/*
 	 * The mult clock is provided by as a generated clock by the PMC
 	 * controller. In order to set the rate of gck, we have to get the
@@ -135,9 +133,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	clk_prepare_enable(priv->mainck);
 	clk_prepare_enable(priv->gck);
 
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = priv;
-
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto clocks_disable_unprepare;
@@ -163,7 +158,7 @@ static int sdhci_at91_remove(struct platform_device *pdev)
 {
 	struct sdhci_host	*host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
-	struct sdhci_at91_priv	*priv = pltfm_host->priv;
+	struct sdhci_at91_priv	*priv = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_pltfm_unregister(pdev);
 
-- 
2.7.0.rc3
