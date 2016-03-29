From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/8] mmc: omap_hsmmc: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 09:31:09 +0200
Message-ID: <1459236673-5639-4-git-send-email-ulf.hansson@linaro.org>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33722 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbcC2Hb2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 03:31:28 -0400
Received: by mail-lb0-f178.google.com with SMTP id u8so4727317lbk.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 00:31:27 -0700 (PDT)
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/omap_hsmmc.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f9ac3bb..835943a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -968,8 +968,6 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
 }
 
 /*
@@ -1250,7 +1248,6 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	int ret;
 
 	/* Disable the clocks */
-	pm_runtime_put_sync(host->dev);
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
@@ -1260,7 +1257,6 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
 		ret = omap_hsmmc_set_power(host->dev, 1, vdd);
-	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
 
@@ -1368,8 +1364,6 @@ static void omap_hsmmc_dma_callback(void *param)
 
 		host->mrq = NULL;
 		mmc_request_done(host->mmc, mrq);
-		pm_runtime_mark_last_busy(host->dev);
-		pm_runtime_put_autosuspend(host->dev);
 	}
 }
 
@@ -1602,7 +1596,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	BUG_ON(host->req_in_progress);
 	BUG_ON(host->dma_ch != -1);
-	pm_runtime_get_sync(host->dev);
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1619,8 +1612,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 			req->data->error = -EBADF;
 		req->cmd->retries = 0;
 		mmc_request_done(mmc, req);
-		pm_runtime_mark_last_busy(host->dev);
-		pm_runtime_put_autosuspend(host->dev);
 		return;
 	} else if (host->reqs_blocked)
 		host->reqs_blocked = 0;
@@ -1634,8 +1625,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 			req->data->error = err;
 		host->mrq = NULL;
 		mmc_request_done(mmc, req);
-		pm_runtime_mark_last_busy(host->dev);
-		pm_runtime_put_autosuspend(host->dev);
 		return;
 	}
 	if (req->sbc && !(host->flags & AUTO_CMD23)) {
@@ -1653,8 +1642,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	int do_send_init_stream = 0;
 
-	pm_runtime_get_sync(host->dev);
-
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
@@ -1698,8 +1685,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		send_init_stream(host);
 
 	omap_hsmmc_set_bus_mode(host);
-
-	pm_runtime_put_autosuspend(host->dev);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
-- 
1.9.1

