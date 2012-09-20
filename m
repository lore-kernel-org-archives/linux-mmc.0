From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH 1/2] mmc: core: Proper signal voltage switch
Date: Thu, 20 Sep 2012 20:40:54 +0200
Message-ID: <1348166454-3210-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:33933 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754046Ab2ITTF3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 15:05:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
clock should be gated for 5 ms during the step. Failure by the card to
switch is indicated by dat0 being pulled low. The host should check for
this condition and power-cycle the card if failure is indicated.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/core/core.c  |   24 ++++++++++++++++++++++--
 include/linux/mmc/host.h |    3 +++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6612163..3779431 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1220,6 +1220,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
+	unsigned char old_voltage = host->ios.signal_voltage;
 
 	BUG_ON(!host);
 
@@ -1243,9 +1244,28 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
 	host->ios.signal_voltage = signal_voltage;
 
 	if (host->ops->start_signal_voltage_switch) {
-		mmc_host_clk_hold(host);
+		u32 clock = host->ios.clock;
+
+		host->ios.clock = 0;
+		mmc_set_ios(host);
 		err = host->ops->start_signal_voltage_switch(host, &host->ios);
-		mmc_host_clk_release(host);
+
+		/* Hold clock for at least 5 ms according to spec */
+		mmc_delay(5);
+		host->ios.clock = clock;
+		mmc_set_ios(host);
+
+		/* Wait for at least 1 ms until we check if card is ready */
+		mmc_delay(1);
+
+		/* Check busy */
+		if (cmd11 && host->ops->card_busy &&
+						host->ops->card_busy(host)) {
+			host->ios.signal_voltage = old_voltage;
+			host->ops->start_signal_voltage_switch(host,
+							&host->ios);
+			err = -EAGAIN;
+		}
 	}
 
 	return err;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d5d9bd4..b58641a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -131,6 +131,9 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 
+	/* Check if the card is pulling dat0 low */
+	int	(*card_busy)(struct mmc_host *host);
+
 	/* The tuning command opcode value is different for SD and eMMC cards */
 	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
-- 
1.7.10

