From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V3] mmc: core: Add option to prevent eMMC sleep command
Date: Mon, 19 Dec 2011 16:24:19 +0100
Message-ID: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:43491 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858Ab1LSPZR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 10:25:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Host may now use MMC_CAP2_NO_SLEEP_CMD to disable the use
of eMMC sleep/awake command.

This option can be used when you platform have a buggy
kernel crash dump software, which is supposed to store
the dump on the eMMC, but is not able to wake up the eMMC
from sleep state.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Subhash Jadavani <subhashj@codeaurora.org>
---

Changes in v3:
	- Change name of define.

Changes in v2:
	- Added some motivation to why this patch is wanted in the
	commit message.

---
 drivers/mmc/core/core.c  |    6 ++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a2aa860..684156c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2246,6 +2246,9 @@ int mmc_card_awake(struct mmc_host *host)
 {
 	int err = -ENOSYS;
 
+	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
+		return 0;
+
 	mmc_bus_get(host);
 
 	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
@@ -2261,6 +2264,9 @@ int mmc_card_sleep(struct mmc_host *host)
 {
 	int err = -ENOSYS;
 
+	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
+		return 0;
+
 	mmc_bus_get(host);
 
 	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a03d03..6e71ac6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -242,6 +242,7 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.5.4

