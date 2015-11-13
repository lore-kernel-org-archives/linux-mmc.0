From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 2/6] mmc: move mmc_wait_busy() to core
Date: Fri, 13 Nov 2015 15:56:08 +0100
Message-ID: <1447426572-11756-3-git-send-email-holgerschurig@gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34094 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932713AbbKMO4Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2015 09:56:25 -0500
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avi.shchislowski@sandisk.com, alex.lemberg@sandisk.com
Cc: Holger Schurig <holgerschurig@gmail.com>

Currently this function is used inside the mmc test driver. But it is also
usable in the (upcoming) firmware update patch. So move this function out
of mmc_test.c into core.c.

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>
---
 drivers/mmc/card/mmc_test.c | 46 ++++-----------------------------------------
 drivers/mmc/core/core.c     | 38 +++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h    |  1 +
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 69b6c45..d1c2d22 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -184,44 +184,6 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
 	return mmc_set_blocklen(test->card, size);
 }
 
-static int mmc_test_busy(struct mmc_command *cmd)
-{
-	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
-		(R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
-}
-
-/*
- * Wait for the card to finish the busy state
- */
-static int mmc_test_wait_busy(struct mmc_test_card *test)
-{
-	int ret, busy;
-	struct mmc_command cmd = {0};
-
-	busy = 0;
-	do {
-		memset(&cmd, 0, sizeof(struct mmc_command));
-
-		cmd.opcode = MMC_SEND_STATUS;
-		cmd.arg = test->card->rca << 16;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
-
-		ret = mmc_wait_for_cmd(test->card->host, &cmd, 0);
-		if (ret)
-			break;
-
-		if (!busy && mmc_test_busy(&cmd)) {
-			busy = 1;
-			if (test->card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-				pr_info("%s: Warning: Host did not "
-					"wait for busy state to end.\n",
-					mmc_hostname(test->card->host));
-		}
-	} while (mmc_test_busy(&cmd));
-
-	return ret;
-}
-
 /*
  * Transfer a single sector of kernel addressable data
  */
@@ -250,7 +212,7 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 	if (data.error)
 		return data.error;
 
-	return mmc_test_wait_busy(test);
+	return mmc_wait_busy(test->card);
 }
 
 static void mmc_test_free_mem(struct mmc_test_mem *mem)
@@ -675,7 +637,7 @@ static int mmc_test_check_result_async(struct mmc_card *card,
 	struct mmc_test_async_req *test_async =
 		container_of(areq, struct mmc_test_async_req, areq);
 
-	mmc_test_wait_busy(test_async->test);
+	mmc_wait_busy(test_async->test->card);
 
 	return mmc_test_check_result(test_async->test, areq->mrq);
 }
@@ -812,7 +774,7 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 
 	mmc_wait_for_req(test->card->host, &mrq);
 
-	mmc_test_wait_busy(test);
+	mmc_wait_busy(test->card);
 
 	return mmc_test_check_result(test, &mrq);
 }
@@ -841,7 +803,7 @@ static int mmc_test_broken_transfer(struct mmc_test_card *test,
 
 	mmc_wait_for_req(test->card->host, &mrq);
 
-	mmc_test_wait_busy(test);
+	mmc_wait_busy(test->card);
 
 	return mmc_test_check_broken_result(test, &mrq);
 }
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2b5e398..df5a61c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2856,6 +2856,44 @@ void mmc_prepare_mrq(struct mmc_card *card,
 }
 EXPORT_SYMBOL(mmc_prepare_mrq);
 
+static int mmc_test_busy(struct mmc_command *cmd)
+{
+	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
+		(R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
+}
+
+/*
+ * Wait for the card to finish the busy state
+ */
+int mmc_wait_busy(struct mmc_card *card)
+{
+	int ret, busy;
+	struct mmc_command cmd = {0};
+
+	busy = 0;
+	do {
+		memset(&cmd, 0, sizeof(struct mmc_command));
+
+		cmd.opcode = MMC_SEND_STATUS;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+		ret = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (ret)
+			break;
+
+		if (!busy && mmc_test_busy(&cmd)) {
+			busy = 1;
+			if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+				pr_info("%s: Warning: Host did not wait for busy state to end.\n",
+					mmc_hostname(card->host));
+		}
+	} while (mmc_test_busy(&cmd));
+
+	return ret;
+}
+EXPORT_SYMBOL(mmc_wait_busy);
+
 /**
  * mmc_init_context_info() - init synchronization context
  * @host: mmc host
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f8db960..50e37e1 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -199,6 +199,7 @@ extern int mmc_detect_card_removed(struct mmc_host *host);
 extern void mmc_prepare_mrq(struct mmc_card *card,
 	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
 	unsigned dev_addr, unsigned blocks, unsigned blksz, int write);
+extern int mmc_wait_busy(struct mmc_card *card);
 
 /**
  *	mmc_claim_host - exclusively claim a host
-- 
2.1.4

