Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88E1E9907
	for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037476; cv=none; b=ioVNsyRmFx6eYALlH0xbfIpEwe+zInIe03KZLV/G6JXXqdXSK/E2apYgu27zFTKZ7U1TBXLA8k5jIqBlzrWxSxqygXoErZZWpaBcpgl1DGlQNhKP665wrFlH1DoRAh/vHU5Xe9k9HTjl1++u126dS6QYROAaxr5XzWVDwZFojVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037476; c=relaxed/simple;
	bh=Pajo6n58YQjMYvbXjpmcT2nx5LNJ3QUBwJ7/2kJOKqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHSYa98Qu7LroRtTbjicicZqi3lpPy7lH/+ztQTBSYhRxc627Gph5vxOPAaNvL80v6GuD8ZqJurz8ZJS5XpFYaXRtWIY23wR1Bit3KeDLiImV7DfYJ2khWSZk+OjyvhddRUGNjq87TcIMidYbnlT9JpS2d2XVScwdoAKsucoYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EV-0004TP-1C; Thu, 20 Feb 2025 08:44:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-001tqO-1t;
	Thu, 20 Feb 2025 08:44:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-00CC1u-1g;
	Thu, 20 Feb 2025 08:44:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 1/6] mmc: core: Handle undervoltage events and register regulator notifiers
Date: Thu, 20 Feb 2025 08:44:24 +0100
Message-Id: <20250220074429.2906141-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220074429.2906141-1-o.rempel@pengutronix.de>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
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
Embedded Systems," which aimed to address how Linux should handle power
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
   - This approach was agreed upon as the most acceptable by participants
     in the discussion, including Greg Kroah-Hartman, Mark Brown,
     and Rafael J. Wysocki.
   - This patch implements that decision by integrating undervoltage
     handling into the MMC subsystem.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/core.c      |  20 ++++++
 drivers/mmc/core/core.h      |   2 +
 drivers/mmc/core/regulator.c | 115 +++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |   8 +++
 4 files changed, 145 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5241528f8b90..3ee6d83eb354 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1399,6 +1399,26 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
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
+	if (!host->bus_ops->handle_undervoltage)
+		return 0;
+
+	dev_warn(mmc_dev(host), "%s: Undervoltage detected, initiating emergency stop\n",
+		 mmc_hostname(host));
+
+	return host->bus_ops->handle_undervoltage(host);
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index fc9c066e6468..b77f053039ab 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -31,6 +31,7 @@ struct mmc_bus_ops {
 	int (*sw_reset)(struct mmc_host *);
 	bool (*cache_enabled)(struct mmc_host *);
 	int (*flush_cache)(struct mmc_host *);
+	int (*handle_undervoltage)(struct mmc_host *host);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -59,6 +60,7 @@ void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 void mmc_set_initial_state(struct mmc_host *host);
 u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+int mmc_handle_undervoltage(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 3dae2e9b7978..d3f3eb8ea3d7 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/log2.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 #include <linux/mmc/host.h>
 
@@ -262,6 +263,98 @@ static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 
 #endif /* CONFIG_REGULATOR */
 
+static void mmc_undervoltage_workfn(struct work_struct *work)
+{
+	struct mmc_supply *supply;
+	struct mmc_host *mmc;
+
+	supply = container_of(work, struct mmc_supply, uv_work);
+	mmc = container_of(supply, struct mmc_host, supply);
+
+	mmc_handle_undervoltage(mmc);
+}
+
+static int mmc_handle_regulator_event(struct mmc_host *mmc,
+				      const char *regulator_name,
+				      unsigned long event)
+{
+	switch (event) {
+	case REGULATOR_EVENT_UNDER_VOLTAGE:
+		if (mmc->undervoltage)
+			return NOTIFY_OK;
+
+		mmc->undervoltage = true;
+		queue_work(system_highpri_wq, &mmc->supply.uv_work);
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
+static void mmc_undervoltage_work_cleanup(void *data)
+{
+	struct mmc_supply *supply = data;
+
+	/* Ensure the work is canceled or flushed here */
+	cancel_work_sync(&supply->uv_work);
+}
+
 /**
  * mmc_regulator_get_supply - try to get VMMC and VQMMC regulators for a host
  * @mmc: the host to regulate
@@ -281,6 +374,13 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
 	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
+	INIT_WORK(&mmc->supply.uv_work, mmc_undervoltage_workfn);
+
+	ret = devm_add_action_or_reset(dev, mmc_undervoltage_work_cleanup,
+				       &mmc->supply);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add cleanup action\n");
+
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
 			return dev_err_probe(dev, -EPROBE_DEFER,
@@ -293,6 +393,11 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
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
@@ -301,12 +406,22 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
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
index 68f09a955a90..4e147ad82804 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/fault-inject.h>
 #include <linux/debugfs.h>
+#include <linux/workqueue.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
@@ -342,6 +343,12 @@ struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 	struct regulator *vqmmc2;	/* Optional supply for phy */
+
+	struct notifier_block vmmc_nb;		/* Notifier for vmmc */
+	struct notifier_block vqmmc_nb;		/* Notifier for vqmmc */
+	struct notifier_block vqmmc2_nb;	/* Notifier for vqmmc2 */
+
+	struct work_struct uv_work;		/* Undervoltage work */
 };
 
 struct mmc_ctx {
@@ -493,6 +500,7 @@ struct mmc_host {
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
+	unsigned int		undervoltage:1;	 /* Undervoltage state */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.39.5

