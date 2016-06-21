From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/5] mmc: core: Allow hosts to specify non-support for SD commands
Date: Tue, 21 Jun 2016 15:12:46 +0200
Message-ID: <1466514770-9462-2-git-send-email-ulf.hansson@linaro.org>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36636 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcFUNVJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 09:21:09 -0400
Received: by mail-lf0-f51.google.com with SMTP id q132so23582599lfe.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 06:20:12 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

There are host drivers which needs to valdiate for non-supported SD
commands and returnn error code for such requests.

To improve and simplify the behaviour, let's invent MMC_CAP2_NO_SD
which these host drivers can set to tell the mmc core to skip sending SD
commands during card initialization.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 9 ++++++---
 include/linux/mmc/host.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e864187..8b11028 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2500,15 +2500,18 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 	mmc_go_idle(host);
 
-	mmc_send_if_cond(host, host->ocr_avail);
+	if (!(host->caps2 & MMC_CAP2_NO_SD))
+		mmc_send_if_cond(host, host->ocr_avail);
 
 	/* Order's important: probe SDIO, then SD, then MMC */
 	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
 		if (!mmc_attach_sdio(host))
 			return 0;
 
-	if (!mmc_attach_sd(host))
-		return 0;
+	if (!(host->caps2 & MMC_CAP2_NO_SD))
+		if (!mmc_attach_sd(host))
+			return 0;
+
 	if (!mmc_attach_mmc(host))
 		return 0;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d72c0c3..c22476d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -309,6 +309,7 @@ struct mmc_host {
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
+#define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.9.1

