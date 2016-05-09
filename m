From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3
Date: Mon,  9 May 2016 17:01:07 +0200
Message-ID: <1462806067-26724-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49309 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbcEIPBU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2016 11:01:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on a Salvator-X board with a Spectec SDW-823 WLAN card.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5309c73be1f04f..f750f9494410b0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -71,7 +71,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.bus_shift	= 2,
 };
 
-- 
2.7.0

