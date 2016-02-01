From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 08/11] mmc: s3cmci: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:33 +0900
Message-ID: <1454328456-22918-9-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55779 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbcBAMHl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:41 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01SUNB0QFCB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

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

