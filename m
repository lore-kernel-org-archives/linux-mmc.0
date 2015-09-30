From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Wed, 30 Sep 2015 16:07:39 +0200
Message-ID: <1443622064-14362-4-git-send-email-heiko@sntech.de>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51085 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbbI3OH6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2015 10:07:58 -0400
In-Reply-To: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

From: Douglas Anderson <dianders@chromium.org>

This adds logic to the MMC core to set VQMMC.  This is expected to be
called by MMC drivers like dw_mmc as part of (or instead of) their
start_signal_voltage_switch() callback.

A few notes:

* When setting the signal voltage to 3.3V we do our best to make VQMMC
  and VMMC match.  It's been reported that this makes some old cards
  happy since they were tested back in the day before UHS when VQMMC
  and VMMC were provided by the same regulator.  A nice side effect of
  this is that we don't end up on the hairy edge of VQMMC (2.7V),
  which some EEs claim is a little too close to the minimum for
  comfort.
  This is done in two steps. At first we try to find a VQMMC within
  a 0.3V tolerance of VMMC and if this is not supported by the
  supplying regulator we try to find a suitable voltage within the
  whole 2.7V-3.6V area of the spec.

* The two step approach is currently necessary, as the used
  regulator_set_voltage_triplet(min, target, max) uses a simple
  implementation that just tries two basic steps:
	regulator_set_voltage(target, max);
	regulator_set_voltage(min, target);
  So with only one step with 2.7-3.6V borders, if a suitable voltage
  is a bit below VMMC, we would directly get the lowest 2.7V
  which some boards (like Rockchips) don't like at all.

* When setting the signal voltage to 1.8V or 1.2V we aim for that
  specific voltage instead of picking the lowest one in the range.

* We very purposely don't print errors in mmc_regulator_set_vqmmc().
  There are cases where the MMC core will try several different
  voltages and we don't want to pollute the logs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/core/core.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  7 +++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..363cc98 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1437,6 +1437,80 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
 
+static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
+						  int min_uV, int target_uV,
+						  int max_uV)
+{
+	/*
+	 * Check if supported first to avoid errors since we may try several
+	 * signal levels during power up and don't want to show errors.
+	 */
+	if (!regulator_is_supported_voltage(regulator, min_uV, max_uV))
+		return -EINVAL;
+
+	return regulator_set_voltage_triplet(regulator, min_uV, target_uV,
+					     max_uV);
+}
+
+/**
+ * mmc_regulator_set_vqmmc - Set VQMMC as per the ios
+ *
+ * For 3.3V signaling, we try to match VQMMC to VMMC as closely as possible.
+ * That will match the behavior of old boards where VQMMC and VMMC were supplied
+ * by the same supply.  The Bus Operating conditions for 3.3V signaling in the
+ * SD card spec also define VQMMC in terms of VMMC.
+ * If this is not possible we'll try the full 2.7-3.6V of the spec.
+ *
+ * For 1.2V and 1.8V signaling we'll try to get as close as possible to the
+ * requested voltage.  This is definitely a good idea for UHS where there's a
+ * separate regulator on the card that's trying to make 1.8V and it's best if
+ * we match.
+ *
+ * This function is expected to be used by a controller's
+ * start_signal_voltage_switch() function.
+ */
+int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int volt, min_uV, max_uV;
+
+	/* If no vqmmc supply then we can't change the voltage */
+	if (IS_ERR(mmc->supply.vqmmc))
+		return -EINVAL;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_120:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+						1100000, 1200000, 1300000);
+	case MMC_SIGNAL_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+						1700000, 1800000, 1950000);
+	case MMC_SIGNAL_VOLTAGE_330:
+		volt = regulator_get_voltage(mmc->supply.vmmc);
+		if (volt < 0)
+			return volt;
+
+		min_uV = max(volt - 300000, 2700000);
+		max_uV = min(volt + 300000, 3600000);
+
+		/*
+		 * Due to a limitation in the current implementation of
+		 * regulator_set_voltage_triplet() which is taking the lowest
+		 * voltage possible if below the target, search for a suitable
+		 * voltage in two steps and try to stay close to vmmc
+		 * with a 0.3V tolerance at first.
+		 */
+		if (!mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+						min_uV, volt, max_uV))
+			return 0;
+
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+						2700000, volt, 3600000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
+
 #endif /* CONFIG_REGULATOR */
 
 int mmc_regulator_get_supply(struct mmc_host *mmc)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 83b81fd..a2a78eb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -423,6 +423,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -435,6 +436,12 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 {
 	return 0;
 }
+
+static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
+					  struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.5.1

