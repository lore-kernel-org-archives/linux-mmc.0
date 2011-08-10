From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: use defined macro for card status
Date: Wed, 10 Aug 2011 18:46:28 +0900
Message-ID: <4E425374.7060706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14196 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1HJJqW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 05:46:22 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LPP00BM1HSNP800@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 10 Aug 2011 18:46:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LPP004GKHT9ME@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 10 Aug 2011 18:46:21 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Sometime we need to check the card status.
So using R1_CURRENT_STATE(status)..and compare with R1_STATE_xxx.
But some code didn't use R1_STATE_xxx.

I think good that use defined macro for checking card status.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/card/mmc_test.c |    2 +-
 drivers/mmc/core/core.c     |    2 +-
 drivers/mmc/core/mmc_ops.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 742dc98..2bf229a 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -224,7 +224,7 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
 static int mmc_test_busy(struct mmc_command *cmd)
 {
 	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
-		(R1_CURRENT_STATE(cmd->resp[0]) == 7);
+		(R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
 }
 
 /*
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f091b43..bfb86a6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1501,7 +1501,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 			goto out;
 		}
 	} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
-		 R1_CURRENT_STATE(cmd.resp[0]) == 7);
+		 R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG);
 out:
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 845ce7c..770c3d0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -407,7 +407,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 			break;
 		if (mmc_host_is_spi(card->host))
 			break;
-	} while (R1_CURRENT_STATE(status) == 7);
+	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
 
 	if (mmc_host_is_spi(card->host)) {
 		if (status & R1_SPI_ILLEGAL_COMMAND)
