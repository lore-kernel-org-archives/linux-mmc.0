From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/2] mmc: block: Let MMC_IOC_MULTI_CMD return zero again for zero entries
Date: Wed,  5 Jul 2017 17:09:42 +0200
Message-ID: <1499267382-28438-2-git-send-email-geert@linux-m68k.org>
References: <1499267382-28438-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:59802 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGEPJq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jul 2017 11:09:46 -0400
In-Reply-To: <1499267382-28438-1-git-send-email-geert@linux-m68k.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

With gcc 4.1.2:

    drivers/mmc/core/block.c: In function ‘mmc_blk_ioctl_cmd_issue’:
    drivers/mmc/core/block.c:630: warning: ‘ioc_err’ may be used uninitialized in this function

Indeed, if mq_rq->ioc_count is zero, an uninitialized value will be
stored in mq_rq->drv_op_result and passed to blk_end_request_all().

Can mq_rq->ioc_count be zero?
  - mmc_blk_ioctl_cmd() sets ioc_count to 1, so this is safe,
  - mmc_blk_ioctl_multi_cmd() obtains ioc_count from user space in
    response to the MMC_IOC_MULTI_CMD ioctl, and does allow zero.

To avoid returning an uninitialized value, and as it is pointless to do
all this work when the MMC_IOC_MULTI_CMD ioctl is used with zero
entries, check for this early in mmc_blk_ioctl_multi_cmd(), and return
zero, like was returned before.

Fixes: 3ecd8cf23f88d5df ("mmc: block: move multi-ioctl() to use block layer")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Should mmc_blk_ioctl_multi_cmd() return -EINVAL instead for this case?
That would change behavior as seen from userspace, though.

Feel free to fold in the previous patch if deemed appropriate.

v2:
  - No changes.
---
 drivers/mmc/core/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4920ea1ece38a9b6..e0363223996e6096 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -637,6 +637,9 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 			   sizeof(num_of_cmds)))
 		return -EFAULT;
 
+	if (!num_of_cmds)
+		return 0;
+
 	if (num_of_cmds > MMC_IOC_MAX_CMDS)
 		return -EINVAL;
 
-- 
2.7.4

