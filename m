From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Mon, 31 Aug 2015 20:24:01 +0200
Message-ID: <1441045446-30858-4-git-send-email-heiko@sntech.de>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1441045446-30858-1-git-send-email-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

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
  If this is not supported by the supplying regulator we try to find
  a suitable voltage within the whole 2.7V-3.6V area of the spec.

* When setting the signal voltage to 1.8V or 1.2V we aim for that
  specific voltage instead of picking the lowest one in the range.

* We very purposely don't print errors in mmc_regulator_set_vqmmc().
  There are cases where the MMC core will try several different
  voltages and we don't want to pollute the logs.

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/mmc/core/core.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  7 +++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..9dc0b65 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1437,6 +1437,74 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
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
+		/* try to stay close to vmmc at first */
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
2.1.4
