From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH v2] mmc: Add helper function to check if a card is removable
Date: Mon, 30 Aug 2010 10:59:54 +0100
Message-ID: <47ab65a2e5b756b73fb78efa3a238f0c1c87fa24.1283158644.git.matt@console-pimps.org>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:41359 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754795Ab0H3J75 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 05:59:57 -0400
In-Reply-To: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>

There are two checks that need to be made when determining whether a
card is removable. A host controller may set MMC_CAP_NONREMOVABLE if the
controller does not support removing cards (e.g. eMMC), in which case
the card is physically non-removable. Also the 'mmc_assume_removable'
module parameter can be configured at module load time, in which case
the card may be logically non-removable.

A helper function keeps the logic in one place so that code always
checks both conditions.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---

Guys, it'd be good if someone could give me a Tested-by: for this patch
just to make sure that it works as intended. Jaehoon, Kyungmin, does
this patch work for you?

 drivers/mmc/core/core.h  |    1 -
 drivers/mmc/core/mmc.c   |    2 +-
 drivers/mmc/core/sd.c    |    2 +-
 include/linux/mmc/host.h |    8 ++++++++
 4 files changed, 10 insertions(+), 3 deletions(-)

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
index dcfc921..66c4a59 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -718,7 +718,7 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
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
index 09dbb90..c920cfc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -272,5 +272,13 @@ static inline void mmc_set_disable_delay(struct mmc_host *host,
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
1.7.1

