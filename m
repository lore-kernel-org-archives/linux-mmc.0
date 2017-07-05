From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] mmc: block: Preinitialize ret in mmc_blk_issue_drv_op()
Date: Wed,  5 Jul 2017 11:07:16 +0200
Message-ID: <1499245637-28870-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

With gcc 4.1.2:

    drivers/mmc/core/block.c: In function ‘mmc_blk_issue_drv_op’:
    drivers/mmc/core/block.c:1178: warning: ‘ret’ may be used uninitialized in this function

Indeed, if mq_rq->ioc_count is zero, an uninitialized value will be
stored in mq_rq->drv_op_result and passed to blk_end_request_all().

Can mq_rq->ioc_count be zero?
  - mmc_blk_ioctl_cmd() sets ioc_count to 1, so this is safe,
  - mmc_blk_ioctl_multi_cmd() obtains ioc_count from user space in
    response to the MMC_IOC_MULTI_CMD ioctl, and does allow zero.

Preinitialize ret to -EINVAL to fix this for current and future callers.

Fixes: 0493f6fe5bdee8ac ("mmc: block: Move boot partition locking into a driver op")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
I assume -EINVAL is the error we want to return here if ioc_count is
zero.
Or should it return success (zero), like mmc_blk_ioctl_multi_cmd() used
to do?
---
 drivers/mmc/core/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0cfac2d391073922..9472e89af3efa37e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1175,7 +1175,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
-	int ret;
+	int ret = -EINVAL;
 	int i;
 
 	mq_rq = req_to_mmc_queue_req(req);
@@ -1206,7 +1206,6 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	default:
 		pr_err("%s: unknown driver specific operation\n",
 		       md->disk->disk_name);
-		ret = -EINVAL;
 		break;
 	}
 	mq_rq->drv_op_result = ret;
-- 
2.7.4
