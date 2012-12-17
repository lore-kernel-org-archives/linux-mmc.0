From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v2 1/3] mmc: core: enhance the code for signal voltage setting
Date: Mon, 17 Dec 2012 15:50:25 +0800
Message-ID: <1355730627-8751-2-git-send-email-kliu5@marvell.com>
References: <1355730627-8751-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37929 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303Ab2LQHu4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 02:50:56 -0500
In-Reply-To: <1355730627-8751-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com
Cc: per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

1. with cmd11, if host does NOT implement signal voltage setting function,
should return error.
2. add the check for data signal before voltage change according
to the spec. If host does NOT detect a low signal level, the host
should abort the voltage switch sequence. (phisical layer spec 4.2.4.2(4))
3. if voltage change failed then no need to restore the clock
before cycle power the card.
4. call mmc_power_cycle here since it's a part of voltage switch.
besides -EAGAIN, any other error returned should also cycle power the card.
5. host->ios.signal_voltage only updated after signal switch success.
And change the parameter to host driver function start_signal_voltage_switch
from &host->ios to signal_voltage.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Tested-by: Tim Wang <wangtt@marvell.com>
---
 drivers/mmc/core/core.c  |   77 ++++++++++++++++++++++++++++------------------
 include/linux/mmc/host.h |    2 +-
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d1aa8ab..83be2a1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1231,6 +1231,10 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 	 * 1.8V signalling.
 	 */
 	if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
+
+		if (!host->ops->start_signal_voltage_switch)
+			return -EPERM;
+
 		cmd.opcode = SD_SWITCH_VOLTAGE;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -1241,51 +1245,64 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 
 		if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
 			return -EIO;
-	}
 
-	host->ios.signal_voltage = signal_voltage;
+		mmc_host_clk_hold(host);
 
-	if (host->ops->start_signal_voltage_switch) {
-		u32 clock;
+		if (!host->ops->card_busy)
+			pr_warning("%s: cannot verify signal voltage switch\n",
+					mmc_hostname(host));
+		if (host->ops->card_busy && !host->ops->card_busy(host)) {
+			err = -EAGAIN;
+		} else {
+			u32 clock;
 
-		mmc_host_clk_hold(host);
-		/*
-		 * During a signal voltage level switch, the clock must be gated
-		 * for a certain period of time according to the SD spec
-		 */
-		if (cmd11) {
+			/*
+			 * During a signal voltage level switch, the clock must be gated
+			 * for a certain period of time according to the SD spec
+			 */
 			clock = host->ios.clock;
 			host->ios.clock = 0;
 			mmc_set_ios(host);
-		}
 
-		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+			err = host->ops->start_signal_voltage_switch(host, signal_voltage);
 
-		if (err && cmd11) {
-			host->ios.clock = clock;
-			mmc_set_ios(host);
-		} else if (cmd11) {
-			/* Keep clock gated for at least 5 ms */
-			mmc_delay(5);
-			host->ios.clock = clock;
-			mmc_set_ios(host);
+			if (!err) {
+				/* Keep clock gated for at least 5 ms */
+				mmc_delay(5);
+				host->ios.clock = clock;
+				mmc_set_ios(host);
 
-			/* Wait for at least 1 ms according to spec */
-			mmc_delay(1);
+				/* Wait for at least 1 ms according to spec */
+				mmc_delay(1);
 
-			/*
-			 * Failure to switch is indicated by the card holding
-			 * dat[0:3] low
-			 */
-			if (!host->ops->card_busy)
-				pr_warning("%s: cannot verify signal voltage switch\n",
+				/*
+				 * Failure to switch is indicated by the card holding
+				 * dat[0:3] low
+				 */
+				if (host->ops->card_busy && host->ops->card_busy(host))
+					err = -EAGAIN;
+			}
+		}
+
+		if (err) {
+			/* Power cycle card */
+			pr_debug("%s: Signal voltage switch failed, "
+					"power cycling card \n",
 					mmc_hostname(host));
-			else if (host->ops->card_busy(host))
-				err = -EAGAIN;
+			mmc_power_cycle(host);
 		}
+
+		mmc_host_clk_release(host);
+
+	} else if (host->ops->start_signal_voltage_switch) {
+		mmc_host_clk_hold(host);
+		err = host->ops->start_signal_voltage_switch(host, signal_voltage);
 		mmc_host_clk_release(host);
 	}
 
+	if (!err)
+		host->ios.signal_voltage = signal_voltage;
+
 	return err;
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b56ef2..2d5033b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -129,7 +129,7 @@ struct mmc_host_ops {
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
 
-	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
+	int	(*start_signal_voltage_switch)(struct mmc_host *host, int signal_voltage);
 
 	/* Check if the card is pulling dat[0:3] low */
 	int	(*card_busy)(struct mmc_host *host);
-- 
1.7.0.4

