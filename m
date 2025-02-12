Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDC209F58
	for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366652; cv=none; b=V5o+auHXvsKBztOi1a4/x25UxzOm+rxIv8PveQEOuFmwY3Tpq3ebtxQ1aILdznzBPwanUK1zYKU2AjLVi3wK1TAtQmJ7Yf6q+CqaHa9Ln2ZFZF0+2auuyHOPr6NFgSa4NH+5tSVbGwHd7YqXAOH560I6QwsdAT68ZSxXzkJNb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366652; c=relaxed/simple;
	bh=HKMULcrdrUJmPr4lyJp31elFwGrcN5FmvI0c8Ie8/60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYThKIQajLdMyMNTR762+aobK+dbV40EFCpIl/Oi30PDOUOlG71KJOBzW6xiGrMs2Y2ddVbTpA8jOEAzs4N4aNs8meKgnvCoGlqrNwciMaavq3QFXQXKIaZi2gZCDcTYHTN0IT01wFdBq//rTLD/eCvACZrjNuZGaC/zMJie9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tiCik-0000P9-LJ; Wed, 12 Feb 2025 14:24:06 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiCik-000aoS-13;
	Wed, 12 Feb 2025 14:24:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiCik-00Gguj-0s;
	Wed, 12 Feb 2025 14:24:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] mmc: core: Handle undervoltage events and register regulator notifiers
Date: Wed, 12 Feb 2025 14:24:03 +0100
Message-Id: <20250212132403.3978175-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Extend the MMC core to handle undervoltage events by implementing
infrastructure to notify the MMC bus about voltage drops.

Background & Decision at LPC24:

This solution was proposed and refined during LPC24 in the talk
"Graceful Under Pressure: Prioritizing Shutdown to Protect Your Data in
Embedded Systems" which aimed to address how Linux should handle power
fluctuations in embedded devices to prevent data corruption or storage
damage.

At the time, multiple possible solutions were considered:

1. Triggering a system-wide suspend or shutdown: when undervoltage is
   detected, with device-specific prioritization to ensure critical
   components shut down first.
   - This approach was disliked by Greg Kroah-Hartman, as it introduced
     complexity and was not suitable for all use cases.

2. Notifying relevant devices through the regulator framework: to allow
   graceful per-device handling.
   - This approach was agreed upon as the most acceptable: by participants
     in the discussion, including Greg Kroah-Hartman, Mark Brown,
     and Rafael J. Wysocki.
   - This patch implements that decision by integrating undervoltage
     handling into the MMC subsystem.

This patch was tested on iMX8MP based system with SDHCI controller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/card.h      |  5 ++
 drivers/mmc/core/core.c      | 29 ++++++++++++
 drivers/mmc/core/core.h      |  2 +
 drivers/mmc/core/mmc.c       |  6 +++
 drivers/mmc/core/regulator.c | 90 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  4 ++
 6 files changed, 136 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 3205feb1e8ff..f8341e1657f0 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -24,6 +24,9 @@
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
 #define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
+#define MMC_CARD_UNDERVOLTAGE   (1<<7)		/* card is in undervoltage
+						 * condition
+						 */
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
@@ -32,6 +35,7 @@
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
 #define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
+#define mmc_card_in_undervoltage(c) ((c)->state & MMC_CARD_UNDERVOLTAGE)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -41,6 +45,7 @@
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
 #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
+#define mmc_card_set_undervoltage(c) ((c)->state |= MMC_CARD_UNDERVOLTAGE)
 
 /*
  * The world is not perfect and supplies us with broken mmc/sdio devices.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5241528f8b90..4b94017d2600 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1399,6 +1399,35 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 	mmc_power_up(host, ocr);
 }
 
+/**
+ * mmc_handle_undervoltage - Handle an undervoltage event on the MMC bus
+ * @host: The MMC host that detected the undervoltage condition
+ *
+ * This function is called when an undervoltage event is detected on one of
+ * the MMC regulators.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int mmc_handle_undervoltage(struct mmc_host *host)
+{
+	spin_lock(&host->lock);
+
+	if (!host->card || mmc_card_in_undervoltage(host->card)) {
+		spin_unlock(&host->lock);
+		return 0;
+	}
+
+	/* Mark the card as in undervoltage condition */
+	mmc_card_set_undervoltage(host->card);
+	spin_unlock(&host->lock);
+
+	/* Call bus-specific undervoltage handler if available */
+	if (host->bus_ops && host->bus_ops->handle_undervoltage)
+		return host->bus_ops->handle_undervoltage(host);
+
+	return 0;
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index fc9c066e6468..578c98e2f04d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -31,6 +31,7 @@ struct mmc_bus_ops {
 	int (*sw_reset)(struct mmc_host *);
 	bool (*cache_enabled)(struct mmc_host *);
 	int (*flush_cache)(struct mmc_host *);
+	int (*handle_undervoltage)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -59,6 +60,7 @@ void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 void mmc_set_initial_state(struct mmc_host *host);
 u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+int mmc_handle_undervoltage(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6a23be214543..c8b8e7a7b7d6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2273,6 +2273,11 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	return mmc_init_card(host, card->ocr, card);
 }
 
+static int _mmc_handle_undervoltage(struct mmc_host *host)
+{
+	return mmc_shutdown(host);
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -2285,6 +2290,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
+	.handle_undervoltage = _mmc_handle_undervoltage,
 };
 
 /*
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 3dae2e9b7978..0723afb2f9ed 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -262,6 +262,81 @@ static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 
 #endif /* CONFIG_REGULATOR */
 
+static int mmc_handle_regulator_event(struct mmc_host *mmc,
+				      const char *regulator_name,
+				      unsigned long event)
+{
+	struct device *dev = mmc_dev(mmc);
+	int ret;
+
+	switch (event) {
+	case REGULATOR_EVENT_UNDER_VOLTAGE:
+		ret = mmc_handle_undervoltage(mmc);
+		if (ret)
+			dev_err(dev, "Undervoltage handling failed: %pe\n",
+				ERR_PTR(ret));
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int mmc_vmmc_notifier_callback(struct notifier_block *nb,
+				      unsigned long event, void *data)
+{
+	struct mmc_supply *supply;
+	struct mmc_host *mmc;
+
+	supply = container_of(nb, struct mmc_supply, vmmc_nb);
+	mmc = container_of(supply, struct mmc_host, supply);
+
+	return mmc_handle_regulator_event(mmc, "vmmc", event);
+}
+
+static int mmc_vqmmc_notifier_callback(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	struct mmc_supply *supply;
+	struct mmc_host *mmc;
+
+	supply = container_of(nb, struct mmc_supply, vqmmc_nb);
+	mmc = container_of(supply, struct mmc_host, supply);
+
+	return mmc_handle_regulator_event(mmc, "vqmmc", event);
+}
+
+static int mmc_vqmmc2_notifier_callback(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct mmc_supply *supply;
+	struct mmc_host *mmc;
+
+	supply = container_of(nb, struct mmc_supply, vqmmc2_nb);
+	mmc = container_of(supply, struct mmc_host, supply);
+
+	return mmc_handle_regulator_event(mmc, "vqmmc2", event);
+}
+
+static void
+mmc_register_regulator_notifier(struct mmc_host *mmc,
+				struct regulator *regulator,
+				struct notifier_block *nb,
+				int (*callback)(struct notifier_block *,
+						unsigned long, void *),
+				const char *name)
+{
+	struct device *dev = mmc_dev(mmc);
+	int ret;
+
+	nb->notifier_call = callback;
+	ret = devm_regulator_register_notifier(regulator, nb);
+	if (ret)
+		dev_warn(dev, "Failed to register %s notifier: %pe\n", name,
+			 ERR_PTR(ret));
+}
+
 /**
  * mmc_regulator_get_supply - try to get VMMC and VQMMC regulators for a host
  * @mmc: the host to regulate
@@ -293,6 +368,11 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 			mmc->ocr_avail = ret;
 		else
 			dev_warn(dev, "Failed getting OCR mask: %d\n", ret);
+
+		mmc_register_regulator_notifier(mmc, mmc->supply.vmmc,
+						&mmc->supply.vmmc_nb,
+						mmc_vmmc_notifier_callback,
+						"vmmc");
 	}
 
 	if (IS_ERR(mmc->supply.vqmmc)) {
@@ -301,12 +381,22 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 					     "vqmmc regulator not available\n");
 
 		dev_dbg(dev, "No vqmmc regulator found\n");
+	} else {
+		mmc_register_regulator_notifier(mmc, mmc->supply.vqmmc,
+						&mmc->supply.vqmmc_nb,
+						mmc_vqmmc_notifier_callback,
+						"vqmmc");
 	}
 
 	if (IS_ERR(mmc->supply.vqmmc2)) {
 		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	} else {
+		mmc_register_regulator_notifier(mmc, mmc->supply.vqmmc2,
+						&mmc->supply.vqmmc2_nb,
+						mmc_vqmmc2_notifier_callback,
+						"vqmmc2");
 	}
 
 	return 0;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 68f09a955a90..7da053095c63 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -342,6 +342,10 @@ struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 	struct regulator *vqmmc2;	/* Optional supply for phy */
+
+	struct notifier_block vmmc_nb;		/* Notifier for vmmc */
+	struct notifier_block vqmmc_nb;		/* Notifier for vqmmc */
+	struct notifier_block vqmmc2_nb;	/* Notifier for vqmmc2 */
 };
 
 struct mmc_ctx {
-- 
2.39.5

