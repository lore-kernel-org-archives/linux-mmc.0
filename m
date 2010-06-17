From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] mmc: use snprintf not sprintf
Date: Thu, 17 Jun 2010 15:58:46 +0100
Message-ID: <20100617145807.15099.65843.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45527 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab0FQPV4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Jun 2010 11:21:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: pierre@ossman.eu, linux-mmc@vger.kernel.org

Just starting on the MMC/SDIO patches in the Intel tree for upstream. This one
is very much a take it or leave it item. Merge or drop ?

From: JiebingLi <jiebing.li@intel.com>

This patch fixes an issue found by klockwork. Just paranoia.

Signed-off-by: JiebingLi <jiebing.li@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cb9fbc8..9793f4c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -535,7 +535,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	 * messages to tell when the card is present.
 	 */
 
-	sprintf(md->disk->disk_name, "mmcblk%d", devidx);
+	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
+		"mmcblk%d", devidx);
 
 	blk_queue_logical_block_size(md->queue.queue, 512);
 

