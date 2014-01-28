From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 6/8] mmc: dw_mmc: remove the unnecessary function.
Date: Tue, 28 Jan 2014 17:24:57 +0900
Message-ID: <52E76959.8040003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48734 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbaA1IY2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:24:28 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N03003HMRCRV840@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 17:24:27 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

Remove unnecessary function.
This function didn't re-use anywhere.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2cdfccb..947859f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -235,12 +235,6 @@ err:
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-static void dw_mci_set_timeout(struct dw_mci *host)
-{
-	/* timeout (maximum) */
-	mci_writel(host, TMOUT, 0xffffffff);
-}
-
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct mmc_data	*data;
@@ -861,7 +855,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	data = cmd->data;
 	if (data) {
-		dw_mci_set_timeout(host);
+		mci_writel(host, TMOUT, 0xFFFFFFFF);
 		mci_writel(host, BYTCNT, data->blksz*data->blocks);
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
-- 
1.7.9.5
