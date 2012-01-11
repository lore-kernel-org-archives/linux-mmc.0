From: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH] mmc: core: claim host during mmc_power_off on suspend
Date: Wed, 11 Jan 2012 16:51:08 +0200
Message-ID: <1326293468-18604-1-git-send-email-arik@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48774 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977Ab2AKOvO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 09:51:14 -0500
Received: by wgbdt14 with SMTP id dt14so3878648wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2012 06:51:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Arik Nemtsov <arik@wizery.com>

Make sure the host is claimed in all calls of mmc_power_off() during
suspend. In addition make sure mmc_power_off() isn't called twice in
some suspend flows.

Signed-off-by: Arik Nemtsov <arik@wizery.com>
Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/mmc/core/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 950b97d..d830c5c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2305,6 +2305,7 @@ EXPORT_SYMBOL(mmc_cache_ctrl);
 int mmc_suspend_host(struct mmc_host *host)
 {
 	int err = 0;
+	bool powered_off = false;
 
 	if (host->caps & MMC_CAP_DISABLE)
 		cancel_delayed_work(&host->disable);
@@ -2348,6 +2349,7 @@ int mmc_suspend_host(struct mmc_host *host)
 				mmc_release_host(host);
 				host->pm_flags = 0;
 				err = 0;
+				powered_off = true;
 			}
 		} else {
 			err = -EBUSY;
@@ -2355,8 +2357,11 @@ int mmc_suspend_host(struct mmc_host *host)
 	}
 	mmc_bus_put(host);
 
-	if (!err && !mmc_card_keep_power(host))
+	if (!powered_off && !err && !mmc_card_keep_power(host)) {
+		mmc_claim_host(host);
 		mmc_power_off(host);
+		mmc_release_host(host);
+	}
 
 out:
 	return err;
-- 
1.7.5.4

