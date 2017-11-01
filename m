From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/3] mmc: cavium: Add ACMD23 support for dma's multiple mode
Date: Wed,  1 Nov 2017 09:37:13 +0800
Message-ID: <1509500233-133821-3-git-send-email-shawn.lin@rock-chips.com>
References: <1509500233-133821-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54251 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdKABjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 21:39:19 -0400
In-Reply-To: <1509500233-133821-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jan Glauber <jglauber@cavium.com>, Shawn Lin <shawn.lin@rock-chips.com>

Still need prepare for dma's multiple mode if it's a preceding
ACMD23 since it indicates a multiple block write is coming.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Jan Glauber <jglauber@cavium.com>
---

Changes in v2: None

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


