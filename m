Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C822652D
	for <linux-mmc@vger.kernel.org>; Mon, 10 Mar 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602156; cv=none; b=KBIzukNNi17cdbVTYb/1oUGGVtN/brJN8ct7t8n9yD27ZUOA6q6FD6ZvIzkXHAV6dMhw05fiBEKJDY+fX0mBeVj8Bnp/fw1Q6UfacjGe4N8bcbKBQf+fqtSWCTkEXEGQstw4N8oWh//8F6q4ipVKLLIXaFVNq3da0M/AgfMYcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602156; c=relaxed/simple;
	bh=V0BmAlezaifWkWRBR10sLee8q7PfiqozdmdhOLEOZeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4YLVjXeIm5lK1/0uTZz/Omx/UjUnPq3SVSSFcTHVZva/NOoThSk0MUPZjqLRUseveXMmmixhsq7Zy6PTRutnHyOC3CoGtW1KABRthzF+7TrekKIAcirZQwhiG7naT6lwJDugMV3yvkNtk9+YOvZtmTDOEsLX1MZIrwvD9VgLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1traHH-00027J-Sy; Mon, 10 Mar 2025 11:22:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traHG-004yr8-35;
	Mon, 10 Mar 2025 11:22:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1traHG-001baP-2r;
	Mon, 10 Mar 2025 11:22:30 +0100
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
Subject: [PATCH v4 3/4] mmc: core: add undervoltage handler for MMC/eMMC devices
Date: Mon, 10 Mar 2025 11:22:28 +0100
Message-Id: <20250310102229.381887-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310102229.381887-1-o.rempel@pengutronix.de>
References: <20250310102229.381887-1-o.rempel@pengutronix.de>
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
   - Call `__mmc_suspend()` with `is_undervoltage = true`, which ensures:
     - The power-off notification uses `EXT_CSD_POWER_OFF_SHORT`.
     - Cache flushing is skipped to minimize time delays.
     - If power-off notify is unsupported, alternative methods like sleep
       or deselect are used to transition the card into a safe state.

2. **Mark the card as removed**:
   - This prevents further commands from being issued to the card after
     undervoltage shutdown, avoiding potential corruption.

To support this, introduce `__mmc_suspend()` and `__mmc_resume()` as
internal  helpers that omit `mmc_claim_host()/mmc_release_host()`,
allowing them to be  called when the host is already claimed.

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
the  undervoltage sequence correctly stops ongoing operations and
prevents further  MMC transactions after the event. The board had
approximately 100ms of available  power hold-up time. The Power Off
Notification was sent ~4ms after the board  was detached from the power
supply, allowing sufficient time for the eMMC to  handle the event
properly.

The testing was performed using a logic analyzer to monitor command
sequences and timing. While this method confirms that the expected
sequence was executed, it does not provide insights into the actual
internal behavior of the eMMC storage.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- Drop HPI step.
changes v3:
- reword commit message.
- add comments in the code
- do not try to resume sleeping device
---
 drivers/mmc/core/mmc.c | 103 +++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9270bde445ad..9b801b997a21 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
 	return err;
 }
 
-static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
-			bool is_undervoltage)
+static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
+			 bool is_undervoltage)
 {
 	unsigned int notify_type;
 	int err = 0;
@@ -2116,8 +2116,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
 	else
 		notify_type = EXT_CSD_POWER_OFF_LONG;
 
-	mmc_claim_host(host);
-
 	if (mmc_card_suspended(host->card))
 		goto out;
 
@@ -2145,7 +2143,18 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
 		mmc_card_set_suspended(host->card);
 	}
 out:
+	return err;
+}
+
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
+			bool is_undervoltage)
+{
+	int err;
+
+	mmc_claim_host(host);
+	err = __mmc_suspend(host, is_suspend, is_undervoltage);
 	mmc_release_host(host);
+
 	return err;
 }
 
@@ -2165,6 +2174,20 @@ static int mmc_suspend(struct mmc_host *host)
 	return err;
 }
 
+static int __mmc_resume(struct mmc_host *host)
+{
+	int err;
+
+	if (!mmc_card_suspended(host->card))
+		return 0;
+
+	mmc_power_up(host, host->card->ocr);
+	err = mmc_init_card(host, host->card->ocr, host->card);
+	mmc_card_clr_suspended(host->card);
+
+	return err;
+}
+
 /*
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
@@ -2174,16 +2197,9 @@ static int _mmc_resume(struct mmc_host *host)
 	int err = 0;
 
 	mmc_claim_host(host);
-
-	if (!mmc_card_suspended(host->card))
-		goto out;
-
-	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
-	mmc_card_clr_suspended(host->card);
-
-out:
+	err = __mmc_resume(host);
 	mmc_release_host(host);
+
 	return err;
 }
 
@@ -2194,6 +2210,13 @@ static int mmc_shutdown(struct mmc_host *host)
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
 	 * In a specific case for poweroff notify, we need to resume the card
 	 * before we can shutdown it properly.
@@ -2285,6 +2308,59 @@ static int _mmc_hw_reset(struct mmc_host *host)
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
+	int err = 0;
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
+	err = __mmc_suspend(host, false, true);
+	if (err)
+		pr_err("%s: error %d doing suspend\n", mmc_hostname(host), err);
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
@@ -2297,6 +2373,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
+	.handle_undervoltage = _mmc_handle_undervoltage,
 };
 
 /*
-- 
2.39.5

