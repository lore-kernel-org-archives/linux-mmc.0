From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] mmc: sdhci-s3c: Check if clk_set_rate() succeeds
Date: Thu, 12 Dec 2013 11:21:06 +0000
Message-ID: <1386847266-2131-1-git-send-email-broonie@kernel.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33561 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3LLLVc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2013 06:21:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

It is possible that we may fail to set the clock rate, if we do so then
log the failure and don't bother reprogramming the IP.

Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda952155..5c20f827d828 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -295,6 +295,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct device *dev = &ourhost->pdev->dev;
 	unsigned long timeout;
 	u16 clk = 0;
+	int ret;
 
 	/* If the clock is going off, set to 0 at clock control register */
 	if (clock == 0) {
@@ -305,7 +306,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_s3c_set_clock(host, clock);
 
-	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+	ret = clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+	if (ret != 0) {
+		dev_err(dev, "%s: failed to set clock rate %uHz\n",
+			mmc_hostname(host->mmc), clock);
+		return;
+	}
 
 	host->clock = clock;
 
-- 
1.8.5.1

