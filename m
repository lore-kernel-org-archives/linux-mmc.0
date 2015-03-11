From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Wed, 11 Mar 2015 15:15:15 -0700
Message-ID: <1426112117-18220-2-git-send-email-dianders@chromium.org>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:38024 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbCKWPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2015 18:15:38 -0400
Received: by oiax69 with SMTP id x69so10689922oia.5
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2015 15:15:38 -0700 (PDT)
In-Reply-To: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, johan.rudholm@axis.com, adrian.hunter@intel.com, tim.kryger@gmail.com, andrew_gabbasov@mentor.com, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

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

* When setting the signal voltage to 1.8V or 1.2V we aim for that
  specific voltage instead of picking the lowest one in the range.

* We very purposely don't print errors in mmc_regulator_set_vqmmc().
  There are cases where the MMC core will try several different
  voltages and we don't want to pollute the logs.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes in v4: None
Changes in v3: None
Changes in v2:
- Now use existing regulator_set_voltage_tol() function.

 drivers/mmc/core/core.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  7 +++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 23f10f7..1d3b84e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1394,6 +1394,57 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
 
+static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
+						  int new_uV, int tol_uV)
+{
+	/*
+	 * Check if supported first to avoid errors since we may try several
+	 * signal levels during power up and don't want to show errors.
+	 */
+	if (!regulator_is_supported_voltage_tol(regulator, new_uV, tol_uV))
+		return -EINVAL;
+
+	return regulator_set_voltage_tol(regulator, new_uV, tol_uV);
+}
+
+/**
+ * mmc_regulator_set_vqmmc - Set VQMMC as per the ios
+ *
+ * For 3.3V signaling, we try to match VQMMC to VMMC as closely as possible.
+ * That will match the behavior of old boards where VQMMC and VMMC were supplied
+ * by the same supply.  The Bus Operating conditions for 3.3V signaling in the
+ * SD card spec also define VQMMC in terms of VMMC.
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
+	/* If no vqmmc supply then we can't change the voltage */
+	if (IS_ERR(mmc->supply.vqmmc))
+		return -EINVAL;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_120:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+			1200000, 100000);
+	case MMC_SIGNAL_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+			1800000, 100000);
+	case MMC_SIGNAL_VOLTAGE_330:
+		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
+			regulator_get_voltage(mmc->supply.vmmc), 300000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
+
 #endif /* CONFIG_REGULATOR */
 
 int mmc_regulator_get_supply(struct mmc_host *mmc)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c8cbe5..edd7d59 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -416,6 +416,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -428,6 +429,12 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
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
2.2.0.rc0.207.ga3a616c

