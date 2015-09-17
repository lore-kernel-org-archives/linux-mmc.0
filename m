From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 7/8] mmc: sd: set 4bit bus width after IO signal voltage switching
Date: Thu, 17 Sep 2015 13:50:53 +0800
Message-ID: <1442469054-23644-7-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:3406
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753077AbbIQGNH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 02:13:07 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

IO signal voltage switching is used for UHS speed mode. After the
voltage switching, the card is in UHS mode and it's needed to
set 4bit bus width before any data transfer command.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/core/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index e28ebf3..d861ee0 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -947,6 +947,15 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	/* If the signal voltage was switched to 1.8v for UHS mode,
+	 * it's needed to set 4bit bus width for card and host.
+	 */
+	if (host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		if (mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4))
+			goto free_card;
+		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
+	}
+
 	err = mmc_sd_setup_card(host, card, oldcard != NULL);
 	if (err)
 		goto free_card;
-- 
2.1.0.27.g96db324

