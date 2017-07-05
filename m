From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/2] mmc: block: Initialize ret in mmc_blk_issue_drv_op() for MMC_DRV_OP_IOCTL
Date: Wed,  5 Jul 2017 17:09:41 +0200
Message-ID: <1499267382-28438-1-git-send-email-geert@linux-m68k.org>
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

Indeed, for MMC_DRV_OP_IOCTL, if mq_rq->ioc_count is zero, an
uninitialized value will be stored in mq_rq->drv_op_result and passed to
blk_end_request_all().

Can mq_rq->ioc_count be zero?
  - mmc_blk_ioctl_cmd() sets ioc_count to 1, so this is safe,
  - mmc_blk_ioctl_multi_cmd() obtains ioc_count from user space in
    response to the MMC_IOC_MULTI_CMD ioctl, and does allow zero.

Initialize ret to zero to fix this for current and future callers.

Fixes: 0493f6fe5bdee8ac ("mmc: block: Move boot partition locking into a driver op")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2, as suggested by Arnd:
  - Move the assignment after "case MMC_DRV_OP_IOCTL", to keep getting
    compile-time checks on the state of the 'ret' variable,
  - Initialize ret to zero instead of -EINVAL.
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0cfac2d391073922..4920ea1ece38a9b6 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1182,7 +1182,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 
 	switch (mq_rq->drv_op) {
 	case MMC_DRV_OP_IOCTL:
-		for (i = 0; i < mq_rq->ioc_count; i++) {
+		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
 			ret = __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
 			if (ret)
 				break;
-- 
2.7.4
