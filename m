From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH v6 1/5] mmc: sd: Simplify by using mmc_host_uhs
Date: Mon, 28 Jan 2013 15:08:24 +0100
Message-ID: <1359382108-958-2-git-send-email-johan.rudholm@stericsson.com>
References: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:57854 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756979Ab3A1OJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 09:09:34 -0500
In-Reply-To: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>, Johan Rudholm <johan.rudholm@stericsson.com>

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/core/sd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 74972c2..9373639 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -444,8 +444,7 @@ static void sd_update_bus_speed_mode(struct mmc_card *card)
 	 * If the host doesn't support any of the UHS-I modes, fallback on
 	 * default speed.
 	 */
-	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))) {
+	if (!mmc_host_uhs(card->host)) {
 		card->sd_bus_speed = 0;
 		return;
 	}
@@ -736,8 +735,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * If the host supports one of UHS-I modes, request the card
 	 * to switch to 1.8V signaling level.
 	 */
-	if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
+	if (mmc_host_uhs(host))
 		ocr |= SD_OCR_S18R;
 
 	/*
-- 
1.7.10

