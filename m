From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: Fix hangs related to insert/remove of cards
Date: Tue, 13 Sep 2011 15:02:37 +0200
Message-ID: <1315918957-11491-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:37181 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753293Ab1IMNDB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2011 09:03:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

During a rescan operation mmc_attach(sd|mmc|sdio) functions are
called. The error handling in these function can trigger a detach
of the bus, which also meant a power off. This is not notified by
the rescan operation which then continues to the next attach function.

If a power off has been done, the framework must never send any
new commands to the host driver, without first doing a new power up.
This will most likely trigger any host driver to hang.

Moving power off out of detach and instead handle power off
separately when it is actually needed, solves the issue.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c |   10 +++++-----
 drivers/mmc/core/core.h |    1 +
 drivers/mmc/core/mmc.c  |    1 +
 drivers/mmc/core/sd.c   |    1 +
 drivers/mmc/core/sdio.c |    1 +
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91a0a74..68fa639 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1128,7 +1128,7 @@ static void mmc_power_up(struct mmc_host *host)
 	mmc_delay(10);
 }
 
-static void mmc_power_off(struct mmc_host *host)
+void mmc_power_off(struct mmc_host *host)
 {
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
@@ -1214,8 +1214,7 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
 }
 
 /*
- * Remove the current bus handler from a host. Assumes that there are
- * no interesting cards left, so the bus is powered down.
+ * Remove the current bus handler from a host.
  */
 void mmc_detach_bus(struct mmc_host *host)
 {
@@ -1232,8 +1231,6 @@ void mmc_detach_bus(struct mmc_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_power_off(host);
-
 	mmc_bus_put(host);
 }
 
@@ -1818,6 +1815,7 @@ void mmc_stop_host(struct mmc_host *host)
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
+		mmc_power_off(host);
 		mmc_release_host(host);
 		mmc_bus_put(host);
 		return;
@@ -1947,6 +1945,7 @@ int mmc_suspend_host(struct mmc_host *host)
 				host->bus_ops->remove(host);
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
+			mmc_power_off(host);
 			mmc_release_host(host);
 			host->pm_flags = 0;
 			err = 0;
@@ -2034,6 +2033,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 			host->bus_ops->remove(host);
 
 		mmc_detach_bus(host);
+		mmc_power_off(host);
 		mmc_release_host(host);
 		host->pm_flags = 0;
 		break;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d9411ed..14664f1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -43,6 +43,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 			   bool cmd11);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
+void mmc_power_off(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5700b1c..59b5faa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -891,6 +891,7 @@ static void mmc_detect(struct mmc_host *host)
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
+		mmc_power_off(host);
 		mmc_release_host(host);
 	}
 }
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 633975f..a7da23e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1018,6 +1018,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
+		mmc_power_off(host);
 		mmc_release_host(host);
 	}
 }
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 262fff0..ac492ac 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -597,6 +597,7 @@ out:
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
+		mmc_power_off(host);
 		mmc_release_host(host);
 	}
 }
-- 
1.7.5.4

