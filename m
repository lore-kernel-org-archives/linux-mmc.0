From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/7] mmc: core: Remove unnecessary retry mechanism at SDIO attach
Date: Mon, 16 Sep 2013 16:17:44 +0200
Message-ID: <1379341068-27097-4-git-send-email-ulf.hansson@linaro.org>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:62983 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3IPOSH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2013 10:18:07 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so3118089lab.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2013 07:18:06 -0700 (PDT)
In-Reply-To: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The retry and fallback mechanism when failing to switch to 1.8V
signaling voltage is handled by the SDIO card init function. Thus we
can remove the duplicated old code from the attach function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 15cbc418..26b1316 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1175,17 +1175,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 		host->ocr |= R4_18V_PRESENT;
 
 	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
-	if (err) {
-		if (err == -EAGAIN) {
-			/*
-			 * Retry initialization with S18R set to 0.
-			 */
-			host->ocr &= ~R4_18V_PRESENT;
-			err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
-		}
-		if (err)
-			goto err;
-	}
+	if (err)
+		goto err;
+
 	card = host->card;
 
 	/*
-- 
1.7.9.5

