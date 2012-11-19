From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH] mmc,sdio: advancing the setting of dev name in
 mmc_sdio_init_card()
Date: Tue, 20 Nov 2012 01:38:23 +0800
Message-ID: <1353346703.15558.1686.camel@cliu38-desktop-build>
References: <1353070447.15558.1681.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58140 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146Ab2KSIg4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Nov 2012 03:36:56 -0500
In-Reply-To: <1353070447.15558.1681.camel@cliu38-desktop-build>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, ohad@wizery.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com


In below call trace:
    mmc_rescan
    -> mmc_rescan_try_freq()
    -> mmc_attach_sdio()
    -> mmc_sdio_init_card()
       ...
       pm_runtime_set_active()
       ...
       mmc_add_card()

The dev name is set until in mmc_add_card(), but before that, it is
possible the dev name is needed, for example in pm_runtime_set_active(),
we can call trace event to trace which dev is changing the runtime status.

So here advance it into mmc_sdio_init_card() to benefit others.

Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 drivers/mmc/core/bus.c  |    5 +++--
 drivers/mmc/core/sdio.c |    5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 9b68933..4884d6e 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -270,8 +270,9 @@ int mmc_add_card(struct mmc_card *card)
 		[UHS_DDR50_BUS_SPEED] = "DDR50 ",
 	};
 
-
-	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
+	if (!dev_name(&card->dev))
+		dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host),
+			card->rca);
 
 	switch (card->type) {
 	case MMC_TYPE_MMC:
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..a9f6f02 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -795,8 +795,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			goto remove;
 	}
 finish:
-	if (!oldcard)
+	if (!oldcard) {
 		host->card = card;
+		dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host),
+			card->rca);
+	}
 	return 0;
 
 remove:
-- 
1.7.0.4



