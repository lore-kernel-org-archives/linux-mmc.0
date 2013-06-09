From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] mmc: JZ4740: Remove duplicated code.
Date: Sun,  9 Jun 2013 21:10:01 +0200
Message-ID: <1370805005-8104-2-git-send-email-lars@metafoo.de>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1086 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3FITGz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:55 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

From: Paul Cercueil <paul@crapouillou.net>

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index c4f3872..b31359d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -560,11 +560,6 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 					if (cmd->data)
 							cmd->data->error = -EIO;
 					cmd->error = -EIO;
-			} else if (status & (JZ_MMC_STATUS_CRC_READ_ERROR |
-					JZ_MMC_STATUS_CRC_WRITE_ERROR)) {
-					if (cmd->data)
-							cmd->data->error = -EIO;
-					cmd->error = -EIO;
 			}
 
 			jz4740_mmc_set_irq_enabled(host, irq_reg, false);
-- 
1.8.2.1

