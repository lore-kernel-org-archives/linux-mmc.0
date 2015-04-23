From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2] mmc: sdio: add reset callback to bus operations
Date: Thu, 23 Apr 2015 13:15:42 +0200
Message-ID: <1429787742-4876-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33016 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933774AbbDWLPu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Apr 2015 07:15:50 -0400
Received: by wiax7 with SMTP id x7so10138750wia.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2015 04:15:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, NeilBrown <neilb@suse.de>, Andreas Fenkart <afenkart@gmail.com>

Some drivers schedule automatic hw resets. An example is mwifiex,
which schedules a card reset if the command handler between driver
and card firmware becomes out of sync

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/core/sdio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ce6cc47..01255ef 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1064,6 +1064,12 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 	return mmc_sdio_power_restore(host);
 }
 
+static int mmc_sdio_reset(struct mmc_host *host)
+{
+	mmc_power_cycle(host, host->card->ocr);
+	return mmc_sdio_power_restore(host);
+}
+
 static const struct mmc_bus_ops mmc_sdio_ops = {
 	.remove = mmc_sdio_remove,
 	.detect = mmc_sdio_detect,
@@ -1074,6 +1080,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.runtime_resume = mmc_sdio_runtime_resume,
 	.power_restore = mmc_sdio_power_restore,
 	.alive = mmc_sdio_alive,
+	.reset = mmc_sdio_reset,
 };
 
 
-- 
2.1.4

