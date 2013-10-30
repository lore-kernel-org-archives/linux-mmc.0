From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 6/6] mmc: core: mmc DDR mode should not depend on UHS_DDR50
Date: Wed, 30 Oct 2013 22:09:53 +0800
Message-ID: <1383142193-24950-7-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:43429
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754566Ab3J3O3J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:29:09 -0400
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The MMC_CAP_UHS_DDR50 must work on 1.8v.
However, the eMMC DDR mode can work on either 1.8v or 3.3v and
should not depend on UHS_DDR50.
So get rid of this limitation to let controller without 1.8v
signal voltage support can also work for eMMC DDR mode if it claims.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/core/mmc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f631f5a..98e9eb0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1119,14 +1119,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (mmc_card_highspeed(card)) {
 		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
-			&& ((host->caps & (MMC_CAP_1_8V_DDR |
-			     MMC_CAP_UHS_DDR50))
-				== (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
+			&& (host->caps & MMC_CAP_1_8V_DDR))
 				ddr = MMC_1_8V_DDR_MODE;
 		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
-			&& ((host->caps & (MMC_CAP_1_2V_DDR |
-			     MMC_CAP_UHS_DDR50))
-				== (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
+			&& (host->caps & MMC_CAP_1_2V_DDR))
 				ddr = MMC_1_2V_DDR_MODE;
 	}
 
-- 
1.7.2.rc3


