From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: add the warning message when card didn't support HPI
Date: Fri, 09 Mar 2012 17:24:06 +0900
Message-ID: <4F59BE26.8070705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36997 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab2CIIYN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 03:24:13 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0L00HKLZC67850@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Mar 2012 17:24:08 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0L00104ZC89A80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Mar 2012 17:24:08 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Though card didn't support HPI,someone could use the send_hpi_cmd().
Then maybe didn't work fine.
Because card->ext_csd.hpi_cmd didn't set.
So if card didn't support hpi, return the waring message.

And CMD12's flags is MMC_RSP_R1B.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/mmc_ops.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4d41fa9..395f944 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -556,9 +556,15 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 	unsigned int flags;
 	int err;
 
+	if (!card->ext_csd.hpi) {
+		pr_waring("%s: Card didn't support HPI command\n",
+				mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	opcode = card->ext_csd.hpi_cmd;
 	if (opcode == MMC_STOP_TRANSMISSION)
-		flags = MMC_RSP_R1 | MMC_CMD_AC;
+		flags = MMC_RSP_R1B | MMC_CMD_AC;
 	else if (opcode == MMC_SEND_STATUS)
 		flags = MMC_RSP_R1 | MMC_CMD_AC;
 
