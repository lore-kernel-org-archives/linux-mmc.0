From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] mmc: sdhci-s3c: Check if clk_set_rate() succeeds
Date: Tue,  4 Nov 2014 12:26:42 +0000
Message-ID: <1415104002-1580-1-git-send-email-broonie@kernel.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37234 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaKDM2J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 07:28:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

It is possible that we may fail to set the clock rate, if we do so then
log the failure and don't bother reprogramming the IP.

Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0ce6eb17deaf..4f7a63213b33 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -300,6 +300,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct device *dev = &ourhost->pdev->dev;
 	unsigned long timeout;
 	u16 clk = 0;
+	int ret;
 
 	host->mmc->actual_clock = 0;
 
@@ -311,7 +312,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_s3c_set_clock(host, clock);
 
-	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+	ret = clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+	if (ret != 0) {
+		dev_err(dev, "%s: failed to set clock rate %uHz\n",
+			mmc_hostname(host->mmc), clock);
+		return;
+	}
 
 	clk = SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-- 
2.1.1

