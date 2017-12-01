From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: core: Ensure cmd_completion is initialized
Date: Fri,  1 Dec 2017 14:55:30 +0200
Message-ID: <1512132931-12380-2-git-send-email-adrian.hunter@intel.com>
References: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbdLAMzx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Dec 2017 07:55:53 -0500
In-Reply-To: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

mmc_test now uses mmc_start_request() to test sending commands during
"ongoing" asynchronous transfers, i.e. tests:
	Commands during non-blocking read - use Set Block Count (CMD23)
	Commands during non-blocking write - use Set Block Count (CMD23)

mmc_start_request() was not initializing cmd_completion, but cmd_completion
is used by "ongoing" transfers, so move initialization of cmd_completion
into making mmc_start_request().

Fixes: cb39f61e9b1e ("mmc: core: Export a few functions needed for blkmq support")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 617802f45386..455abbf4f41e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -348,6 +348,8 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
+	init_completion(&mrq->cmd_completion);
+
 	mmc_retune_hold(host);
 
 	if (mmc_card_removed(host->card))
@@ -418,8 +420,6 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 	mrq->done = mmc_wait_data_done;
 	mrq->host = host;
 
-	init_completion(&mrq->cmd_completion);
-
 	err = mmc_start_request(host, mrq);
 	if (err) {
 		mrq->cmd->error = err;
@@ -439,8 +439,6 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
 
-	init_completion(&mrq->cmd_completion);
-
 	err = mmc_start_request(host, mrq);
 	if (err) {
 		mrq->cmd->error = err;
-- 
1.9.1

