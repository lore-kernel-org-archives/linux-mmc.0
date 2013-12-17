From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: card: Remove host cap MMC_CAP2_SANITIZE
Date: Tue, 17 Dec 2013 15:04:16 +0100
Message-ID: <1387289058-19755-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:45528 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab3LQOE2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:04:28 -0500
Received: by mail-lb0-f182.google.com with SMTP id l4so1439021lbv.41
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 06:04:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

There is no need for keeping a host cap for MMC_CAP2_SANITIZE, instead
we just make the feature default available.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |    3 +--
 include/linux/mmc/host.h |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7b5424f..c2187d5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -415,8 +415,7 @@ static int ioctl_do_sanitize(struct mmc_card *card)
 {
 	int err;
 
-	if (!(mmc_can_sanitize(card) &&
-	      (card->host->caps2 & MMC_CAP2_SANITIZE))) {
+	if (!mmc_can_sanitize(card)) {
 			pr_warn("%s: %s - SANITIZE is not supported\n",
 				mmc_hostname(card->host), __func__);
 			err = -EOPNOTSUPP;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 99f5709..47fcc5d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -281,7 +281,6 @@ struct mmc_host {
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
 				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
-#define MMC_CAP2_SANITIZE	(1 << 15)		/* Support Sanitize */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.9.5

