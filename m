From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] mmc: avoid removing non-removable hosts during suspend
Date: Tue, 12 Dec 2017 10:49:02 +0000
Message-ID: <20171212104902.11793-1-drake@endlessm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43986 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdLLKtH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Dec 2017 05:49:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id n138so19790011wmg.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Dec 2017 02:49:07 -0800 (PST)
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

Fix the loss of functionality by detecting that we are unable to
suspend a non-removable host, so avoid the forced removal in that
case. The comment above this function already indicates that this
code was only intended for removable devices.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Replaces previous approach:
  [PATCH] mmc: allow rescan of non-removable hosts on resume

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 26431267a3e2..6f815a264285 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2763,6 +2763,14 @@ static int mmc_pm_notify(struct notifier_block *notify_block,
 		if (!err)
 			break;
 
+		if (!mmc_card_is_removable(host)) {
+			dev_warn(mmc_dev(host),
+				 "pre_suspend failed for non-removable host: "
+				 "%d\n", err);
+			/* Avoid removing non-removable hosts */
+			break;
+		}
+
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
-- 
2.14.1

