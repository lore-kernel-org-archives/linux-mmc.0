From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: block: Release index in partition allocation error path
Date: Mon, 18 Apr 2016 13:43:53 +0200
Message-ID: <1460979834-24582-2-git-send-email-ulf.hansson@linaro.org>
References: <1460979834-24582-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34244 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcDRLoL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:44:11 -0400
Received: by mail-lf0-f45.google.com with SMTP id j11so212984893lfb.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2016 04:44:10 -0700 (PDT)
In-Reply-To: <1460979834-24582-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

If the allocation of a new partition fails, let's make sure to also
release the previously picked device index.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 8a0147d..9aaf22e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2289,6 +2289,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
  err_kfree:
 	kfree(md);
  out:
+	__clear_bit(devidx, dev_use);
 	return ERR_PTR(ret);
 }
 
-- 
1.9.1

