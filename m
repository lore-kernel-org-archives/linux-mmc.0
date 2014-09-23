From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/6] mmc: block: Fix error recovery stop cmd timeout calculation
Date: Tue, 23 Sep 2014 23:00:28 +0300
Message-ID: <1411502430-25535-5-git-send-email-adrian.hunter@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbaIWUCA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:02:00 -0400
In-Reply-To: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Data timeout has two components: one in nanoseconds
and one in clock cycles.  Clock cycles were not being
added when using the data timeout for the error
recovery stop cmd timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5d27997..c3770dd 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -945,9 +945,19 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 	 */
 	if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
 	    R1_CURRENT_STATE(status) == R1_STATE_RCV) {
-		err = send_stop(card,
-			DIV_ROUND_UP(brq->data.timeout_ns, 1000000),
-			req, gen_err, &stop_status);
+		unsigned int timeout_ms, clock;
+
+		timeout_ms = DIV_ROUND_UP(brq->data.timeout_ns, 1000000);
+		if (brq->data.timeout_clks) {
+			clock = card->host->actual_clock;
+			if (!clock)
+				clock = card->host->ios.clock;
+			if (clock) {
+				clock = DIV_ROUND_UP(clock, 1000);
+				timeout_ms += brq->data.timeout_clks / clock;
+			}
+		}
+		err = send_stop(card, timeout_ms, req, gen_err, &stop_status);
 		if (err) {
 			pr_err("%s: error %d sending stop command\n",
 			       req->rq_disk->disk_name, err);
-- 
1.8.3.2

