From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 06/11] mmc: mxcmmc: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:31 +0900
Message-ID: <1454328456-22918-7-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcBAMHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:44 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V02S8RB0QP400@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/mxcmmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index d110f9e..3d1ea5e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -307,9 +307,6 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	enum dma_transfer_direction slave_dirn;
 	int i, nents;
 
-	if (data->flags & MMC_DATA_STREAM)
-		nob = 0xffff;
-
 	host->data = data;
 	data->bytes_xfered = 0;
 
-- 
1.9.1

