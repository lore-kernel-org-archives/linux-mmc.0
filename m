From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: sdhci-msm: fix spelling mistake: "Perpheral" -> "Peripheral"
Date: Thu, 23 Jun 2016 10:52:05 +0100
Message-ID: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51378 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcFWJwU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2016 05:52:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0653fe7..343e4bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -473,7 +473,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_host->pclk = devm_clk_get(&pdev->dev, "iface");
 	if (IS_ERR(msm_host->pclk)) {
 		ret = PTR_ERR(msm_host->pclk);
-		dev_err(&pdev->dev, "Perpheral clk setup failed (%d)\n", ret);
+		dev_err(&pdev->dev, "Peripheral clk setup failed (%d)\n", ret);
 		goto bus_clk_disable;
 	}
 
-- 
2.8.1

