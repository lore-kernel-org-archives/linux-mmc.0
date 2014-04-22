From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] linux-next: rsi: fix using of removed stuff from mmc
Date: Tue, 22 Apr 2014 15:57:28 +0900
Message-ID: <000c01cf5df8$1fecf810$5fc6e830$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12523 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaDVG5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Apr 2014 02:57:30 -0400
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'Fariya Fatima' <fariyaf@gmail.com>, "'John W. Linville'" <linville@tuxdriver.com>, 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

As commit 3957848(mmc: drop the speed mode of card's state) applies,
this change should be followed.

drivers/net/wireless/rsi/rsi_91x_sdio.c:288:20: error: 'MMC_STATE_HIGHSPEED' undeclared (first use in this function)
drivers/net/wireless/rsi/rsi_91x_sdio.c:299:4: error: implicit declaration of function 'mmc_card_set_highspeed' [-Werror=implicit-function-declaration]
drivers/net/wireless/rsi/rsi_91x_sdio.c:306:2: error: implicit declaration of function 'mmc_card_highspeed' [-Werror=implicit-function-declaration]

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 2e39d38..46e7af4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -285,7 +285,6 @@ static void rsi_reset_card(struct sdio_func *pfunction)
 		if (err) {
 			rsi_dbg(ERR_ZONE, "%s: CCCR speed reg read failed: %d\n",
 				__func__, err);
-			card->state &= ~MMC_STATE_HIGHSPEED;
 		} else {
 			err = rsi_cmd52writebyte(card,
 						 SDIO_CCCR_SPEED,
@@ -296,14 +295,13 @@ static void rsi_reset_card(struct sdio_func *pfunction)
 					__func__, err);
 				return;
 			}
-			mmc_card_set_highspeed(card);
 			host->ios.timing = MMC_TIMING_SD_HS;
 			host->ops->set_ios(host, &host->ios);
 		}
 	}
 
 	/* Set clock */
-	if (mmc_card_highspeed(card))
+	if (mmc_card_hs(card))
 		clock = 50000000;
 	else
 		clock = card->cis.max_dtr;
-- 
1.7.0.4


