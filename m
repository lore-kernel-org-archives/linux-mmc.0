From: Niko Jokinen <ext-niko.k.jokinen@nokia.com>
Subject: [PATCH] mmc_test: block addressed cards
Date: Mon, 24 May 2010 16:34:32 +0300
Message-ID: <1274708072-16264-1-git-send-email-ext-niko.k.jokinen@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53427 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0EXNe7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2010 09:34:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ext-niko.k.jokinen@nokia.com
Cc: Johan Kristell <johan.kristell@axis.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

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
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


backported from mainline commit
c286d03cce118e9fb8dda8da43f9131c169c5a75

Fixes: NB#164938 - Misaligned in-kernel MMC transfer hangs task

---
 drivers/mmc/card/mmc_test.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b9f1e84..e7f8027 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -74,6 +74,9 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
 	}
 
 	mrq->cmd->arg = dev_addr;
+	if (!mmc_card_blockaddr(test->card))
+		mrq->cmd->arg <<= 9;
+
 	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	if (blocks == 1)
@@ -190,7 +193,7 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 	}
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -219,7 +222,7 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
 	memset(test->buffer, 0, 512);
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -426,7 +429,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 		for (i = 0;i < sectors;i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
-				dev_addr + i * 512, 512, 0);
+				dev_addr + i, 512, 0);
 			if (ret)
 				return ret;
 		}
-- 
1.6.0.4

