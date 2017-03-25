From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] mmc: bcm2835: Fix possible NULL ptr dereference in bcm2835_request
Date: Sat, 25 Mar 2017 13:17:00 +0000
Message-ID: <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:53291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdCYNSC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Mar 2017 09:18:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This fixes a NULL pointer dereference in case of a MMC request with a
set block count command and no data.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7d1b0db..1f343a4 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1200,7 +1200,8 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
+	host->use_sbc = !!mrq->sbc && host->mrq->data &&
+			(host->mrq->data->flags & MMC_DATA_READ);
 	if (host->use_sbc) {
 		if (bcm2835_send_command(host, mrq->sbc)) {
 			if (!host->use_busy)
-- 
1.7.9.5

