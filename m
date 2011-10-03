From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: core: move ->request() call from atomic context
Date: Mon,  3 Oct 2011 15:33:33 +0300
Message-ID: <1317645214-12316-2-git-send-email-adrian.hunter@intel.com>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835Ab1JCMdm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 08:33:42 -0400
In-Reply-To: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

mmc_request_done() is sometimes called from interrupt
or other atomic context.  Mostly all mmc_request_done()
does is complete(), however it contains code to retry
on error, which uses ->request().  As the error path
is certainly not performance critical, this may be
moved to the waiting function mmc_wait_for_req_done().

This allows ->request() to use runtime PM get_sync()
and guarantee it is never in an atomic context.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9698d8a..ec76949 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -141,12 +141,12 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	}
 
 	if (err && cmd->retries) {
-		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
-			mmc_hostname(host), cmd->opcode, err);
-
-		cmd->retries--;
-		cmd->error = 0;
-		host->ops->request(host, mrq);
+		/*
+		 * Request starter must handle retries - see
+		 * mmc_wait_for_req_done().
+		 */
+		if (mrq->done)
+			mrq->done(mrq);
 	} else {
 		mmc_should_fail_request(host, mrq);
 
@@ -253,7 +253,21 @@ static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 static void mmc_wait_for_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
-	wait_for_completion(&mrq->completion);
+	struct mmc_command *cmd;
+
+	while (1) {
+		wait_for_completion(&mrq->completion);
+
+		cmd = mrq->cmd;
+		if (!cmd->error || !cmd->retries)
+			break;
+
+		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
+			 mmc_hostname(host), cmd->opcode, cmd->error);
+		cmd->retries--;
+		cmd->error = 0;
+		host->ops->request(host, mrq);
+	}
 }
 
 /**
-- 
1.7.6

