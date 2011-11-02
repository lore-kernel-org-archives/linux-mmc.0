From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: fix the wrong response type for HPI command
Date: Wed, 02 Nov 2011 13:19:03 +0900
Message-ID: <4EB0C4B7.8060100@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48090 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1KBETJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 00:19:09 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LU000A6MMNLLFH0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Nov 2011 13:19:07 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LU0000HIMNVYP10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Nov 2011 13:19:07 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

When used STOP_TRANSMISSION for hpi command, response-type should be R1B.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/mmc_ops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 007863e..17cc6e4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -557,7 +557,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 
 	opcode = card->ext_csd.hpi_cmd;
 	if (opcode == MMC_STOP_TRANSMISSION)
-		flags = MMC_RSP_R1 | MMC_CMD_AC;
+		flags = MMC_RSP_R1B | MMC_CMD_AC;
 	else if (opcode == MMC_SEND_STATUS)
 		flags = MMC_RSP_R1 | MMC_CMD_AC;
 
