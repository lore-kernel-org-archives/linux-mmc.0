From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 05/21] mmc: sdhci-of-at91: consolidate parsing path
Date: Wed, 27 Jan 2016 13:06:59 +0800
Message-ID: <1453871219-3494-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-at91.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7e7d8f0..93b1530 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -194,12 +194,10 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = priv;
 
-	ret = mmc_of_parse(host->mmc);
+	ret = sdhci_get_of_property(pdev);
 	if (ret)
 		goto clocks_disable_unprepare;
 
-	sdhci_get_of_property(pdev);
-
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.3.7
