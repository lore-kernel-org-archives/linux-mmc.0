From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: sh_mmcif: Restructure ->set_ios()
Date: Thu, 11 Feb 2016 13:59:54 +0100
Message-ID: <1455195595-5121-2-git-send-email-ulf.hansson@linaro.org>
References: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36300 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbcBKNAN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 08:00:13 -0500
Received: by mail-lf0-f48.google.com with SMTP id 78so30958245lfy.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 05:00:12 -0800 (PST)
In-Reply-To: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Both from a runtime PM and clock management point of view, the ->set_ios()
code is unnecessary complex.

A suboptimal path is also executed when the mmc core requests a clock rate
of zero. As that happens during the card initialization phase, trying to
save power by decreasing the runtime PM usage count and gating the clock
via clk_disable_unprepare() is just superfluous.

Moreover, from a runtime PM point of view the core will anyway keep the
device active during the entire card initialization phase.

Restructure the code to rely on the ios->power_mode to understand when the
runtime PM usage count needs to be increased. Let's also deal with clock
rate changes by simply applying the rate.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index c6c2a08..1c84c62 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -248,7 +248,6 @@ struct sh_mmcif_host {
 	int sg_idx;
 	int sg_blkidx;
 	bool power;
-	bool card_present;
 	bool ccs_enable;		/* Command Completion Signal support */
 	bool clk_ctrl2_enable;
 	struct mutex thread_lock;
@@ -1091,42 +1090,30 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->state = STATE_IOS;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (ios->power_mode == MMC_POWER_UP) {
-		if (!host->card_present) {
-			/* See if we also get DMA */
+	switch (ios->power_mode) {
+	case MMC_POWER_UP:
+		sh_mmcif_set_power(host, ios);
+		if (!host->power) {
+			clk_prepare_enable(host->clk);
+			pm_runtime_get_sync(dev);
+			sh_mmcif_sync_reset(host);
 			sh_mmcif_request_dma(host);
-			host->card_present = true;
+			host->power = true;
 		}
+		break;
+	case MMC_POWER_OFF:
 		sh_mmcif_set_power(host, ios);
-	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
-		/* clock stop */
-		sh_mmcif_clock_control(host, 0);
-		if (ios->power_mode == MMC_POWER_OFF) {
-			if (host->card_present) {
-				sh_mmcif_release_dma(host);
-				host->card_present = false;
-			}
-		}
 		if (host->power) {
-			pm_runtime_put_sync(dev);
+			sh_mmcif_clock_control(host, 0);
+			sh_mmcif_release_dma(host);
+			pm_runtime_put(dev);
 			clk_disable_unprepare(host->clk);
 			host->power = false;
-			if (ios->power_mode == MMC_POWER_OFF)
-				sh_mmcif_set_power(host, ios);
-		}
-		host->state = STATE_IDLE;
-		return;
-	}
-
-	if (ios->clock) {
-		if (!host->power) {
-			clk_prepare_enable(host->clk);
-
-			pm_runtime_get_sync(dev);
-			host->power = true;
-			sh_mmcif_sync_reset(host);
 		}
+		break;
+	case MMC_POWER_ON:
 		sh_mmcif_clock_control(host, ios->clock);
+		break;
 	}
 
 	host->timing = ios->timing;
-- 
1.9.1

