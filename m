From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: core: Attempt to flush cache before reset
Date: Thu, 28 Apr 2016 10:48:59 +0300
Message-ID: <1461829739-19772-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63757 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcD1HxJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2016 03:53:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

CMD0 or hardware reset may invalidate the cache, so it needs to be
flushed before reset.

In the case of recovery, we can't expect flushing the cache to work
always, but have a go and ignore errors.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 99275e40bf2f..1b4e0ccb0885 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2453,6 +2453,12 @@ int mmc_hw_reset(struct mmc_host *host)
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * In the case of recovery, we can't expect flushing the cache to work
+	 * always, but we have a go and ignore errors.
+	 */
+	mmc_flush_cache(host->card);
+
 	ret = host->bus_ops->reset(host);
 	mmc_bus_put(host);
 
-- 
1.9.1

