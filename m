From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 2/5] drivers: mmc: card: Fixes Missing blank line after variable initialization, coding style warning
Date: Mon,  2 Feb 2015 01:36:59 +0530
Message-ID: <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch fixes "Missing blank line warnings". Following lines show warnings
generated upon running checkpatch.pl script

        drivers/mmc/card/block.c:186: WARNING: Missing a blank line after declarations
        drivers/mmc/card/block.c:280: WARNING: Missing a blank line after declarations
        drivers/mmc/card/block.c:620: WARNING: Missing a blank line after declarations
        drivers/mmc/card/block.c:1720: WARNING: Missing a blank line after declarations


Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 80f7b4b..741a1e1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -183,6 +183,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
+
 		blk_cleanup_queue(md->queue.queue);
 
 		__clear_bit(devidx, dev_use);
@@ -616,6 +617,7 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	int ret = -EINVAL;
+
 	if (cmd == MMC_IOC_CMD)
 		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
 	return ret;
@@ -1716,6 +1718,7 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			   int ret)
 {
 	struct mmc_queue_req *mq_rq;
+
 	mq_rq = container_of(brq, struct mmc_queue_req, brq);
 
 	/*
-- 
1.7.9.5
