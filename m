From: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v2] mmc: core: claim host during mmc_power_off on suspend
Date: Wed, 18 Jan 2012 15:38:51 +0200
Message-ID: <1326893931-14500-1-git-send-email-arik@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47494 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2ARNi6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 08:38:58 -0500
Received: by werb13 with SMTP id b13so357717wer.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2012 05:38:57 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ido Yariv <ido@wizery.com>, Adrian Hunter <adrian.hunter@intel.com>, Arik Nemtsov <arik@wizery.com>

Make sure the host is claimed in all calls of mmc_power_off() during
suspend. In addition make sure mmc_power_off() isn't called twice in
some suspend flows.

Signed-off-by: Arik Nemtsov <arik@wizery.com>
Signed-off-by: Ido Yariv <ido@wizery.com>
---
v1->2: use mmc_try_claim_host(), as suggested by Adrian

 drivers/mmc/core/core.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f545a3e..dd633d6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2360,6 +2360,7 @@ EXPORT_SYMBOL(mmc_cache_ctrl);
 int mmc_suspend_host(struct mmc_host *host)
 {
 	int err = 0;
+	bool powered_off = false;
 
 	if (host->caps & MMC_CAP_DISABLE)
 		cancel_delayed_work(&host->disable);
@@ -2411,6 +2412,7 @@ int mmc_suspend_host(struct mmc_host *host)
 				mmc_release_host(host);
 				host->pm_flags = 0;
 				err = 0;
+				powered_off = true;
 			}
 		} else {
 			err = -EBUSY;
@@ -2418,8 +2420,14 @@ int mmc_suspend_host(struct mmc_host *host)
 	}
 	mmc_bus_put(host);
 
-	if (!err && !mmc_card_keep_power(host))
-		mmc_power_off(host);
+	if (!powered_off && !err && !mmc_card_keep_power(host)) {
+		if (mmc_try_claim_host(host)) {
+			mmc_power_off(host);
+			mmc_do_release_host(host);
+		} else {
+			err = -EBUSY;
+		}
+	}
 
 out:
 	return err;
-- 
1.7.5.4

