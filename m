From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
Date: Fri, 20 Mar 2015 11:00:20 -0700
Message-ID: <1426874420-25103-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33987 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbCTSAi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Mar 2015 14:00:38 -0400
Received: by igcau2 with SMTP id au2so423966igc.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2015 11:00:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

We've already seen that it causes failures if we try to send the
"SDMMC_CMD_UPD_CLK" command when power is off to the system.  Here's
another case where we were doing it: we were sending an
SDMMC_CMD_UPD_CLK to set the clock to 0 when the card was already
powered off and the clock was already at 0.  Let's avoid that command
and avoid problems.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..aeec698 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1172,8 +1172,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		break;
 	case MMC_POWER_OFF:
-		/* Turn clock off before power goes down */
-		dw_mci_setup_bus(slot, false);
+		/* Turn clock off before power goes down; only if powered */
+		if (slot->host->vqmmc_enabled)
+			dw_mci_setup_bus(slot, false);
 
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-- 
2.2.0.rc0.207.ga3a616c

