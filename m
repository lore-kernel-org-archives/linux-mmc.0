From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2] mmc: core: Introduce MMC_CAP2_NO_SDIO cap
Date: Wed, 25 Nov 2015 15:39:51 +0100
Message-ID: <1448462391-22480-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34830 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbKYOj7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 09:39:59 -0500
Received: by wmuu63 with SMTP id u63so140690156wmu.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 06:39:58 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, drake@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

This patch introduce a new MMC_CAP2_NO_SDIO cap used to tell the mmc
core to not send SDIO specific commands.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---

Drivers fix will follow.

Changelog:

* v2:
   - moved check from __mmc_start_request to mmc_rescan_try_freq

---
 drivers/mmc/core/core.c  | 11 ++++++++---
 include/linux/mmc/host.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..8a4e0d2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2476,15 +2476,20 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	 * sdio_reset sends CMD52 to reset card.  Since we do not know
 	 * if the card is being re-initialized, just send it.  CMD52
 	 * should be ignored by SD/eMMC cards.
+	 * Skip it if we already know that we do not support SDIO commands
 	 */
-	sdio_reset(host);
+	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
+		sdio_reset(host);
+
 	mmc_go_idle(host);
 
 	mmc_send_if_cond(host, host->ocr_avail);
 
 	/* Order's important: probe SDIO, then SD, then MMC */
-	if (!mmc_attach_sdio(host))
-		return 0;
+	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
+		if (!mmc_attach_sdio(host))
+			return 0;
+
 	if (!mmc_attach_sd(host))
 		return 0;
 	if (!mmc_attach_mmc(host))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe..cf6d0bb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -289,6 +289,7 @@ struct mmc_host {
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
+#define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.5.0

