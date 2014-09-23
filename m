From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/6] mmc: Fix incorrect warning when setting 0 Hz via debugfs
Date: Tue, 23 Sep 2014 23:00:26 +0300
Message-ID: <1411502430-25535-3-git-send-email-adrian.hunter@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbaIWUB5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:01:57 -0400
In-Reply-To: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

It is possible to turn off the card clock by setting
the frequency to zero via debugfs e.g.

	echo 0 > /sys/kernel/debug/mmc0/clock

However that produces an incorrect warning that is
designed to warn if the frequency is below the minimum
operating frequency.  So correct the warning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e2e1dd4..16aa7bd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -995,7 +995,7 @@ void mmc_set_chip_select(struct mmc_host *host, int mode)
  */
 static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
 {
-	WARN_ON(hz < host->f_min);
+	WARN_ON(hz && hz < host->f_min);
 
 	if (hz > host->f_max)
 		hz = host->f_max;
-- 
1.8.3.2

