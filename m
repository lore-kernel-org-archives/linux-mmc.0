From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFT PATCH] mmc: sd: try to enable UHS mode w/o power cycle from S3
Date: Tue, 29 Aug 2017 11:24:59 +0800
Message-ID: <1503977099-132887-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45111 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdH2DZO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 23:25:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

CMD0 couldn't put the card back to 3.3v if can't do power
cycle for cards. The card is already in SDR12 then, so still
try to enable UHS mode.

Pleas note that, if the platform use a hardware fixed
sd power, you should still include a regulator-fixed
regulator with always-on property there. So mmc core
could handle this as well. Otherwise you shouldn't
expect UHS to work for that case.

Just compile only, please have a look and test.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/card.h            | 18 ++++++++++++++++++
 drivers/mmc/core/core.c            |  8 ++++++++
 drivers/mmc/core/sd.c              | 22 ++++++++++++++++++++--
 drivers/mmc/core/sd.h              |  3 ++-
 drivers/mmc/core/sdio.c            |  2 +-
 drivers/regulator/core.c           | 14 ++++++++++++++
 include/linux/mmc/host.h           |  1 +
 include/linux/regulator/consumer.h |  6 ++++++
 8 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index f06cd91..2c3264c 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -218,4 +218,22 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_HPI;
 }
 
+static bool mmc_card_support_uhs(struct mmc_card *card)
+{
+	if (WARN_ON(!card))
+		return false;
+
+	switch (card->sd_bus_speed) {
+	case UHS_SDR104_BUS_SPEED:
+	case UHS_DDR50_BUS_SPEED:
+	case UHS_SDR50_BUS_SPEED:
+	case UHS_SDR25_BUS_SPEED:
+	case UHS_SDR12_BUS_SPEED:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(mmc_card_support_uhs);
+
 #endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2643126..6b5c6c5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1424,6 +1424,14 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
 
+bool mmc_regulator_can_power_off(struct regulator *supply)
+{
+	if (!IS_ERR(supply))
+		return regulator_is_always_on(supply);
+	return false;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_can_power_off);
+
 /*
  * Mask off any voltages we don't support and select
  * the lowest voltage
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index a1b0aa1..137a49c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -721,7 +721,8 @@ struct device_type sd_type = {
 /*
  * Fetch CID from card.
  */
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
+int mmc_sd_get_cid(struct mmc_host *host, struct mmc_card *card,
+				   u32 ocr, u32 *cid, u32 *rocr)
 {
 	int err;
 	u32 max_current;
@@ -773,6 +774,21 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		return err;
 
 	/*
+	 * Per SD physical specification version 4.10, section
+	 * 3.9.4 UHS-I Bus Speed Mode Selection Sequence, once
+	 * the signal voltage is switched to 1V8, the card continues
+	 * 1.8V signaling regardless of CMD0. Power cycle resets the
+	 * signal voltage to 3.3V. As a fact that some vmmc is always
+	 * on so the card would still work with SDR12 after CMD0. So
+	 * let's attempt to enable enable UHS mode if vmmc can't be
+	 * powered off.
+	 */
+	if (card && mmc_card_support_uhs(card) && mmc_host_uhs(host) &&
+	    !mmc_regulator_can_power_off(host->supply.vmmc)) {
+			*rocr |= SD_ROCR_S18A;
+			goto done;
+	}
+	/*
 	 * In case CCS and S18A in the response is set, start Signal Voltage
 	 * Switch procedure. SPI mode doesn't support CMD11.
 	 */
@@ -788,6 +804,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		}
 	}
 
+done:
 	err = mmc_send_cid(host, cid);
 	return err;
 }
@@ -924,7 +941,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 	WARN_ON(!host->claimed);
 
-	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
+	err = mmc_sd_get_cid(host, oldcard, ocr, cid, &rocr);
 	if (err)
 		return err;
 
@@ -995,6 +1012,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		if (err)
 			goto free_card;
 	} else {
+
 		/*
 		 * Attempt to change to high-speed (if supported)
 		 */
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 1ada980..9cd2482 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -8,7 +8,8 @@
 struct mmc_host;
 struct mmc_card;
 
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
+int mmc_sd_get_cid(struct mmc_host *host, struct mmc_card *card,
+		   u32 ocr, u32 *cid, u32 *rocr);
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cc43687..08e82fe 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -608,7 +608,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if ((rocr & R4_MEMORY_PRESENT) &&
-	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
+	    mmc_sd_get_cid(host, NULL, ocr & rocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e567fa5..edea93b0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2522,6 +2522,20 @@ int regulator_is_enabled(struct regulator *regulator)
 EXPORT_SYMBOL_GPL(regulator_is_enabled);
 
 /**
+ * regulator_is_always_on - is the regulator output always enabled
+ * @regulator: regulator source
+ *
+ * Returns positive if the regulator driver backing the source/client
+ * has requested that the device be always on, zero if it isn't.
+ *
+ */
+inline int regulator_is_always_on(struct regulator *regulator)
+{
+	return (regulator->always_on) ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(regulator_is_always_on);
+
+/**
  * regulator_count_voltages - count regulator_list_voltage() selectors
  * @regulator: regulator source
  *
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ebd1ceb..2f1206b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -462,6 +462,7 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 
 u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+bool mmc_regulator_can_power_off(struct regulator *supply);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index df176d7..46126e3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -226,6 +226,7 @@ void devm_regulator_bulk_unregister_supply_alias(struct device *dev,
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
+int regulator_is_always_on(struct regulator *regulator);
 int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int __must_check regulator_bulk_get(struct device *dev, int num_consumers,
@@ -418,6 +419,11 @@ static inline int regulator_is_enabled(struct regulator *regulator)
 	return 1;
 }
 
+static inline int regulator_is_always_on(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_get(struct device *dev,
 				     int num_consumers,
 				     struct regulator_bulk_data *consumers)
-- 
1.9.1


