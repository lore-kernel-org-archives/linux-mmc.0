From: Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v2] mmc: block: improve logging of handling emmc timeouts
Date: Tue, 10 May 2016 14:53:13 +0530
Message-ID: <1462872193-6213-1-git-send-email-amit.pundir@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33701 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcEJJXW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:23:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id 206so3870949pfu.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 02:23:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: ksumrall@android.com, adrian.hunter@intel.com, shawn.lin@rock-chips.com, jonathanh@nvidia.com, grundler@chromium.org, lporzio@micron.com, kernel-team@android.com, sumit.semwal@linaro.org, john.stultz@linaro.org

From: Ken Sumrall <ksumrall@android.com>

Add some logging to make it clear just how the emmc timeout
was handled.

Signed-off-by: Ken Sumrall <ksumrall@android.com>
[AmitP: cherry-picked this Android patch from aosp
        common kernel android-4.4]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v1...v2:
  Removed CC list from the commit log and skipped one print statement.
 
 drivers/mmc/card/block.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9c69e21..ddc9620 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -948,16 +948,22 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
 			req->rq_disk->disk_name, "timed out", name, status);
 
 		/* If the status cmd initially failed, retry the r/w cmd */
-		if (!status_valid)
+		if (!status_valid) {
+			pr_err("%s: status not valid, retrying timeout\n",
+				req->rq_disk->disk_name);
 			return ERR_RETRY;
+		}
 
 		/*
 		 * If it was a r/w cmd crc error, or illegal command
 		 * (eg, issued in wrong state) then retry - we should
 		 * have corrected the state problem above.
 		 */
-		if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND))
+		if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND)) {
+			pr_err("%s: command error, retrying timeout\n",
+				req->rq_disk->disk_name);
 			return ERR_RETRY;
+		}
 
 		/* Otherwise abort the command */
 		return ERR_ABORT;
-- 
2.7.4

