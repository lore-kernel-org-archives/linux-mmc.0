From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 6/7] mmc: sh_mmcif: Simplify clock and power setup in set_ios
Date: Tue, 22 Oct 2013 16:07:25 +0200
Message-ID: <1382450846-17144-7-git-send-email-ulf.hansson@linaro.org>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:38080 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3JVOHx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 10:07:53 -0400
Received: by mail-lb0-f169.google.com with SMTP id o14so2591499lbi.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 07:07:52 -0700 (PDT)
In-Reply-To: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch intend to simplify code in sh_mmcif_set_ios for how clock
and power are being configured.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index a1f421b..07c3af5 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -244,7 +244,6 @@ struct sh_mmcif_host {
 	size_t blocksize;
 	int sg_idx;
 	int sg_blkidx;
-	bool power;
 	bool card_present;
 	bool ccs_enable;		/* Command Completion Signal support */
 	bool clk_ctrl2_enable;
@@ -977,14 +976,13 @@ static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 	return ret;
 }
 
-static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
+static void sh_mmcif_set_power(struct sh_mmcif_host *host, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
 
 	if (!IS_ERR(mmc->supply.vmmc))
 		/* Errors ignored... */
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-				      ios->power_mode ? ios->vdd : 0);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
 
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -1010,37 +1008,22 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
 			host->card_present = true;
 		}
-		sh_mmcif_set_power(host, ios);
-	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
-		/* clock stop */
-		sh_mmcif_clock_control(host, 0);
-		if (ios->power_mode == MMC_POWER_OFF) {
-			if (host->card_present) {
-				sh_mmcif_release_dma(host);
-				host->card_present = false;
-			}
-		}
-		if (host->power) {
-			host->power = false;
-			if (ios->power_mode == MMC_POWER_OFF)
-				sh_mmcif_set_power(host, ios);
+		sh_mmcif_set_power(host, ios->vdd);
+		sh_mmcif_sync_reset(host);
+	} else if (ios->power_mode == MMC_POWER_OFF) {
+		if (host->card_present) {
+			sh_mmcif_release_dma(host);
+			host->card_present = false;
 		}
-		host->state = STATE_IDLE;
-		goto ret;
+		sh_mmcif_set_power(host, 0);
 	}
 
-	if (ios->clock) {
-		if (!host->power) {
-			host->power = true;
-			sh_mmcif_sync_reset(host);
-		}
-		sh_mmcif_clock_control(host, ios->clock);
-	}
+	sh_mmcif_clock_control(host, ios->clock);
 
 	host->timing = ios->timing;
 	host->bus_width = ios->bus_width;
 	host->state = STATE_IDLE;
-ret:
+
 	pm_runtime_mark_last_busy(mmc_dev(mmc));
 	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
@@ -1430,8 +1413,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	host->power = false;
-
 	host->hclk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->hclk)) {
 		ret = PTR_ERR(host->hclk);
-- 
1.7.9.5

