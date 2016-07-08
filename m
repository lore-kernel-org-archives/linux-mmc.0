From: Ville Viinikka <ville@tuxera.com>
Subject: [PATCH] mmc: block: fix free of uninitialized 'idata->buf'
Date: Fri, 8 Jul 2016 18:27:02 +0300
Message-ID: <1467991622-11036-1-git-send-email-ville@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ex13.tuxera.com ([178.16.184.72]:45685 "EHLO ex13.tuxera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755769AbcGHPnc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jul 2016 11:43:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ville Viinikka <ville@tuxera.com>

Set 'idata->buf' to NULL so that it never gets returned without
initialization. This fixes a bug where mmc_blk_ioctl_cmd() would
free both 'idata' and 'idata->buf' but 'idata->buf' was returned
uninitialized.

Fixes: 1ff8950c0433 ("mmc: block: change to use kmalloc when copy data from userspace")
Signed-off-by: Ville Viinikka <ville@tuxera.com>
---
 drivers/mmc/card/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 747c4b0..334d637 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -355,8 +355,10 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 		goto idata_err;
 	}
 
-	if (!idata->buf_bytes)
+	if (!idata->buf_bytes) {
+		idata->buf = NULL;
 		return idata;
+	}
 
 	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
 	if (!idata->buf) {
-- 
2.1.4

