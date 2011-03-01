From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc/sdio: remember new card RCA when redetecting card
Date: Tue, 1 Mar 2011 14:41:04 +0100
Message-ID: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:40035 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168Ab1CANlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 08:41:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

During redetection of a SDIO card, a request for a new card RCA
was submitted to the card, but was then overwritten by the old RCA.
This caused the card to be deselected instead of selected when using
the incorrect RCA.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Reviewed-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/sdio.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 617e9ad..30d065d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -395,6 +395,13 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		if (err)
 			goto remove;
 
+		/*
+		 * Update oldcard with the new RCA received from the
+		 * SDIO device.
+		 */
+		if (oldcard)
+			oldcard->rca = card->rca;
+
 		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
 
-- 
1.7.3.2

