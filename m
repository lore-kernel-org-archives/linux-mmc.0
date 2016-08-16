From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 02/30] mmc: mmc_test: Add tests for sending commands during transfer
Date: Tue, 16 Aug 2016 13:44:12 +0300
Message-ID: <1471344280-16663-3-git-send-email-adrian.hunter@intel.com>
References: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbcHPKti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:49:38 -0400
In-Reply-To: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Add 6 tests for sending commands during transfer. The tests are:
 * Commands during read - no Set Block Count (CMD23).
 * Commands during write - no Set Block Count (CMD23).
 * Commands during read - use Set Block Count (CMD23).
 * Commands during write - use Set Block Count (CMD23).
 * Commands during non-blocking read - use Set Block Count (CMD23).
 * Commands during non-blocking write - use Set Block Count (CMD23).

For a range of transfer sizes, the tests start an ongoing data transfer and
then repeatedly send the status command (CMD13) while the transfer
continues. The tests pass if all requests complete with no errors. The host
controller driver must support MMC_CAP_CMD_DURING_TFR.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/mmc_test.c | 308 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index c032eef45762..5a8dc5a76e0d 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -184,6 +184,29 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
 	return mmc_set_blocklen(test->card, size);
 }
 
+static bool mmc_test_card_cmd23(struct mmc_card *card)
+{
+	return mmc_card_mmc(card) ||
+	       (mmc_card_sd(card) && card->scr.cmds & SD_SCR_CMD23_SUPPORT);
+}
+
+static void mmc_test_prepare_sbc(struct mmc_test_card *test,
+				 struct mmc_request *mrq, unsigned int blocks)
+{
+	struct mmc_card *card = test->card;
+
+	if (!mrq->sbc || !mmc_host_cmd23(card->host) ||
+	    !mmc_test_card_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode) ||
+	    (card->quirks & MMC_QUIRK_BLK_NO_CMD23)) {
+		mrq->sbc = NULL;
+		return;
+	}
+
+	mrq->sbc->opcode = MMC_SET_BLOCK_COUNT;
+	mrq->sbc->arg = blocks;
+	mrq->sbc->flags = MMC_RSP_R1 | MMC_CMD_AC;
+}
+
 /*
  * Fill in the mmc_request structure given a set of transfer parameters.
  */
@@ -221,6 +244,8 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
 	mrq->data->sg = sg;
 	mrq->data->sg_len = sg_len;
 
+	mmc_test_prepare_sbc(test, mrq, blocks);
+
 	mmc_set_data_timeout(mrq->data, test->card);
 }
 
@@ -693,6 +718,8 @@ static int mmc_test_check_result(struct mmc_test_card *test,
 
 	ret = 0;
 
+	if (mrq->sbc && mrq->sbc->error)
+		ret = mrq->sbc->error;
 	if (!ret && mrq->cmd->error)
 		ret = mrq->cmd->error;
 	if (!ret && mrq->data->error)
@@ -2278,6 +2305,245 @@ static int mmc_test_reset(struct mmc_test_card *test)
 	return RESULT_FAIL;
 }
 
+struct mmc_test_req {
+	struct mmc_request mrq;
+	struct mmc_command sbc;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_command status;
+	struct mmc_data data;
+};
+
+static struct mmc_test_req *mmc_test_req_alloc(void)
+{
+	struct mmc_test_req *rq = kzalloc(sizeof(*rq), GFP_KERNEL);
+
+	if (rq) {
+		rq->mrq.cmd = &rq->cmd;
+		rq->mrq.data = &rq->data;
+		rq->mrq.stop = &rq->stop;
+	}
+
+	return rq;
+}
+
+static int mmc_test_send_status(struct mmc_test_card *test,
+				struct mmc_command *cmd)
+{
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->opcode = MMC_SEND_STATUS;
+	if (!mmc_host_is_spi(test->card->host))
+		cmd->arg = test->card->rca << 16;
+	cmd->flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	return mmc_wait_for_cmd(test->card->host, cmd, 0);
+}
+
+static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
+				     unsigned int dev_addr, int use_sbc,
+				     int repeat_cmd, int write, int use_areq)
+{
+	struct mmc_test_req *rq = mmc_test_req_alloc();
+	struct mmc_host *host = test->card->host;
+	struct mmc_test_area *t = &test->area;
+	struct mmc_async_req areq;
+	struct mmc_request *mrq;
+	unsigned long timeout;
+	bool expired = false;
+	int ret = 0, cmd_ret;
+	u32 status = 0;
+	int count = 0;
+
+	if (!rq)
+		return -ENOMEM;
+
+	mrq = &rq->mrq;
+	if (use_sbc)
+		mrq->sbc = &rq->sbc;
+	mrq->cap_cmd_during_tfr = true;
+
+	areq.mrq = mrq;
+	areq.err_check = mmc_test_check_result_async;
+
+	mmc_test_prepare_mrq(test, mrq, t->sg, t->sg_len, dev_addr, t->blocks,
+			     512, write);
+
+	if (use_sbc && t->blocks > 1 && !mrq->sbc) {
+		ret =  mmc_host_cmd23(host) ?
+		       RESULT_UNSUP_CARD :
+		       RESULT_UNSUP_HOST;
+		goto out_free;
+	}
+
+	/* Start ongoing data request */
+	if (use_areq) {
+		mmc_start_req(host, &areq, &ret);
+		if (ret)
+			goto out_free;
+	} else {
+		mmc_wait_for_req(host, mrq);
+	}
+
+	timeout = jiffies + msecs_to_jiffies(3000);
+	do {
+		count += 1;
+
+		/* Send status command while data transfer in progress */
+		cmd_ret = mmc_test_send_status(test, &rq->status);
+		if (cmd_ret)
+			break;
+
+		status = rq->status.resp[0];
+		if (status & R1_ERROR) {
+			cmd_ret = -EIO;
+			break;
+		}
+
+		if (mmc_is_req_done(host, mrq))
+			break;
+
+		expired = time_after(jiffies, timeout);
+		if (expired) {
+			pr_info("%s: timeout waiting for Tran state status %#x\n",
+				mmc_hostname(host), status);
+			cmd_ret = -ETIMEDOUT;
+			break;
+		}
+	} while (repeat_cmd && R1_CURRENT_STATE(status) != R1_STATE_TRAN);
+
+	/* Wait for data request to complete */
+	if (use_areq)
+		mmc_start_req(host, NULL, &ret);
+	else
+		mmc_wait_for_req_done(test->card->host, mrq);
+
+	/*
+	 * For cap_cmd_during_tfr request, upper layer must send stop if
+	 * required.
+	 */
+	if (mrq->data->stop && (mrq->data->error || !mrq->sbc)) {
+		if (ret)
+			mmc_wait_for_cmd(host, mrq->data->stop, 0);
+		else
+			ret = mmc_wait_for_cmd(host, mrq->data->stop, 0);
+	}
+
+	if (ret)
+		goto out_free;
+
+	if (cmd_ret) {
+		pr_info("%s: Send Status failed: status %#x, error %d\n",
+			mmc_hostname(test->card->host), status, cmd_ret);
+	}
+
+	ret = mmc_test_check_result(test, mrq);
+	if (ret)
+		goto out_free;
+
+	ret = mmc_test_wait_busy(test);
+	if (ret)
+		goto out_free;
+
+	if (repeat_cmd && (t->blocks + 1) << 9 > t->max_tfr)
+		pr_info("%s: %d commands completed during transfer of %u blocks\n",
+			mmc_hostname(test->card->host), count, t->blocks);
+
+	if (cmd_ret)
+		ret = cmd_ret;
+out_free:
+	kfree(rq);
+
+	return ret;
+}
+
+static int __mmc_test_cmds_during_tfr(struct mmc_test_card *test,
+				      unsigned long sz, int use_sbc, int write,
+				      int use_areq)
+{
+	struct mmc_test_area *t = &test->area;
+	int ret;
+
+	if (!(test->card->host->caps & MMC_CAP_CMD_DURING_TFR))
+		return RESULT_UNSUP_HOST;
+
+	ret = mmc_test_area_map(test, sz, 0, 0);
+	if (ret)
+		return ret;
+
+	ret = mmc_test_ongoing_transfer(test, t->dev_addr, use_sbc, 0, write,
+					use_areq);
+	if (ret)
+		return ret;
+
+	return mmc_test_ongoing_transfer(test, t->dev_addr, use_sbc, 1, write,
+					 use_areq);
+}
+
+static int mmc_test_cmds_during_tfr(struct mmc_test_card *test, int use_sbc,
+				    int write, int use_areq)
+{
+	struct mmc_test_area *t = &test->area;
+	unsigned long sz;
+	int ret;
+
+	for (sz = 512; sz <= t->max_tfr; sz += 512) {
+		ret = __mmc_test_cmds_during_tfr(test, sz, use_sbc, write,
+						 use_areq);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/*
+ * Commands during read - no Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_read(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 0, 0, 0);
+}
+
+/*
+ * Commands during write - no Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_write(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 0, 1, 0);
+}
+
+/*
+ * Commands during read - use Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_read_cmd23(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 1, 0, 0);
+}
+
+/*
+ * Commands during write - use Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_write_cmd23(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 1, 1, 0);
+}
+
+/*
+ * Commands during non-blocking read - use Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_read_cmd23_nonblock(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 1, 0, 1);
+}
+
+/*
+ * Commands during non-blocking write - use Set Block Count (CMD23).
+ */
+static int mmc_test_cmds_during_write_cmd23_nonblock(struct mmc_test_card *test)
+{
+	return mmc_test_cmds_during_tfr(test, 1, 1, 1);
+}
+
 static const struct mmc_test_case mmc_test_cases[] = {
 	{
 		.name = "Basic write (no data verification)",
@@ -2605,6 +2871,48 @@ static const struct mmc_test_case mmc_test_cases[] = {
 		.name = "Reset test",
 		.run = mmc_test_reset,
 	},
+
+	{
+		.name = "Commands during read - no Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_read,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Commands during write - no Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_write,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Commands during read - use Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_read_cmd23,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Commands during write - use Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_write_cmd23,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Commands during non-blocking read - use Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_read_cmd23_nonblock,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Commands during non-blocking write - use Set Block Count (CMD23)",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_cmds_during_write_cmd23_nonblock,
+		.cleanup = mmc_test_area_cleanup,
+	},
 };
 
 static DEFINE_MUTEX(mmc_test_lock);
-- 
1.9.1

