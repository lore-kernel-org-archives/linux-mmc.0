From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: sh_mmci: Get rid of wrapper function for regulators
Date: Thu, 11 Feb 2016 13:59:55 +0100
Message-ID: <1455195595-5121-3-git-send-email-ulf.hansson@linaro.org>
References: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34023 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbcBKNAO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 08:00:14 -0500
Received: by mail-lf0-f43.google.com with SMTP id j78so30991429lfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 05:00:13 -0800 (PST)
In-Reply-To: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

As there are two callers of sh_mmcif_set_power() and because its only
additional action is to check for a valid regulator, let's just remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1c84c62..e0328b4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1063,16 +1063,6 @@ static void sh_mmcif_clk_setup(struct sh_mmcif_host *host)
 		host->mmc->f_max, host->mmc->f_min);
 }
 
-static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
-{
-	struct mmc_host *mmc = host->mmc;
-
-	if (!IS_ERR(mmc->supply.vmmc))
-		/* Errors ignored... */
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-				      ios->power_mode ? ios->vdd : 0);
-}
-
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
@@ -1092,7 +1082,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-		sh_mmcif_set_power(host, ios);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		if (!host->power) {
 			clk_prepare_enable(host->clk);
 			pm_runtime_get_sync(dev);
@@ -1102,7 +1093,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		break;
 	case MMC_POWER_OFF:
-		sh_mmcif_set_power(host, ios);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		if (host->power) {
 			sh_mmcif_clock_control(host, 0);
 			sh_mmcif_release_dma(host);
-- 
1.9.1

