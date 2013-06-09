From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] mmc: jz4740: Fix handling of read errors.
Date: Sun,  9 Jun 2013 21:10:02 +0200
Message-ID: <1370805005-8104-3-git-send-email-lars@metafoo.de>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1114 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3FITGz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:55 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

From: Paul Cercueil <paul@crapouillou.net>

For no reason, the code handling write errors was implemented while
the code handling read errors was missing.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b31359d..3f86592 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -231,6 +231,14 @@ static void jz4740_mmc_transfer_check_state(struct jz4740_mmc_host *host,
 			host->req->cmd->error = -EIO;
 			data->error = -EIO;
 		}
+	} else if (status & JZ_MMC_STATUS_READ_ERROR_MASK) {
+		if (status & (JZ_MMC_STATUS_TIMEOUT_READ)) {
+			host->req->cmd->error = -ETIMEDOUT;
+			data->error = -ETIMEDOUT;
+		} else {
+			host->req->cmd->error = -EIO;
+			data->error = -EIO;
+		}
 	}
 }
 
-- 
1.8.2.1

