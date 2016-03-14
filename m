From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: remove redundant memset of sdio_read_cccr
Date: Mon, 14 Mar 2016 12:41:33 +0800
Message-ID: <1457930493-19021-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

When initializing sdio card, we get struct mmc_card
from mmc_alloc_card which allocates it by kzalloc. So we
don't need another memset while reading cccr.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sdio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 467b3cf..bd44ba8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -106,8 +106,6 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 	unsigned char data;
 	unsigned char speed;
 
-	memset(&card->cccr, 0, sizeof(struct sdio_cccr));
-
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_CCCR, 0, &data);
 	if (ret)
 		goto out;
-- 
2.3.7
