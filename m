From: Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH] mmc: mxs-mmc: Introducing regulator support.
Date: Tue, 17 Jun 2014 12:07:11 +0200
Message-ID: <1402999631-4256-1-git-send-email-robin@protonic.nl>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17437 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbaFQK0G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jun 2014 06:26:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, Robin van der Gracht <robin@protonic.nl>

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/mmc/host/mxs-mmc.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 073e871..efe8ae1 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -66,10 +66,12 @@ struct mxs_mmc_host {
 	struct mmc_request		*mrq;
 	struct mmc_command		*cmd;
 	struct mmc_data			*data;
+	struct regulator                *vmmc;
 
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
+	unsigned char                   power_mode;
 };
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -502,6 +504,30 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (host->vmmc) {
+				if (regulator_disable(host->vmmc)) {
+					dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+				}
+			}
+			break;
+		case MMC_POWER_UP:
+			if (host->vmmc) {
+				if (regulator_enable(host->vmmc)) {
+					dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+				}
+			}
+			break;
+		default:
+			break;
+		}
+		host->power_mode = ios->power_mode;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -597,16 +623,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
+	host->power_mode = MMC_POWER_OFF;
 
 	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
-	}
+	if (!IS_ERR(reg_vmmc))
+		host->vmmc = reg_vmmc;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
1.9.1

