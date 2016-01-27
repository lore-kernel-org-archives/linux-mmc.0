From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 03/21] mmc: sdhci-msm: consolidate parsing path
Date: Wed, 27 Jan 2016 13:04:52 +0800
Message-ID: <1453871092-3112-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Georgi Djakov <georgi.djakov@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-msm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4695bee..dfc6016 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -451,12 +451,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_host->mmc = host->mmc;
 	msm_host->pdev = pdev;
 
-	ret = mmc_of_parse(host->mmc);
+	ret = sdhci_get_of_property(pdev);
 	if (ret)
 		goto pltfm_free;
 
-	sdhci_get_of_property(pdev);
-
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
2.3.7
