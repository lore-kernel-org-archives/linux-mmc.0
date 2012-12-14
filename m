From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/3] mmc: core: enhance the code for signal voltage setting
Date: Fri, 14 Dec 2012 18:53:56 +0800
Message-ID: <1355482438-16836-2-git-send-email-kliu5@marvell.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:49583 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753461Ab2LNKvT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 05:51:19 -0500
In-Reply-To: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com
Cc: per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

1. if host does NOT implement signal voltage setting function,
should return error.
2. add the check for data signal before voltage change according
to the spec. If host does NOT detect a low signal level, the host
should abort the voltage switch sequence. (phisical layer spec 4.2.4.2(4))
3. if voltage change failed then no need to restore the clock
before cycle power the card.
4. call mmc_power_cycle here since it's a part of voltage switch.
besides -EAGAIN, any other error returned should also cycle power the card.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |   71 ++++++++++++++++++++++++++++------------------
 1 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d1aa8ab..da93186 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1226,6 +1226,9 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 
 	BUG_ON(!host);
 
+	if (!host->ops->start_signal_voltage_switch)
+		return -EPERM;
+
 	/*
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
@@ -1245,47 +1248,59 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 
 	host->ios.signal_voltage = signal_voltage;
 
-	if (host->ops->start_signal_voltage_switch) {
-		u32 clock;
+	u32 clock;
+
+	mmc_host_clk_hold(host);
+
+	if (cmd11) {
+		if (!host->ops->card_busy)
+			pr_warning("%s: cannot verify signal voltage switch\n",
+					mmc_hostname(host));
 
-		mmc_host_clk_hold(host);
 		/*
 		 * During a signal voltage level switch, the clock must be gated
 		 * for a certain period of time according to the SD spec
 		 */
-		if (cmd11) {
-			clock = host->ios.clock;
-			host->ios.clock = 0;
-			mmc_set_ios(host);
-		}
+		clock = host->ios.clock;
+		host->ios.clock = 0;
+		mmc_set_ios(host);
 
-		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+		if (host->ops->card_busy && !host->ops->card_busy(host)) {
+			err = -EAGAIN;
+		} else {
 
-		if (err && cmd11) {
-			host->ios.clock = clock;
-			mmc_set_ios(host);
-		} else if (cmd11) {
-			/* Keep clock gated for at least 5 ms */
-			mmc_delay(5);
-			host->ios.clock = clock;
-			mmc_set_ios(host);
+			err = host->ops->start_signal_voltage_switch(host, &host->ios);
 
-			/* Wait for at least 1 ms according to spec */
-			mmc_delay(1);
+			if (!err) {
+				/* Keep clock gated for at least 5 ms */
+				mmc_delay(5);
+				host->ios.clock = clock;
+				mmc_set_ios(host);
 
-			/*
-			 * Failure to switch is indicated by the card holding
-			 * dat[0:3] low
-			 */
-			if (!host->ops->card_busy)
-				pr_warning("%s: cannot verify signal voltage switch\n",
+				/* Wait for at least 1 ms according to spec */
+				mmc_delay(1);
+
+				/*
+				 * Failure to switch is indicated by the card holding
+				 * dat[0:3] low
+				 */
+				if (host->ops->card_busy && host->ops->card_busy(host))
+					err = -EAGAIN;
+			}
+		}
+		if (err) {
+			/* Power cycle card */
+			pr_debug("%s: Signal voltage switch failed, "
+					"power cycling card \n",
 					mmc_hostname(host));
-			else if (host->ops->card_busy(host))
-				err = -EAGAIN;
+			mmc_power_cycle(host);
 		}
-		mmc_host_clk_release(host);
+	} else {
+		err = host->ops->start_signal_voltage_switch(host, &host->ios);
 	}
 
+	mmc_host_clk_release(host);
+
 	return err;
 }
 
-- 
1.7.0.4

