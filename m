From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] mmc: allow rescan of non-removable hosts on resume
Date: Wed,  6 Dec 2017 10:57:24 +0000
Message-ID: <20171206105724.5603-1-drake@endlessm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34769 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdLFK53 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Dec 2017 05:57:29 -0500
Received: by mail-wr0-f196.google.com with SMTP id y21so3429485wrc.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Dec 2017 02:57:29 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux@endlessm.com, matthew.leeds@endlessm.com

The Weibu F3C MiniPC has an onboard AP6255 module, presenting
two SDIO functions on a single MMC host (Bluetooth/btsdio and
WiFi/brcmfmac), and the mmc layer correctly detects this as
non-removable.

After suspend/resume, the wifi and bluetooth interfaces disappear
and do not get probed again.

The conditions here are:

 1. During suspend, we reach mmc_pm_notify()

 2. mmc_pm_notify() calls mmc_sdio_pre_suspend() to see if we can
    suspend the SDIO host. However, mmc_sdio_pre_suspend() returns
    -ENOSYS because btsdio_driver does not have a suspend method.

 3. mmc_pm_notify() proceeds to remove the card

 4. Upon resume, mmc_rescan() does nothing with this host, because of
    the rescan_entered check which aims to only scan a non-removable
    device a single time (i.e. during boot).

Fix the loss of functionality by permitting another rescan of
non-removable devices when we forcefully remove a card under these
conditions.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/mmc/core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f0f44f4dd5f..e436cde50bc4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2966,6 +2966,10 @@ static int mmc_pm_notify(struct notifier_block *notify_block,
 		mmc_power_off(host);
 		mmc_release_host(host);
 		host->pm_flags = 0;
+
+		/* Force a rescan on resume, even for non-removable cards */
+		host->rescan_entered = 0;
+
 		break;
 
 	case PM_POST_SUSPEND:
-- 
2.14.1

