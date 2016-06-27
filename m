From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFCv2 08/10] mmc: core: Add halt support
Date: Mon, 27 Jun 2016 18:52:35 +0530
Message-ID: <1467033757-32498-9-git-send-email-riteshh@codeaurora.org>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56432 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbcF0NYL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 09:24:11 -0400
In-Reply-To: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, shawn.lin@rock-chips.com, Ritesh Harjani <riteshh@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

Halt is a controller feature that can change the controller mode
from command-queue to legacy. This feature is very helpful in
error cases.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[riteshh@codeaurora.org: fixed merge conflicts]
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/card/queue.c |  1 +
 drivers/mmc/core/core.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h | 17 +++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 2697529..054a0b3 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -50,6 +50,7 @@ static inline bool mmc_cmdq_should_pull_reqs(struct mmc_host *host,
 					struct mmc_cmdq_context_info *ctx)
 {
 	if (test_bit(CMDQ_STATE_DCMD_ACTIVE, &ctx->curr_state) ||
+		mmc_host_halt(host) ||
 		test_bit(CMDQ_STATE_ERR, &ctx->curr_state)) {
 		pr_debug("%s: %s: skip pulling reqs: state: %lu\n",
 			 mmc_hostname(host), __func__, ctx->curr_state);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fdb24cc..ab7f7fa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -603,6 +603,39 @@ void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq, int err)
 }
 EXPORT_SYMBOL(mmc_cmdq_post_req);
 
+/**
+ *	mmc_cmdq_halt - halt/un-halt the command queue engine
+ *	@host: host instance
+ *	@halt: true - halt, un-halt otherwise
+ *
+ *	Host halts the command queue engine. It should complete
+ *	the ongoing transfer and release the bus.
+ *	All legacy commands can be sent upon successful
+ *	completion of this function.
+ *	Returns 0 on success, negative otherwise
+ */
+int mmc_cmdq_halt(struct mmc_host *host, bool halt)
+{
+	int err = 0;
+
+	if ((halt && mmc_host_halt(host)) ||
+	    (!halt && !mmc_host_halt(host)))
+		return -EINVAL;
+
+	if (host->cmdq_ops->halt) {
+		err = host->cmdq_ops->halt(host, halt);
+		if (!err && halt)
+			mmc_host_set_halt(host);
+		else if (!err && !halt)
+			mmc_host_clr_halt(host);
+	} else {
+		err = -ENOSYS;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_cmdq_halt);
+
 int mmc_cmdq_start_req(struct mmc_host *host, struct mmc_cmdq_req *cmdq_req)
 {
 	struct mmc_request *mrq = &cmdq_req->mrq;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 7b3a60c..92aa8cc 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -143,6 +143,7 @@ struct mmc_card;
 struct mmc_async_req;
 struct mmc_cmdq_req;
 
+extern int mmc_cmdq_halt(struct mmc_host *host, bool enable);
 extern void mmc_cmdq_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			      int err);
 extern int mmc_cmdq_start_req(struct mmc_host *host,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 41b4e25..7f2ae52 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -85,6 +85,7 @@ struct mmc_cmdq_host_ops {
 	int (*request)(struct mmc_host *host, struct mmc_request *mrq);
 	void (*post_req)(struct mmc_host *host, struct mmc_request *mrq,
 			 int err);
+	int (*halt)(struct mmc_host *host, bool halt);
 };
 
 struct mmc_host_ops {
@@ -225,6 +226,7 @@ struct mmc_cmdq_context_info {
 	unsigned long	curr_state;
 #define	CMDQ_STATE_ERR 0
 #define	CMDQ_STATE_DCMD_ACTIVE 1
+#define	CMDQ_STATE_HALT 2
 	/* no free tag available */
 	unsigned long	req_starved;
 };
@@ -544,6 +546,21 @@ static inline int mmc_host_packed_wr(struct mmc_host *host)
 	return host->caps2 & MMC_CAP2_PACKED_WR;
 }
 
+static inline void mmc_host_set_halt(struct mmc_host *host)
+{
+	set_bit(CMDQ_STATE_HALT, &host->cmdq_ctx.curr_state);
+}
+
+static inline void mmc_host_clr_halt(struct mmc_host *host)
+{
+	clear_bit(CMDQ_STATE_HALT, &host->cmdq_ctx.curr_state);
+}
+
+static inline int mmc_host_halt(struct mmc_host *host)
+{
+	return test_bit(CMDQ_STATE_HALT, &host->cmdq_ctx.curr_state);
+}
+
 static inline int mmc_card_hs(struct mmc_card *card)
 {
 	return card->host->ios.timing == MMC_TIMING_SD_HS ||
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

