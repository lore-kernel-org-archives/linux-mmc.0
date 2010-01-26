From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH] mxcmmc: fixed max_seg_size value on initialization.
Date: Tue, 26 Jan 2010 14:40:04 +0300
Message-ID: <1264506004-17827-1-git-send-email-vzapolskiy@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52577 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab0AZLkd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2010 06:40:33 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3459333bwz.21
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2010 03:40:32 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
---
 drivers/mmc/host/mxcmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 60a2b69..faa7b76 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -708,7 +708,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_seg_size;
+	mmc->max_seg_size = mmc->max_req_size;
 
 	host = mmc_priv(mmc);
 	host->base = ioremap(r->start, resource_size(r));
-- 
1.6.5.4

