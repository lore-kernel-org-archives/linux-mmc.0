From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH V2 1/2] mmc: Add helper function to check if a card is removable
Date: Mon, 27 Sep 2010 09:42:19 +0100
Message-ID: <1285576940-27587-2-git-send-email-matt@console-pimps.org>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:44853 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758881Ab0I0ImX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 04:42:23 -0400
In-Reply-To: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>

There are two checks that need to be made when determining whether a
card is removable. A host controller may set MMC_CAP_NONREMOVABLE if the
controller does not support removing cards (e.g. eMMC), in which case
the card is physically non-removable. Also the 'mmc_assume_removable'
module parameter can be configured at module load time, in which case
the card may be logically non-removable.

A helper function keeps the logic in one place so that code always
checks both conditions.

Because this new function is likely to be called from modules we now
need to export the mmc_assume_removable symbol.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c  |    1 +
 drivers/mmc/core/core.h  |    1 -
 drivers/mmc/core/mmc.c   |    2 +-
 drivers/mmc/core/sd.c    |    2 +-
 include/linux/mmc/host.h |    8 ++++++++
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5db49b1..7c12612 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -58,6 +58,7 @@ int mmc_assume_removable;
 #else
 int mmc_assume_removable = 1;
 #endif
+EXPORT_SYMBOL(mmc_assume_removable);
 module_param_named(removable, mmc_assume_removable, bool, 0644);
 MODULE_PARM_DESC(
 	removable,
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9d9eef5..a2ca770 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -58,7 +58,6 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr);
 
 /* Module parameters */
 extern int use_spi_crc;
-extern int mmc_assume_removable;
 
 /* Debugfs information for hosts and cards */
 void mmc_add_host_debugfs(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6909a54..6570c03 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -685,7 +685,7 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
 {
 	const struct mmc_bus_ops *bus_ops;
 
-	if (host->caps & MMC_CAP_NONREMOVABLE || !mmc_assume_removable)
+	if (!mmc_card_is_removable(host))
 		bus_ops = &mmc_ops_unsafe;
 	else
 		bus_ops = &mmc_ops;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0f52410..bc745e1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -750,7 +750,7 @@ static void mmc_sd_attach_bus_ops(struct mmc_host *host)
 {
 	const struct mmc_bus_ops *bus_ops;
 
-	if (host->caps & MMC_CAP_NONREMOVABLE || !mmc_assume_removable)
+	if (!mmc_card_is_removable(host))
 		bus_ops = &mmc_sd_ops_unsafe;
 	else
 		bus_ops = &mmc_sd_ops;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ded4017..23a4864 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -267,5 +267,13 @@ static inline void mmc_set_disable_delay(struct mmc_host *host,
 	host->disable_delay = disable_delay;
 }
 
+/* Module parameter */
+extern int mmc_assume_removable;
+
+static inline int mmc_card_is_removable(struct mmc_host *host)
+{
+	return (!(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable);
+}
+
 #endif
 
-- 
1.7.2.1

