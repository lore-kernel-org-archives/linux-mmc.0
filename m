From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] mmc: block: remove unused variable
Date: Tue, 22 Oct 2019 14:00:36 +0100
Message-ID: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The use of 'status' was removed but the variable itself was not
removed and thus adding a build warning.

Fixes: 05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/mmc/core/block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ee1fd7df4ec8..95b41c0891d0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -497,7 +497,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
-	u32 status = 0;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
-- 
2.11.0
