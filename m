From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [v4 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 21 Dec 2012 17:27:59 +0800
Message-ID: <1356082080-7756-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:13470
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445Ab2LUJ03 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 04:26:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Chunhe Lan <Chunhe.Lan@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>

Move mmc_delay() from drivers/mmc/core/core.h to
include/linux/mmc/core.h. So when other functions
call it with include syntax using <linux/mmc/core.h>
of absolute path rather than "../core/core.h" of
relative path.

At the same time, change code, so schedule subsystem
has more chances to call other threads.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.h  |   12 ------------
 include/linux/mmc/core.h |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..5f63d00 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -11,8 +11,6 @@
 #ifndef _MMC_CORE_CORE_H
 #define _MMC_CORE_CORE_H
 
-#include <linux/delay.h>
-
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
@@ -46,16 +44,6 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
 
-static inline void mmc_delay(unsigned int ms)
-{
-	if (ms < 1000 / HZ) {
-		cond_resched();
-		mdelay(ms);
-	} else {
-		msleep(ms);
-	}
-}
-
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 5bf7c22..e051c5b 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 
 struct request;
 struct mmc_data;
@@ -198,6 +199,22 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+static inline void mmc_delay(unsigned int ms)
+{
+	ktime_t end = ktime_add_us(ktime_get(), ms * 1000);
+
+	while (1) {
+		s64 remaining;
+
+		cond_resched();
+		remaining = ktime_to_us(ktime_sub(end, ktime_get()));
+		if (remaining < 0)
+			break;
+
+		udelay(min_t(u32, remaining, 100));
+	}
+}
+
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.7.6.5


