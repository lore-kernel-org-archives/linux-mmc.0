From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: core: Remove support for MMC_CAP2_NO_SLEEP_CMD
Date: Tue, 17 Dec 2013 15:04:18 +0100
Message-ID: <1387289058-19755-3-git-send-email-ulf.hansson@linaro.org>
References: <1387289058-19755-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33294 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab3LQOEb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:04:31 -0500
Received: by mail-la0-f43.google.com with SMTP id n7so3355501lam.30
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 06:04:30 -0800 (PST)
In-Reply-To: <1387289058-19755-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

There are no active users of this host capability. The primary reason
for adding this cap was due to a bug in ux500 boot loader code, which
is not a relevant issue any more. So, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c   |    3 ---
 include/linux/mmc/host.h |    1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 98e9eb0..52b84cb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1358,9 +1358,6 @@ static int mmc_sleep(struct mmc_host *host)
 	struct mmc_card *card = host->card;
 	int err;
 
-	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
-		return 0;
-
 	err = mmc_deselect_cards(host);
 	if (err)
 		return err;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a76993c..4ff994c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -267,7 +267,6 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
-#define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
-- 
1.7.9.5

