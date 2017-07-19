From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 3/6] mmc: core: turn the pr_info under CONFIG_MMC_DEBUG into pr_debug
Date: Wed, 19 Jul 2017 15:55:46 +0800
Message-ID: <1500450949-206953-2-git-send-email-shawn.lin@rock-chips.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
 <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49478 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbdGSH4T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 03:56:19 -0400
In-Reply-To: <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

There are lots of debug message in core.c which use pr_debug
for better dynamic log level control. So it doesn't make sense
for those print to still keep working only under CONFIG_MMC_DEBUG.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/core/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 634f9ca..731aa9f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2436,10 +2436,9 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
 
-#ifdef CONFIG_MMC_DEBUG
-	pr_info("%s: %s: trying to init card at %u Hz\n",
+	pr_debug("%s: %s: trying to init card at %u Hz\n",
 		mmc_hostname(host), __func__, host->f_init);
-#endif
+
 	mmc_power_up(host, host->ocr_avail);
 
 	/*
@@ -2670,9 +2669,7 @@ int mmc_power_save_host(struct mmc_host *host)
 {
 	int ret = 0;
 
-#ifdef CONFIG_MMC_DEBUG
-	pr_info("%s: %s: powering down\n", mmc_hostname(host), __func__);
-#endif
+	pr_debug("%s: %s: powering down\n", mmc_hostname(host), __func__);
 
 	mmc_bus_get(host);
 
@@ -2696,9 +2693,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 {
 	int ret;
 
-#ifdef CONFIG_MMC_DEBUG
-	pr_info("%s: %s: powering up\n", mmc_hostname(host), __func__);
-#endif
+	pr_debug("%s: %s: powering up\n", mmc_hostname(host), __func__);
 
 	mmc_bus_get(host);
 
-- 
1.9.1


