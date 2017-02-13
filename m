From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: block: return errorcode and not 0
Date: Mon, 13 Feb 2017 15:40:38 +0100
Message-ID: <20170213144038.975-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33948 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdBMOkr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2017 09:40:47 -0500
Received: by mail-lf0-f41.google.com with SMTP id v186so51327908lfa.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2017 06:40:46 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The function mmc_sd_num_wr_blocks() was changed in
9a5e7ddc7954: "mmc: block: return errorcode from mmc_sd_num_wr_blocks()"
to return err; but this was fixed in
65f2da1ecb36: "mmc: block: return 0 where evident"
as clearly err was anyways zero.

Well the first commit was wrong, we should have returned an
errorcode all the time.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 65f2da1ecb36: ("mmc: block: return 0 where evident")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ulf please apply this for fixes.
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 985477cdcb3e..cd909aecfded 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -783,7 +783,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	if (err)
 		return err;
 	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
-		return 0;
+		return -EIO;
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
-- 
2.9.3

