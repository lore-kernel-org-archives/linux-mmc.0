From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] mmc: block: Tag is_rpmb as bool
Date: Wed, 10 May 2017 10:24:16 +0200
Message-ID: <20170510082418.10513-4-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36135 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdEJIZF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 04:25:05 -0400
Received: by mail-qt0-f170.google.com with SMTP id m91so20258525qte.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2017 01:25:04 -0700 (PDT)
In-Reply-To: <20170510082418.10513-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The variable is_rpmb is clearly a bool and even assigned true
and false, yet declared as an int.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index be782b8d4a0d..323f3790b629 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -443,7 +443,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
 	int err;
-	int is_rpmb = false;
+	bool is_rpmb = false;
 	u32 status = 0;
 
 	if (!card || !md || !idata)
-- 
2.9.3

