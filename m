From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Tue, 17 Jan 2017 14:15:35 +0200
Message-ID: <1484655337-32562-2-git-send-email-uri.yanai@sandisk.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:42725
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750967AbdAQMPz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Jan 2017 07:15:55 -0500
In-Reply-To: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, chris@printf.net, alex.lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

Adds define MMC_RUNTIME_SUSPEND_DELAY_MS for setting delay
time(in milliseconds) before entering device runtime suspend.
Setting the default to 3000 milliseconds.

Change-Id: Ifab084cc01d8dff8c79606f8de0858f0821e98bc
Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/block.c | 3 ++-
 include/linux/mmc/host.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6648a17..7954f15 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2202,7 +2202,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 			goto out;
 	}
 
-	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
+	pm_runtime_set_autosuspend_delay(&card->dev,
+			MMC_RUNTIME_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&card->dev);
 
 	/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8bc8841..4a0b30f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -22,6 +22,8 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/pm.h>
 
+#define MMC_RUNTIME_SUSPEND_DELAY_MS	3000
+
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
 	unsigned short	vdd;
-- 
1.9.1

