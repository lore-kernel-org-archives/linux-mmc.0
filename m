Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD542FE06B
	for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176831; cv=none; b=gjdSpt4XeLp0od+vXkvmKfIKNAZuY6cV3sNe1EOqn/KwMQ8Z+KUliZlQ++fcWspFBKH+wAngnPe2n2dMMMf360E1+jbmtaKRe5Wirq4pA55S6jMNiWxpNWMvZLjrRbbRnESLNI6ZRM9YtgXI7bDdS3TjsKtwI34y8C1zmF80nwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176831; c=relaxed/simple;
	bh=IycRZzbtPjcoBJRiQajt7RaNrbxPeE1qygAH2mM/dr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAfQyP2BW7ujOl+dbu+xrraJVnG8xtE84c+yJYUgFphtdccpiDxGOlFEpQr9JNnT6ZgyA/ExubsfwHANFuLXDREL2FA3Y0F/9WDZWoeoZI4VC81tEYY09JcbKuhKKn63opyMeKLuwgBEalp+BJRr1rrAoK2vOASeG7sLDoUSc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1umXff-0006JE-0T; Thu, 14 Aug 2025 15:07:07 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umXfe-000GHR-0G;
	Thu, 14 Aug 2025 15:07:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umXfe-001Mpw-01;
	Thu, 14 Aug 2025 15:07:06 +0200
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
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v8 2/2] mmc: core: add undervoltage handler for MMC/eMMC devices
Date: Thu, 14 Aug 2025 15:07:05 +0200
Message-Id: <20250814130705.326073-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814130705.326073-1-o.rempel@pengutronix.de>
References: <20250814130705.326073-1-o.rempel@pengutronix.de>
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

Add infrastructure to handle regulator undervoltage events for MMC/eMMC
cards. When an undervoltage is detected, the new handler performs a
controlled emergency suspend using a short power-off notification,
skipping the cache flush to maximize the chance of a safe shutdown.
After the operation, the card is marked as removed to prevent further
I/O and possible data corruption.

This is implemented by introducing MMC_POWEROFF_UNDERVOLTAGE to the
mmc_poweroff_type enum and refactoring the suspend logic into an
internal __mmc_suspend() helper that allows the caller to skip the cache
flush if required. The undervoltage handler is registered as a bus
operation and invoked from the core undervoltage path.

If power-off notification is not supported by the card, the handler
falls back to sleep or deselecting the card.

Additionally, update the shutdown path to avoid redundant shutdown
steps if the card is already removed

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v7:
- Squash undervoltage suspend preparation and handler into one patch.
- Use mmc_card_removed() in shutdown path instead of host->undervoltage.
- Remove redundant card presence check in undervoltage handler.
changes v6:
- Refactor suspend logic: move cache flush skipping during undervoltage
  to a separate, preceding commit.
- update commit message
changes v5:
- Rebased on top of patch introducing enum mmc_poweroff_type
- Updated call to __mmc_suspend() to use MMC_POWEROFF_UNDERVOLTAGE
- Dropped __mmc_resume() helper, as it is no longer needed
- Updated commit message to reflect API change and code removal
changes v4:
- Drop HPI step.
changes v3:
- reword commit message.
- add comments in the code
- do not try to resume sleeping device
---
 drivers/mmc/core/mmc.c | 70 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7dc0a9339c5e..03b9a5acafd1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -36,6 +36,7 @@
 enum mmc_poweroff_type {
 	MMC_POWEROFF_SUSPEND,
 	MMC_POWEROFF_SHUTDOWN,
+	MMC_POWEROFF_UNDERVOLTAGE,
 	MMC_POWEROFF_UNBIND,
 };
 
@@ -2132,9 +2133,15 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	if (mmc_card_suspended(host->card))
 		goto out;
 
-	err = _mmc_flush_cache(host);
-	if (err)
-		goto out;
+	/*
+	 * For the undervoltage case, we care more about device integrity.
+	 * Avoid cache flush and notify the device to power off quickly.
+	 */
+	if (pm_type != MMC_POWEROFF_UNDERVOLTAGE) {
+		err = _mmc_flush_cache(host);
+		if (err)
+			goto out;
+	}
 
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
@@ -2212,6 +2219,13 @@ static int mmc_shutdown(struct mmc_host *host)
 {
 	int err = 0;
 
+	/*
+	 * In case of undervoltage, the card will be powered off (removed) by
+	 * _mmc_handle_undervoltage()
+	 */
+	if (!host->card || mmc_card_removed(host->card))
+		return 0;
+
 	/*
 	 * If the card remains suspended at this point and it was done by using
 	 * the sleep-cmd (CMD5), we may need to re-initialize it first, to allow
@@ -2302,6 +2316,55 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	return mmc_init_card(host, card->ocr, card);
 }
 
+/**
+ * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
+ * @host: MMC host structure
+ *
+ * This function is triggered when an undervoltage condition is detected.
+ * It attempts to transition the device into a low-power or safe state to
+ * prevent data corruption.
+ *
+ * Steps performed:
+ * - Perform an emergency suspend using EXT_CSD_POWER_OFF_SHORT if possible.
+ *    - If power-off notify is not supported, fallback mechanisms like sleep or
+ *      deselecting the card are attempted.
+ *    - Cache flushing is skipped to reduce execution time.
+ * - Mark the card as removed to prevent further interactions after
+ *    undervoltage.
+ *
+ * Note: This function does not handle host claiming or releasing. The caller
+ *	 must ensure that the host is properly claimed before calling this
+ *	 function and released afterward.
+ *
+ * Returns: 0 on success, or a negative error code if any step fails.
+ */
+static int _mmc_handle_undervoltage(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	int err;
+
+	/*
+	 * Perform an emergency suspend to power off the eMMC quickly.
+	 * This ensures the device enters a safe state before power is lost.
+	 * We first attempt EXT_CSD_POWER_OFF_SHORT, but if power-off notify
+	 * is not supported, we fall back to sleep mode or deselecting the card.
+	 * Cache flushing is skipped to minimize delay.
+	 */
+	err = _mmc_suspend(host, MMC_POWEROFF_UNDERVOLTAGE);
+	if (err)
+		pr_err("%s: undervoltage suspend failed: %pe\n",
+		       mmc_hostname(host), ERR_PTR(err));
+
+	/*
+	 * Mark the card as removed to prevent further operations.
+	 * This ensures the system does not attempt to access the device
+	 * after an undervoltage event, avoiding potential corruption.
+	 */
+	mmc_card_set_removed(card);
+
+	return err;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -2314,6 +2377,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
+	.handle_undervoltage = _mmc_handle_undervoltage,
 };
 
 /*
-- 
2.39.5

