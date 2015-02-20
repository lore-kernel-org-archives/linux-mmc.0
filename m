From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] mmc: dw_mmc: Make sure we only adjust the clock when power is on
Date: Fri, 20 Feb 2015 10:57:18 -0800
Message-ID: <1424458639-23330-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:61388 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbBTS5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Feb 2015 13:57:34 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so5287872igd.4
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2015 10:57:33 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

It appears that we can confuse things if we try to turn on the MMC
clock when the power is off.  Adjust is so that we turn the clock on
(using dw_mci_setup_bus) after power is all the way on and we turn the
clock off before the power goes off.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..43fcae1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1101,12 +1101,6 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
 
-	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot, false);
-
-	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
-		slot->host->state = STATE_IDLE;
-
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc)) {
@@ -1133,8 +1127,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			else
 				slot->host->vqmmc_enabled = true;
 		}
+
+		/* Adjust clock / bus width after power is up */
+		dw_mci_setup_bus(slot, false);
+
 		break;
 	case MMC_POWER_OFF:
+		/* Turn clock off before power goes down */
+		dw_mci_setup_bus(slot, false);
+
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
@@ -1150,6 +1151,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	default:
 		break;
 	}
+
+	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
+		slot->host->state = STATE_IDLE;
 }
 
 static int dw_mci_card_busy(struct mmc_host *mmc)
-- 
2.2.0.rc0.207.ga3a616c

