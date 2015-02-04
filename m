From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH] mmc: core: make the poll interval for the broken CD adjustable
Date: Wed,  4 Feb 2015 19:25:25 +0800
Message-ID: <1423049125-11511-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:48726 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbbBDLZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Feb 2015 06:25:50 -0500
Received: by mail-yk0-f172.google.com with SMTP id 9so400928ykp.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2015 03:25:49 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

In the current kernel, the poll interval for the broken CD is hard
coded to 1 second. This will trigger about 50 mmc interrupts per
second on a SoC like fsl p2020 if there is no card in the slot.
The overhead for this is not trivial. So add a module parameter to
make the poll interval adjustable. At the same time make the default
value a bit bigger, and the system which really need the per second
poll can tweak this parameter to be compatible with the old kernel.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/core/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0dc64e6e00d4..b95da0719fb0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -66,6 +66,10 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
 
+static int rescan_interval = 5;
+module_param(rescan_interval, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+MODULE_PARM_DESC(rescan_interval, "Set the poll interval(in seconds) for broken CD(default:5, disable: <=0)");
+
 /*
  * Internal function. Schedule delayed work in the MMC work queue.
  */
@@ -2507,8 +2511,8 @@ void mmc_rescan(struct work_struct *work)
 	mmc_release_host(host);
 
  out:
-	if (host->caps & MMC_CAP_NEEDS_POLL)
-		mmc_schedule_delayed_work(&host->detect, HZ);
+	if ((host->caps & MMC_CAP_NEEDS_POLL) && (rescan_interval > 0))
+		mmc_schedule_delayed_work(&host->detect, HZ * rescan_interval);
 }
 
 void mmc_start_host(struct mmc_host *host)
-- 
1.9.3

