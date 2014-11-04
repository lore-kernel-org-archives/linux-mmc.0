From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v2 2/4] mmc: core: group default initial state
Date: Tue,  4 Nov 2014 16:07:04 +0100
Message-ID: <1415113626-30187-3-git-send-email-johanru@axis.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49589 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbaKDPHY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 10:07:24 -0500
In-Reply-To: <1415113626-30187-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

mmc_do_hw_reset, mmc_power_up and mmc_power_off all set the same
group of initial values, simplify by sticking them together.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   49 +++++++++++++++++++++++------------------------
 drivers/mmc/core/core.h |    1 +
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5d215ee..2c39d26 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1088,6 +1088,24 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 	mmc_host_clk_release(host);
 }
 
+/*
+ * Set initial state after a power cycle or a hw_reset.
+ */
+void mmc_set_initial_state(struct mmc_host *host)
+{
+	if (mmc_host_is_spi(host)) {
+		host->ios.chip_select = MMC_CS_HIGH;
+		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
+	} else {
+		host->ios.chip_select = MMC_CS_DONTCARE;
+		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	}
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	host->ios.timing = MMC_TIMING_LEGACY;
+
+	mmc_set_ios(host);
+}
+
 /**
  * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
  * @vdd:	voltage (mV)
@@ -1534,15 +1552,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	mmc_host_clk_hold(host);
 
 	host->ios.vdd = fls(ocr) - 1;
-	if (mmc_host_is_spi(host))
-		host->ios.chip_select = MMC_CS_HIGH;
-	else
-		host->ios.chip_select = MMC_CS_DONTCARE;
-	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
 	host->ios.power_mode = MMC_POWER_UP;
-	host->ios.bus_width = MMC_BUS_WIDTH_1;
-	host->ios.timing = MMC_TIMING_LEGACY;
-	mmc_set_ios(host);
+	/* Set initial state and call mmc_set_ios */
+	mmc_set_initial_state(host);
 
 	/* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
 	if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
@@ -1582,14 +1594,9 @@ void mmc_power_off(struct mmc_host *host)
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
-	if (!mmc_host_is_spi(host)) {
-		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-		host->ios.chip_select = MMC_CS_DONTCARE;
-	}
 	host->ios.power_mode = MMC_POWER_OFF;
-	host->ios.bus_width = MMC_BUS_WIDTH_1;
-	host->ios.timing = MMC_TIMING_LEGACY;
-	mmc_set_ios(host);
+	/* Set initial state and call mmc_set_ios */
+	mmc_set_initial_state(host);
 
 	/*
 	 * Some configurations, such as the 802.11 SDIO card in the OLPC
@@ -2273,16 +2280,8 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 		}
 	}
 
-	if (mmc_host_is_spi(host)) {
-		host->ios.chip_select = MMC_CS_HIGH;
-		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
-	} else {
-		host->ios.chip_select = MMC_CS_DONTCARE;
-		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-	}
-	host->ios.bus_width = MMC_BUS_WIDTH_1;
-	host->ios.timing = MMC_TIMING_LEGACY;
-	mmc_set_ios(host);
+	/* Set initial state and call mmc_set_ios */
+	mmc_set_initial_state(host);
 
 	mmc_host_clk_release(host);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 443a584..d76597c 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -49,6 +49,7 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_up(struct mmc_host *host, u32 ocr);
 void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
+void mmc_set_initial_state(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
-- 
1.7.2.5

