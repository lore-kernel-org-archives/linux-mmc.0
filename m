From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH] mmc: core: Fix power sequence ordering in mmc_power_up
Date: Wed,  1 Mar 2017 09:59:02 +0100
Message-ID: <20170301085902.7388-1-romain.perier@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Currently, mmc_power_up calls the pre_power_on callback, enables the
power supply of the mmc by calling mmc_set_ios() and then call
post_power_on. WiFi chipsets like the AP6335 require a specific power
sequence ordering before being used. You must enable the power supply
and wait until it reaches its minimum voltage, gate the clock and wait
at least two cycles and then assert the reset line.

This commit prevents regulators to be enabled in the middle of or after
the power sequencing. We this fix, mmc_set_ios is first call, the
underlying regulators are enabled, then pre_power_on and post_power_on
are called, so clock and reset line are enabled in the right order,
after the regulator.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/mmc/core/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1076b9d..36df24f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1798,8 +1798,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
-	mmc_pwrseq_pre_power_on(host);
-
 	host->ios.vdd = fls(ocr) - 1;
 	host->ios.power_mode = MMC_POWER_UP;
 	/* Set initial state and call mmc_set_ios */
@@ -1819,13 +1817,20 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
-	mmc_pwrseq_post_power_on(host);
-
 	host->ios.clock = host->f_init;
 
 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);
 
+	mmc_pwrseq_pre_power_on(host);
+
+	/*
+	 * This delay should be sufficient to wait at least two cycles of clock
+	 * gated by pre_power_on
+	 */
+	mmc_delay(1);
+	mmc_pwrseq_post_power_on(host);
+
 	/*
 	 * This delay must be at least 74 clock sizes, or 1 ms, or the
 	 * time required to reach a stable voltage.
-- 
2.9.3
