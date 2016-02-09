From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] mmc: block: return error on failed mmc_blk_get()
Date: Tue,  9 Feb 2016 09:34:30 -0800
Message-ID: <1455039270-30204-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34008 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbcBIRei (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2016 12:34:38 -0500
Received: by mail-pf0-f170.google.com with SMTP id x65so11301995pfb.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Feb 2016 09:34:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Grant Grundler <grundler@google.com>

This used to return -EFAULT, but the function above returns -EINVAL on
the same condition so let's stick to that.

The removal of error return on this path was introduced with b093410c9aef
('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').

Fixes: b093410c9aef ('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').
Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Grant Grundler <grundler@google.com>
---
 drivers/mmc/card/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 57a5b6d..b3ec4fb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -655,8 +655,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	}
 
 	md = mmc_blk_get(bdev->bd_disk);
-	if (!md)
+	if (!md) {
+		err = -EINVAL;
 		goto cmd_err;
+	}
 
 	card = md->queue.card;
 	if (IS_ERR(card)) {
-- 
2.1.4

