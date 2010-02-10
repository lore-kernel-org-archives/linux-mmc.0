From: akpm@linux-foundation.org
Subject: [patch 2/8] mmc_test: block addressed cards
Date: Wed, 10 Feb 2010 13:56:34 -0800
Message-ID: <201002102156.o1ALuZ6x001258@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33281 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452Ab0BJV4u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2010 16:56:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, johan.kristell@axis.com, linux-mmc@vger.kernel.org

From: Johan Kristell <johan.kristell@axis.com>

This patch fixes a bug in the multiblock write tests where the written
data is read back for verifying one block at a time.  The tests in
mmc_test assumes that all cards are byte addressable.  

This will cause the multi block write tests to fail, leading the user of
the mmc_test driver thinking there is something wrong with the sdhci
driver they are testing.

The start address for the block is calculated as: blocknum * 512. For
block addressable cards the blocknum alone should be used.

Signed-off-by: Johan Kristell <johan.kristell@axis.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/card/mmc_test.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/card/mmc_test.c~mmc_test-block-addressed-cards drivers/mmc/card/mmc_test.c
--- a/drivers/mmc/card/mmc_test.c~mmc_test-block-addressed-cards
+++ a/drivers/mmc/card/mmc_test.c
@@ -74,6 +74,9 @@ static void mmc_test_prepare_mrq(struct 
 	}
 
 	mrq->cmd->arg = dev_addr;
+	if (!mmc_card_blockaddr(test->card))
+		mrq->cmd->arg <<= 9;
+
 	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	if (blocks == 1)
@@ -190,7 +193,7 @@ static int __mmc_test_prepare(struct mmc
 	}
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -219,7 +222,7 @@ static int mmc_test_cleanup(struct mmc_t
 	memset(test->buffer, 0, 512);
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -426,7 +429,7 @@ static int mmc_test_transfer(struct mmc_
 		for (i = 0;i < sectors;i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
-				dev_addr + i * 512, 512, 0);
+				dev_addr + i, 512, 0);
 			if (ret)
 				return ret;
 		}
_
