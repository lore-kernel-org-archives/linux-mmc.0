From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] mmc: block: return 0 where evident
Date: Wed,  1 Feb 2017 13:47:59 +0100
Message-ID: <20170201124800.13865-10-linus.walleij@linaro.org>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34890 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdBAMtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:49:12 -0500
Received: by mail-lf0-f51.google.com with SMTP id n124so227408844lfd.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 04:49:12 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

mmc_sd_num_wr_blocks() has this construction:

if (err)
    return err;
if (some_other_stuff_not_touching_err)
    return err;

It follows from logical deduction that we can just return 0
in the latter case.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 92f7772ca56d..c49c90dba839 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -788,7 +788,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	if (err)
 		return err;
 	if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
-		return err;
+		return 0;
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
-- 
2.9.3

