From: Asaf Vertz <asaf.vertz@tandemg.com>
Subject: [PATCH] mmc: block: fix format string warning
Date: Tue, 20 Jan 2015 18:33:35 +0200
Message-ID: <20150120163335.GA5016@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net
Cc: ulf.hansson@linaro.org, kuninori.morimoto.gx@renesas.com, ben@decadent.org.uk, joe@perches.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Fixed the following warning (reported by cppcheck):
[drivers/mmc/card/block.c:2149]: (warning) %d in format string (no. 1)
requires 'int' but the argument type is 'unsigned int'.

Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
---
 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4409d79..8e1a60e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2147,7 +2147,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 */
 
 	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
+		 "mmcblk%u%s", md->name_idx, subname ? subname : "");
 
 	if (mmc_card_mmc(card))
 		blk_queue_logical_block_size(md->queue.queue,
-- 
1.7.0.4
