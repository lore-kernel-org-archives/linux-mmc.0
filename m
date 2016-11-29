From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH v3 1/1] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Tue, 29 Nov 2016 15:24:48 +0100
Message-ID: <1480429488-22289-2-git-send-email-thierry.escande@collabora.com>
References: <1480429488-22289-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44309 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757602AbcK2OZB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 09:25:01 -0500
In-Reply-To: <1480429488-22289-1-git-send-email-thierry.escande@collabora.com>
Content-Transfert-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: bhthompson@chromium.org, linux-mmc@vger.kernel.org

From: zhaojohn <john.zhao@intel.com>

Hynix eMMC devices sometimes take 50% longer to resume from sleep. This
occurs on Braswell based chromebook with acpi sdhci controller.

Based on a recommendation from Hynix engineers, this patch sends a
Power-Off Notification using mmc_poweroff_notify() before going to S3 to
have a resume time consistently within spec. No voltage regulator are
being cut through this notification but merely tells the eMMC firmware
that we're about to do so and get it to behave better on resume.

Signed-off-by: zhaojohn <john.zhao@intel.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/mmc/card/block.c | 8 ++++++++
 drivers/mmc/core/mmc.c   | 8 +++++++-
 include/linux/mmc/card.h | 2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 709a872..0066a66 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2573,6 +2573,14 @@ static const struct mmc_fixup blk_fixups[] =
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Hynix eMMC devices sometimes take 50% longer to resume from sleep.
+	 * Based on a recommendation from Hynix, send a Power-Off Notification
+	 * before going to S3 to restore a resume time consistently within spec.
+	 */
+	MMC_FIXUP("HBG4e\005", CID_MANFID_HYNIX, 0x014a, add_quirk_mmc,
+		  MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP),
+
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index df19777..774d478 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1941,8 +1941,14 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_can_poweroff_notify(host->card) &&
 		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_can_sleep(host->card)) {
+		if (host->card->quirks & MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
+			err = mmc_poweroff_notify(host->card, notify_type);
+			if (err)
+				goto out;
+		}
 		err = mmc_sleep(host);
+	}
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 73fad83..e4940f4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -281,6 +281,8 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP \
+				(1<<14)		/* Poweroff notification*/
 
 
 	unsigned int		erase_size;	/* erase size in sectors */
-- 
2.7.4

