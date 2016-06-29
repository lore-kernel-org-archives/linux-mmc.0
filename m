From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 26/54] mmc: core: Add support for sending commands during data transfer
Date: Wed, 29 Jun 2016 16:24:39 +0300
Message-ID: <1467206707-30185-27-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36571 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbcF2Nci (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:32:38 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

A host controller driver exposes its capability using caps flag
MMC_CAP_CMD_DURING_TFR. A driver with that capability can accept requests
that are marked mrq->cap_cmd_during_tfr = true. Then the driver informs the
upper layers when the command line is available for further commands by
calling mmc_command_done(). Because of that, the driver will not then
automatically send STOP commands, and it is the responsibility of the upper
layer to send a STOP command if it is required.

For requests submitted through the mmc_wait_for_req() interface, the caller
sets mrq->cap_cmd_during_tfr = true which causes mmc_wait_for_req() in fact
not to wait. The caller can then send commands that do not use the data
lines. Finally the caller can wait for the transfer to complete by calling
mmc_wait_for_req_done() which is now exported.

For requests submitted through the mmc_start_req() interface, the caller
again sets mrq->cap_cmd_during_tfr = true, but mmc_start_req() anyway does
not wait. The caller can then send commands that do not use the data
lines. Finally the caller can wait for the transfer to complete in the
normal way i.e. calling mmc_start_req() again.

Irrespective of how a cap_cmd_during_tfr request is started,
mmc_is_req_done() can be called if the upper layer needs to determine if
the request is done. However the appropriate waiting function (either
mmc_wait_for_req_done() or mmc_start_req()) must still be called.

The implementation consists primarily of a new completion
mrq->cmd_completion which notifies when the command line is available for
further commands. That completion is completed by mmc_command_done().
When there is an ongoing data transfer, calls to mmc_wait_for_req() will
automatically wait on that completion, so the caller does not have to do
anything special.

Note, in the case of errors, the driver may call mmc_request_done() without
calling mmc_command_done() because mmc_request_done() always calls
mmc_command_done().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 95 +++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/mmc/core.h |  7 ++++
 include/linux/mmc/host.h |  5 +++
 3 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c823df8deb4..7ba5a55c8142 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -117,6 +117,24 @@ static inline void mmc_should_fail_request(struct mmc_host *host,
 
 #endif /* CONFIG_FAIL_MMC_REQUEST */
 
+static inline void mmc_complete_cmd(struct mmc_request *mrq)
+{
+	if (mrq->cap_cmd_during_tfr && !completion_done(&mrq->cmd_completion))
+		complete_all(&mrq->cmd_completion);
+}
+
+void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq)
+{
+	if (!mrq->cap_cmd_during_tfr)
+		return;
+
+	mmc_complete_cmd(mrq);
+
+	pr_debug("%s: cmd done, tfr ongoing (CMD%u)\n",
+		 mmc_hostname(host), mrq->cmd->opcode);
+}
+EXPORT_SYMBOL(mmc_command_done);
+
 /**
  *	mmc_request_done - finish processing an MMC request
  *	@host: MMC host which completed request
@@ -143,6 +161,11 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 			cmd->retries = 0;
 	}
 
+	if (host->ongoing_mrq == mrq)
+		host->ongoing_mrq = NULL;
+
+	mmc_complete_cmd(mrq);
+
 	trace_mmc_request_done(host, mrq);
 
 	if (err && cmd->retries && !mmc_card_removed(host->card)) {
@@ -155,7 +178,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	} else {
 		mmc_should_fail_request(host, mrq);
 
-		led_trigger_event(host->led, LED_OFF);
+		if (!host->ongoing_mrq)
+			led_trigger_event(host->led, LED_OFF);
 
 		if (mrq->sbc) {
 			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
@@ -220,6 +244,15 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	if (mrq->cap_cmd_during_tfr) {
+		host->ongoing_mrq = mrq;
+		/*
+		 * Retry path could come through here without having waiting on
+		 * cmd_completion, so ensure it is reinitialised.
+		 */
+		reinit_completion(&mrq->cmd_completion);
+	}
+
 	trace_mmc_request_start(host, mrq);
 
 	host->ops->request(host, mrq);
@@ -386,6 +419,18 @@ static void mmc_wait_done(struct mmc_request *mrq)
 	complete(&mrq->completion);
 }
 
+static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
+{
+	struct mmc_request *ongoing_mrq = READ_ONCE(host->ongoing_mrq);
+
+	/*
+	 * If there is an ongoing transfer, wait for the command line to become
+	 * available.
+	 */
+	if (ongoing_mrq && !completion_done(&ongoing_mrq->cmd_completion))
+		wait_for_completion(&ongoing_mrq->cmd_completion);
+}
+
 /*
  *__mmc_start_data_req() - starts data request
  * @host: MMC host to start the request
@@ -393,17 +438,24 @@ static void mmc_wait_done(struct mmc_request *mrq)
  *
  * Sets the done callback to be called when request is completed by the card.
  * Starts data mmc request execution
+ * If an ongoing transfer is already in progress, wait for the command line
+ * to become available before sending another command.
  */
 static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	mmc_wait_ongoing_tfr_cmd(host);
+
 	mrq->done = mmc_wait_data_done;
 	mrq->host = host;
 
+	init_completion(&mrq->cmd_completion);
+
 	err = mmc_start_request(host, mrq);
 	if (err) {
 		mrq->cmd->error = err;
+		mmc_complete_cmd(mrq);
 		mmc_wait_data_done(mrq);
 	}
 
@@ -414,12 +466,17 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	mmc_wait_ongoing_tfr_cmd(host);
+
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
 
+	init_completion(&mrq->cmd_completion);
+
 	err = mmc_start_request(host, mrq);
 	if (err) {
 		mrq->cmd->error = err;
+		mmc_complete_cmd(mrq);
 		complete(&mrq->completion);
 	}
 
@@ -483,8 +540,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 	return err;
 }
 
-static void mmc_wait_for_req_done(struct mmc_host *host,
-				  struct mmc_request *mrq)
+void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
 
@@ -525,6 +581,28 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 
 	mmc_retune_release(host);
 }
+EXPORT_SYMBOL(mmc_wait_for_req_done);
+
+/**
+ *	mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
+ *	@host: MMC host
+ *	@mrq: MMC request
+ *
+ *	mmc_is_req_done() is used with requests that have
+ *	mrq->cap_cmd_during_tfr = true. mmc_is_req_done() must be called after
+ *	starting a request and before waiting for it to complete. That is,
+ *	either in between calls to mmc_start_req(), or after mmc_wait_for_req()
+ *	and before mmc_wait_for_req_done(). If it is called at other times the
+ *	result is not meaningful.
+ */
+bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
+{
+	if (host->areq)
+		return host->context_info.is_done_rcv;
+	else
+		return completion_done(&mrq->completion);
+}
+EXPORT_SYMBOL(mmc_is_req_done);
 
 /**
  *	mmc_pre_req - Prepare for a new request
@@ -645,13 +723,18 @@ EXPORT_SYMBOL(mmc_start_req);
  *	@mrq: MMC request to start
  *
  *	Start a new MMC custom command request for a host, and wait
- *	for the command to complete. Does not attempt to parse the
- *	response.
+ *	for the command to complete. In the case of 'cap_cmd_during_tfr'
+ *	requests, the transfer is ongoing and the caller can issue further
+ *	commands that do not use the data lines, and then wait by calling
+ *	mmc_wait_for_req_done().
+ *	Does not attempt to parse the response.
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	__mmc_start_req(host, mrq);
-	mmc_wait_for_req_done(host, mrq);
+
+	if (!mrq->cap_cmd_during_tfr)
+		mmc_wait_for_req_done(host, mrq);
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b01e77de1a74..368bed70aa9d 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -133,8 +133,12 @@ struct mmc_request {
 	struct mmc_command	*stop;
 
 	struct completion	completion;
+	struct completion	cmd_completion;
 	void			(*done)(struct mmc_request *);/* completion function */
 	struct mmc_host		*host;
+
+	/* Allow other commands during this ongoing data transfer or busy wait */
+	bool			cap_cmd_during_tfr;
 };
 
 struct mmc_card;
@@ -146,6 +150,9 @@ extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *, int *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
+extern void mmc_wait_for_req_done(struct mmc_host *host,
+				  struct mmc_request *mrq);
+extern bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
 extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c22476d23b84..339485114721 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -281,6 +281,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
@@ -381,6 +382,9 @@ struct mmc_host {
 	struct mmc_async_req	*areq;		/* active async req */
 	struct mmc_context_info	context_info;	/* async synchronization info */
 
+	/* Ongoing data transfer that allows commands during transfer */
+	struct mmc_request	*ongoing_mrq;
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	struct fault_attr	fail_mmc_request;
 #endif
@@ -417,6 +421,7 @@ int mmc_power_restore_host(struct mmc_host *host);
 
 void mmc_detect_change(struct mmc_host *, unsigned long delay);
 void mmc_request_done(struct mmc_host *, struct mmc_request *);
+void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
-- 
1.9.1

