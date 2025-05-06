Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE0268FDA
	for <linux-mmc@vger.kernel.org>; Tue,  6 May 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525091; cv=none; b=KxQ+NEwGLQIAFPOYX0tPavRIWfcS6xpXuLvdOH8YDWhrT4rjNxK0mdUTiVHw7u6wh+rRi6oW+2WUU6K006gvqUnTmL7u0Qv57zmzGFdKisO4nhSP8uqH1WauPhU67QwfujG41ha077IlgBMVUp7pDZo8Do++gbDbEWlsOJrl+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525091; c=relaxed/simple;
	bh=h6F18a9yRJCnpkFBzA1kXOdGvY0tbDdOckV3r/y7RFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1r/03fk/ghygJ/LpJIWUoEwJ+sjW3FgKSHcUBxdlT0FfrxdsmMhCUYZ2hzDG+RcqJ1zPSewdZ9OyZDzfaVHgdWQBYYqE9gEcwTRviQGba4yTFZSWXcSxqIY9rG3CWid7QeGBglSdLbxp3GwUhUIGU7mC25Z5IO9EK2jNrFHqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExM-0005A1-Qw; Tue, 06 May 2025 11:51:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-001NB3-2m;
	Tue, 06 May 2025 11:51:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-009ObS-2T;
	Tue, 06 May 2025 11:51:19 +0200
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
Subject: [PATCH v5 3/4] mmc: core: add undervoltage handler for MMC/eMMC devices
Date: Tue,  6 May 2025 11:51:17 +0200
Message-Id: <20250506095118.2239459-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506095118.2239459-1-o.rempel@pengutronix.de>
References: <20250506095118.2239459-1-o.rempel@pengutronix.de>
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

Introduce `_mmc_handle_undervoltage()` to handle undervoltage events for
MMC/eMMC devices. This function performs a controlled suspend. After
completing the sequence, the card is marked as removed to prevent
further interactions, ensuring that no further commands are issued after
an emergency stop.

Implementation Details:
1. **Suspend the card in an emergency state**:
   - Call `__mmc_suspend()` with `MMC_POWEROFF_UNDERVOLTAGE`, which ensures:
     - The power-off notification uses `EXT_CSD_POWER_OFF_SHORT`.
     - Cache flushing is skipped to minimize time delays.
     - If power-off notify is unsupported, alternative methods like sleep
       or deselect are used to transition the card into a safe state.

2. **Mark the card as removed**:
   - This prevents further commands from being issued to the card after
     undervoltage shutdown, avoiding potential corruption.

To support this, introduce `__mmc_suspend()` as an internal helper that
omits `mmc_claim_host()/mmc_release_host()`, allowing it to be called
when the host is already claimed.

The caller of `_mmc_handle_undervoltage()` is responsible for invoking
`mmc_claim_host()` before calling this function and `mmc_release_host()`
afterward to ensure exclusive access to the host during the emergency
shutdown process.

Device Handling Considerations:
- **For eMMC storage**: The new undervoltage handler applies the correct
  power-down sequence using power-off notify or alternative methods.
- **For SD cards**: The current implementation does not handle undervoltage
  events for SD cards. Future extensions may be needed to implement proper
  handling.

Testing:
This implementation was tested on an iMX8MP-based system, verifying that
the undervoltage sequence correctly stops ongoing operations and
prevents further MMC transactions after the event. The board had
approximately 100ms of available power hold-up time. The Power Off
Notification was sent ~4ms after the board was detached from the power
supply, allowing sufficient time for the eMMC to handle the event
properly.

The testing was performed using a logic analyzer to monitor command
sequences and timing. While this method confirms that the expected
sequence was executed, it does not provide insights into the actual
internal behavior of the eMMC storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
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
 drivers/mmc/core/mmc.c | 76 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b67de2b62830..2ea5756a54e2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2120,7 +2120,7 @@ static int _mmc_flush_cache(struct mmc_host *host)
 	return err;
 }
 
-static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
+static int __mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 {
 	unsigned int notify_type = EXT_CSD_POWER_OFF_SHORT;
 	int err = 0;
@@ -2128,8 +2128,6 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	if (pm_type == MMC_POWEROFF_SHUTDOWN)
 		notify_type = EXT_CSD_POWER_OFF_LONG;
 
-	mmc_claim_host(host);
-
 	if (mmc_card_suspended(host->card))
 		goto out;
 
@@ -2156,7 +2154,17 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 		mmc_card_set_suspended(host->card);
 	}
 out:
+	return err;
+}
+
+static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
+{
+	int err;
+
+	mmc_claim_host(host);
+	err = __mmc_suspend(host, pm_type);
 	mmc_release_host(host);
+
 	return err;
 }
 
@@ -2219,6 +2227,13 @@ static int mmc_shutdown(struct mmc_host *host)
 {
 	int err = 0;
 
+	/*
+	 * In case of undervoltage, the card will be powered off by
+	 * _mmc_handle_undervoltage()
+	 */
+	if (host->undervoltage)
+		return 0;
+
 	/*
 	 * If the card remains suspended at this point and it was done by using
 	 * the sleep-cmd (CMD5), we may need to re-initialize it first, to allow
@@ -2309,6 +2324,60 @@ static int _mmc_hw_reset(struct mmc_host *host)
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
+ * 1. If no card is present, return immediately.
+ * 2. Perform an emergency suspend using EXT_CSD_POWER_OFF_SHORT if possible.
+ *    - If power-off notify is not supported, fallback mechanisms like sleep or
+ *      deselecting the card are attempted.
+ *    - Cache flushing is skipped to reduce execution time.
+ * 3. Mark the card as removed to prevent further interactions after
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
+	/* If there is no card attached, nothing to do */
+	if (!card)
+		return 0;
+
+	/*
+	 * Perform an emergency suspend to power off the eMMC quickly.
+	 * This ensures the device enters a safe state before power is lost.
+	 * We first attempt EXT_CSD_POWER_OFF_SHORT, but if power-off notify
+	 * is not supported, we fall back to sleep mode or deselecting the card.
+	 * Cache flushing is skipped to minimize delay.
+	 */
+	err = __mmc_suspend(host, MMC_POWEROFF_UNDERVOLTAGE);
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
@@ -2321,6 +2390,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
+	.handle_undervoltage = _mmc_handle_undervoltage,
 };
 
 /*
-- 
2.39.5

