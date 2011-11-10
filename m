From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-esdhc-imx: convert to clk_prepare/clk_unprepare
Date: Thu, 10 Nov 2011 13:06:29 +0800
Message-ID: <1320901589-13262-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:14568
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934093Ab1KJFGt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 00:06:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, w.sang@pengutronix.de, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ae57769..b37e5d4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -462,6 +462,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		err = PTR_ERR(clk);
 		goto err_clk_get;
 	}
+	clk_prepare(clk);
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
@@ -551,6 +552,7 @@ no_card_detect_irq:
 no_card_detect_pin:
 no_board_data:
 	clk_disable(pltfm_host->clk);
+	clk_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 err_clk_get:
 	kfree(imx_data);
@@ -578,6 +580,7 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	}
 
 	clk_disable(pltfm_host->clk);
+	clk_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 	kfree(imx_data);
 
-- 
1.7.5.4


