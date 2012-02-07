From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: add the debug message for SET_BLOCK_COUNT
Date: Tue, 07 Feb 2012 14:13:10 +0900
Message-ID: <4F30B2E6.60406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31693 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab2BGFNU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2012 00:13:20 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZ0004WSBTJGRB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 07 Feb 2012 14:13:18 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZ000GLFBU6JYP1@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 07 Feb 2012 14:13:18 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is added just debug message.
Almost features need to use the CMD23.
But we didn't see the debug message for sbc.
If sbc's message can see, should be help for debugging.
(We can check whether use the cmd23 or not)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8a19143..6b72eb8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -188,6 +188,12 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	struct scatterlist *sg;
 #endif
 
+	if (mrq->sbc) {
+		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
+			 mmc_hostname(host), mrq->sbc->opcode,
+			 mrq->sbc->arg, mrq->sbc->flags);
+	}
+
 	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
 		 mmc_hostname(host), mrq->cmd->opcode,
 		 mrq->cmd->arg, mrq->cmd->flags);
-- 
1.7.4.1
