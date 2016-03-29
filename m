From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/8] mmc: mediatek: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 09:31:08 +0200
Message-ID: <1459236673-5639-3-git-send-email-ulf.hansson@linaro.org>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33710 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbcC2Hb1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 03:31:27 -0400
Received: by mail-lb0-f177.google.com with SMTP id u8so4726932lbk.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 00:31:26 -0700 (PDT)
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Cc: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mtk-sd.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b17f30d..5642f71 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -736,9 +736,6 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
 }
 
 /* returns true if command is fully handled; returns false otherwise */
@@ -886,8 +883,6 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq);
 	host->mrq = mrq;
 
-	pm_runtime_get_sync(host->dev);
-
 	if (mrq->data)
 		msdc_prepare_data(host, mrq);
 
@@ -1201,8 +1196,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
-	pm_runtime_get_sync(host->dev);
-
 	msdc_set_buswidth(host, ios->bus_width);
 
 	/* Suspend/Resume will do power off/on */
@@ -1214,7 +1207,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 					ios->vdd);
 			if (ret) {
 				dev_err(host->dev, "Failed to set vmmc power!\n");
-				goto end;
+				return;
 			}
 		}
 		break;
@@ -1242,10 +1235,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (host->mclk != ios->clock || host->timing != ios->timing)
 		msdc_set_mclk(host, ios->timing, ios->clock);
-
-end:
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
 }
 
 static u32 test_delay_bit(u32 delay, u32 bit)
@@ -1408,19 +1397,15 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
-	pm_runtime_get_sync(host->dev);
 	ret = msdc_tune_response(mmc, opcode);
 	if (ret == -EIO) {
 		dev_err(host->dev, "Tune response fail!\n");
-		goto out;
+		return ret;
 	}
 	ret = msdc_tune_data(mmc, opcode);
 	if (ret == -EIO)
 		dev_err(host->dev, "Tune data fail!\n");
 
-out:
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
 	return ret;
 }
 
-- 
1.9.1

