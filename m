From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] mmc: bcm2835: Don't overwrite max frequency unconditionally
Date: Mon, 12 Feb 2018 21:13:44 +0100
Message-ID: <1518466424-30229-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbeBLUOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Feb 2018 15:14:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Eric Anholt <eric@anholt.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>, Stefan Wahren <stefan.wahren@i2se.com>

From: Phil Elwell <phil@raspberrypi.org>

The optional DT parameter max-frequency could init the max bus frequency.
So take care of this, before setting the max bus frequency.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 229dc18..768972a 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1265,7 +1265,8 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 	char pio_limit_string[20];
 	int ret;
 
-	mmc->f_max = host->max_clk;
+	if (!mmc->f_max || mmc->f_max > host->max_clk)
+		mmc->f_max = host->max_clk;
 	mmc->f_min = host->max_clk / SDCDIV_MAX_CDIV;
 
 	mmc->max_busy_timeout = ~0 / (mmc->f_max / 1000);
-- 
2.7.4

