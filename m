From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH 1/3] mmc: core: Add mmc_power_cycle
Date: Fri, 7 Dec 2012 17:19:34 +0100
Message-ID: <1354897176-15307-2-git-send-email-johan.rudholm@stericsson.com>
References: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:56583 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422695Ab2LGQUu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 11:20:50 -0500
In-Reply-To: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Johan Rudholm <johan.rudholm@stericsson.com>

Add mmc_power_cycle which can be used to power cycle for instance
SD-cards.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/core/core.c |    8 ++++++++
 drivers/mmc/core/core.h |    1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..285f064 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1372,6 +1372,14 @@ void mmc_power_off(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
+void mmc_power_cycle(struct mmc_host *host)
+{
+	mmc_power_off(host);
+	/* Wait at least 1 ms according to SD spec */
+	mmc_delay(1);
+	mmc_power_up(host);
+}
+
 /*
  * Cleanup when the last reference to the bus operator is dropped.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..4a90067 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
+void mmc_power_cycle(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
-- 
1.7.10

