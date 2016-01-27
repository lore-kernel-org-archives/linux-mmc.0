From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 04/21] mmc: sdhci-of-arasan: consolidate parsing path
Date: Wed, 27 Jan 2016 13:06:50 +0800
Message-ID: <1453871210-3453-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com
List-Id: linux-mmc@vger.kernel.org

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: soren.brinkmann@xilinx.com
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..b653ec7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -177,17 +177,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 	}
 
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		goto clk_disable_all;
+
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
 
-	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
-		goto clk_disable_all;
-	}
-
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_pltfm_free;
-- 
2.3.7
