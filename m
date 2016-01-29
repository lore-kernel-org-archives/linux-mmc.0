From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 08/11] mmc: s3cmci: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:54 +0900
Message-ID: <1454046057-32318-9-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47237 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcA2FlE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:04 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P0105G94DMCA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:01 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it doesn't use anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/s3cmci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 6291d50..39814f3 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1014,8 +1014,7 @@ static int s3cmci_setup_data(struct s3cmci_host *host, struct mmc_data *data)
 	if (host->bus_width == MMC_BUS_WIDTH_4)
 		dcon |= S3C2410_SDIDCON_WIDEBUS;
 
-	if (!(data->flags & MMC_DATA_STREAM))
-		dcon |= S3C2410_SDIDCON_BLOCKMODE;
+	dcon |= S3C2410_SDIDCON_BLOCKMODE;
 
 	if (data->flags & MMC_DATA_WRITE) {
 		dcon |= S3C2410_SDIDCON_TXAFTERRESP;
-- 
1.9.1

