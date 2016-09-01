From: alex lemberg <alex.lemberg@sandisk.com>
Subject: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Thu, 1 Sep 2016 17:24:48 +0300
Message-ID: <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:29861
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbcIAO3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 10:29:08 -0400
In-Reply-To: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: avi.shchislowski@sandisk.com, alex lemberg <alex.lemberg@sandisk.com>

Add MMC_AUTOSUSPEND_DELAY_MS define

Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/card/block.c | 3 ++-
 include/linux/mmc/host.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48a5dd7..f4386ed 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2610,7 +2610,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 			goto out;
 	}
 
-	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
+	pm_runtime_set_autosuspend_delay(&card->dev,
+		MMC_RUNTIME_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&card->dev);
 
 	/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aa4bfbf..8cb8218 100644
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

