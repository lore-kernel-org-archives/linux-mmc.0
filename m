From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 1/2] mmc: core: Factor out mmc_host_set_uhs_voltage()
Date: Mon, 25 Sep 2017 11:29:03 +0300
Message-ID: <1506328144-13666-2-git-send-email-adrian.hunter@intel.com>
References: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934112AbdIYIft (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Sep 2017 04:35:49 -0400
In-Reply-To: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Zhoujie Wu <zjwu@marvell.com>

Factor out mmc_host_set_uhs_voltage() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 38 ++++++++++++++++++++++++--------------
 drivers/mmc/core/core.h |  1 +
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index eaa6ece946b2..c287d297710a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1679,11 +1679,33 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 
 }
 
+int mmc_host_set_uhs_voltage(struct mmc_host *host)
+{
+	u32 clock;
+
+	/*
+	 * During a signal voltage level switch, the clock must be gated
+	 * for 5 ms according to the SD spec
+	 */
+	clock = host->ios.clock;
+	host->ios.clock = 0;
+	mmc_set_ios(host);
+
+	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
+		return -EAGAIN;
+
+	/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
+	mmc_delay(10);
+	host->ios.clock = clock;
+	mmc_set_ios(host);
+
+	return 0;
+}
+
 int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 {
 	struct mmc_command cmd = {};
 	int err = 0;
-	u32 clock;
 
 	/*
 	 * If we cannot switch voltages, return failure so the caller
@@ -1715,15 +1737,8 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 		err = -EAGAIN;
 		goto power_cycle;
 	}
-	/*
-	 * During a signal voltage level switch, the clock must be gated
-	 * for 5 ms according to the SD spec
-	 */
-	clock = host->ios.clock;
-	host->ios.clock = 0;
-	mmc_set_ios(host);
 
-	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180)) {
+	if (mmc_host_set_uhs_voltage(host)) {
 		/*
 		 * Voltages may not have been switched, but we've already
 		 * sent CMD11, so a power cycle is required anyway
@@ -1732,11 +1747,6 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 		goto power_cycle;
 	}
 
-	/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
-	mmc_delay(10);
-	host->ios.clock = clock;
-	mmc_set_ios(host);
-
 	/* Wait for at least 1 ms according to spec */
 	mmc_delay(1);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 92d157246271..8c5dd8d31400 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -51,6 +51,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr);
+int mmc_host_set_uhs_voltage(struct mmc_host *host);
 int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
-- 
1.9.1

