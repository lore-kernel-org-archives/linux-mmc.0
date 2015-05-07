From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 11/14] mmc: core: Flag re-tuning is needed on CRC errors
Date: Thu,  7 May 2015 13:10:22 +0300
Message-ID: <1430993425-2777-12-git-send-email-adrian.hunter@intel.com>
References: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40207 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbbEGKNG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 06:13:06 -0400
In-Reply-To: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

CRC errors could possibly be alleviated by
re-tuning so flag re-tuning needed in those cases.
Note this has no effect if re-tuning has not been
enabled.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index adb6408..c93062b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -133,6 +133,12 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd = mrq->cmd;
 	int err = cmd->error;
 
+	/* Flag re-tuning needed on CRC errors */
+	if (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
+	    (mrq->data && mrq->data->error == -EILSEQ) ||
+	    (mrq->stop && mrq->stop->error == -EILSEQ))
+		mmc_retune_needed(host);
+
 	if (err && cmd->retries && mmc_host_is_spi(host)) {
 		if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
 			cmd->retries = 0;
-- 
1.9.1

