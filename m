From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] mmc: sdhci-s3c: Check if clk_set_rate() succeeds
Date: Thu, 29 Aug 2013 17:15:36 +0100
Message-ID: <1377792936-775-1-git-send-email-broonie@kernel.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:45730 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab3H2QPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2013 12:15:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

It is possible that we may fail to set the clock rate, if we do so then
log the failure and don't bother reprogramming the IP.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 926aaf6..d10de3f 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -295,6 +295,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct device *dev = &ourhost->pdev->dev;
 	unsigned long timeout;
 	u16 clk = 0;
+	int ret;
 
 	/* don't bother if the clock is going off */
 	if (clock == 0)
@@ -302,7 +303,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 
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
1.8.4.rc3

