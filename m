From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 5/7] mmc: dw_mmc: remove the unnecessary function.
Date: Mon, 03 Mar 2014 11:36:45 +0900
Message-ID: <5313EABD.3010804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21957 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaCCCgV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Mar 2014 21:36:21 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1U007TG9WKO010@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Mar 2014 11:36:20 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Remove unnecessary function.
This function didn't re-use anywhere.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V4:
	- None
Changelog V3:
	- None
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ac16308..1418d33 100644
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
