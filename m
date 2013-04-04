From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] Revert "mmc: core: wait while adding MMC host to ensure root mounts successfully"
Date: Thu,  4 Apr 2013 16:41:05 +0300
Message-ID: <1365082866-28404-2-git-send-email-adrian.hunter@intel.com>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48115 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760322Ab3DDNgI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 09:36:08 -0400
In-Reply-To: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

This reverts commit 3500ed90b26a9935b943b5e2e4cd3226600d6b58.

The reverted patch caused a significant performance regression when
booting with the root file system on eMMC.

Before the patch:

[    1.625623] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.

After the patch:

[    1.935851] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.

That was an addition of 310 ms which is a 19% performance degradation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..3bf1c46 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2418,7 +2418,6 @@ void mmc_start_host(struct mmc_host *host)
 	host->rescan_disable = 0;
 	mmc_power_up(host);
 	mmc_detect_change(host, 0);
-	mmc_flush_scheduled_work();
 }
 
 void mmc_stop_host(struct mmc_host *host)
-- 
1.7.11.7

