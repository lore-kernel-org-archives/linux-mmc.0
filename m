From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: sdhci.c: Do not disable global interrupts while
 waiting in set_ios
Date: Sun, 13 Feb 2011 23:07:29 -0800
Message-ID: <24EA1A0D-7F1E-4AD9-8687-EB2A41A5AC92@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47149 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1BNHLD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:11:03 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


holding the spin_lock with all interrupts disabled
is not good form when doing mdelay.
set_ios calls routines that need to delay for power to
stabalize or for chip issues when quirks are defined.

disable only our interupt and spin_lock on the chip
instead of spin_lock with all interrupts disabled.

use mmc_delay (if possible) rather then mdelay
to avoid active waits. sdhci_reset not changed.
still uses mdelay as we do not know if interrupts
have been disabled so we play "safe"

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.h  |   12 ------------
 drivers/mmc/host/sdhci.c |   26 +++++++++++++++++---------
 include/linux/mmc/host.h |   11 +++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 20b1c08..146b6f6 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -11,8 +11,6 @@
 #ifndef _MMC_CORE_CORE_H
 #define _MMC_CORE_CORE_H
 
-#include <linux/delay.h>
-
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
@@ -43,16 +41,6 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 
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
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 655617c..2d7fbd1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1043,7 +1043,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		mmc_delay(10);
 }
 
 /*****************************************************************************\
@@ -1161,22 +1161,21 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 	unsigned int lastclock;
+	unsigned long flags;
 	u8 ctrl;
 
 	host = mmc_priv(mmc);
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	if (host->flags & SDHCI_DEVICE_DEAD)
-		goto out;
+		return;
 
 	/*
 	 * get/put runtime_pm usage counter at ios->clock transitions
 	 * We need to do it before any other chip access, as sdhci could
 	 * be power gated
 	 */
+	spin_lock_irqsave(&host->lock, flags);
 	lastclock = host->iosclock;
 	host->iosclock = ios->clock;
 	if (lastclock == 0 && ios->clock != 0) {
@@ -1189,9 +1188,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		pm_runtime_put_autosuspend(host->mmc->parent);
 		spin_lock_irqsave(&host->lock, flags);
 	}
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	/* no need to configure the rest.. */
 	if (host->iosclock == 0)
-		goto out;
+		return;
+
+	/* disable local interrupts and lock structures so
+	 * that mmc_delay can be scheduled.  This cannot happen
+	 * if interrupts are globally disabled
+	 */
+	disable_irq(host->irq);
+	spin_lock(&host->lock);
 
 	/*
 	 * Reset the chip on each power off.
@@ -1255,9 +1263,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-out:
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
+	enable_irq(host->irq);
 }
 
 static int sdhci_get_ro(struct mmc_host *mmc)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..d9edc06 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -15,6 +15,7 @@
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/pm.h>
+#include <linux/delay.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
@@ -326,5 +327,15 @@ static inline int mmc_card_is_powered_resumed(struct mmc_host *host)
 	return host->pm_flags & MMC_PM_KEEP_POWER;
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
 #endif
 
-- 
1.7.0.4


