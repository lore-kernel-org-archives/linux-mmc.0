From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH 1/3 v2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 26 Aug 2011 15:52:30 +0800
Message-ID: <1314345150-1803-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:33102
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790Ab1HZI4F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 04:56:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>, Chris Ball <cjb@laptop.org>

Move mmc_delay() from drivers/mmc/core/core.h to
include/linux/mmc/core.h. So when other functions
call it with include syntax using <linux/mmc/core.h>
of absolute path rather than "../core/core.h" of
relative path.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.h  |   12 ------------
 include/linux/mmc/core.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d9411ed..58c3f10 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -11,8 +11,6 @@
 #ifndef _MMC_CORE_CORE_H
 #define _MMC_CORE_CORE_H
 
-#include <linux/delay.h>
-
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
@@ -44,16 +42,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 
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
index b8b1b7a..7bc2798 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 
 struct request;
 struct mmc_data;
@@ -182,6 +183,16 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+static inline void mmc_delay(unsigned int ms)
+{
+	if (ms < 1000 / HZ) {
+		cond_resched();
+		mdelay(ms);
+	} else {
+		msleep(ms);
+	}
+}
+
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.7.5.1


