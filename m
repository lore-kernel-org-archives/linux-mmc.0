From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/12] mmc: core: Reset driver type to default
Date: Thu,  5 Feb 2015 15:13:38 +0200
Message-ID: <1423142029-22521-2-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbbBENR7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:17:59 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

IO state variable drv_type could be set during card
initialization. Consequently, it must be reset to the
default value when setting the initial state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index cd46c0e..dbc40c5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1179,6 +1179,7 @@ void mmc_set_initial_state(struct mmc_host *host)
 	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
 	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.drv_type = 0;
 
 	mmc_set_ios(host);
 }
-- 
1.9.1

