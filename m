From: "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH 2/4] mmc: cavium: Fix detection of block or byte addressing.
Date: Mon, 24 Apr 2017 13:41:56 -0500
Message-ID: <1493059318-767-3-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:48489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S972560AbdDXSoU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Apr 2017 14:44:20 -0400
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Use the mmc_card_is_blockaddr() function to properly detect if the
card uses byte or block addressing.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/mmc/host/cavium.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index d842b69..36b25e4 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -629,7 +629,7 @@ static u64 prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	emm_dma = FIELD_PREP(MIO_EMM_DMA_VAL, 1) |
 		  FIELD_PREP(MIO_EMM_DMA_SECTOR,
-			     (mrq->data->blksz == 512) ? 1 : 0) |
+			     mmc_card_is_blockaddr(mmc->card) ? 1 : 0) |
 		  FIELD_PREP(MIO_EMM_DMA_RW,
 			     (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0) |
 		  FIELD_PREP(MIO_EMM_DMA_BLOCK_CNT, mrq->data->blocks) |
-- 
2.1.4

