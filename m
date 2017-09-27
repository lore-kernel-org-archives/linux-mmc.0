From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] mmc: cavium: Add ACMD23 support for dma's multiple mode
Date: Wed, 27 Sep 2017 11:40:38 +0800
Message-ID: <1506483638-115756-3-git-send-email-shawn.lin@rock-chips.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52490 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969846AbdI0Dl4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 23:41:56 -0400
In-Reply-To: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Still need prepare for dma's multiple mode if it's a preceding
ACMD23 since it indicates a multiple block write is coming.

Cc: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: Jan Glauber <jglauber@cavium.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Just compile only, so need to do a solid test for sure
the ACMD23 support won't break cavium host. I'm also
suprised to see cavium relies on SD_SCR_CMD23_SUPPORT to
do some preparation for dma, but personly I think it's
wrong and should use a more legit way for that.

 drivers/mmc/host/cavium.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index fbd29f0..56bf0e0 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -637,7 +637,8 @@ static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 	set_bus_id(&emm_dma, slot->bus_id);
 
 	if (mmc_card_mmc(mmc->card) || (mmc_card_sd(mmc->card) &&
-	    (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
+	    ((mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT) ||
+	     mrq->sbc->flags & MMC_CMD_SD_APP)))
 		emm_dma |= FIELD_PREP(MIO_EMM_DMA_MULTI, 1);
 
 	pr_debug("[%s] blocks: %u  multi: %d\n",
-- 
1.9.1


